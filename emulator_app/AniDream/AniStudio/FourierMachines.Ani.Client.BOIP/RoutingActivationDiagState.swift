//
//  RoutingActivationDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class RoutingActivationDiagState:IDiagStateForSendRecieve
{
    var data:[UInt8]? = nil
    var _activationRepeatCount:Int = 0
    
    
    public var ValidationErrors: ValidationRuleMessages
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func _Init(arrDataToBeSent: [UInt8]?) -> Int {
        TcpClient.Instance.TcpClientInit()
        if(TcpClient.Instance.ValidationErrors.Messages.count == 0)
        {
            var IsConnectionEstablished:Bool = false
            repeat{
                IsConnectionEstablished = TcpClient.Instance.TryConnect()
                sleep(1)
            }while (!IsConnectionEstablished)
            
            if(TcpClient.Instance.ValidationErrors.Messages.count == 0 && IsConnectionEstablished)
            {
                var retStatus = FormatRequest()
                data  = retStatus.1
                if(retStatus.0 == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
                {
                    if(retStatus.1 != nil){
                        retStatus.0 = SendData(data: retStatus.1!)
                    }
                }
                return  retStatus.0
            }
            else
            {
                 return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
            }
        }
            
        else
        {
            return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
        }
    }
    
    private func FormatRequest() -> (Int, [UInt8]?)
    {
        var data:[UInt8]? = nil
        
        let formatRequest:DOIPFrameSynthesizer = DOIPFrameSynthesizer()
        
        let objRoutingActivationPAyload:Payload_Routing_Activation_Requests = Payload_Routing_Activation_Requests()
        
        if(DOIPSession.Instance.getInvalidAddresses().contains(DOIPParameters.Instance.TesterAddress))
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Tester Address from configuration"))
            
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, data)
        }
        else
        {
            objRoutingActivationPAyload.SetSourceAddress(SA: DOIPParameters.Instance.TesterAddress)
        }
        objRoutingActivationPAyload.SetActivationType(ActivationType: DOIPParameters.Instance.RoutingActivationType)
        objRoutingActivationPAyload.SetISOReserved(Reserved: DOIPParameters.Instance.A_DOIP_Activation_Request_ISO_RESERVED)
        
        if(DOIPParameters.Instance.Activation_Request_OEM_BYTES_ENABLED == 1)
        {
            objRoutingActivationPAyload.SetOEMReserved(Reserved: DOIPParameters.Instance.A_DOIP_Activation_Request_OEM_SPECIFIC)
        }
        
        let request:DOIPRequestObject = formatRequest.FormHeaderForDoIPFrame(payloadType: Request_Payload_Types.CODE.PLD_ROUTING_ACTIVATION_REQ)
        
        request.SetPayload(_Payload: objRoutingActivationPAyload)
        
        data = formatRequest.CreateDOIPFrame(DOIPObject: request)
        
        return (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue, data)
        
    }
    
    public func HandleIncomingData(objResponse: DOIPResponseObject?) -> (Int, [UInt8]?) {
        var retStatus = -1
        let bufferResponse:[UInt8]? = nil
        
        if(objResponse != nil)
        {
            let Payload:Payload_Routing_Activation_Response? = (objResponse!.GetPayload() as! Payload_Routing_Activation_Response)
            
            if(Payload != nil)
            {
                let code:Activation_Response_Codes.CODE = Activation_Response_Codes.Instance.DECODE(Activation_Response_Value: (Payload?.GetRoutingActivationResponseCode())!)
                
                if(Payload!.ValidationErrors.Messages.count > 0)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
                    return (retStatus, bufferResponse)
                }
                
                if(code == Activation_Response_Codes.CODE.RA_RES_CONFIRMATION_REQUIRED)
                {
                    if(_activationRepeatCount < DOIPParameters.Instance.DOIP_ACTIVATION_CONFIRMATION_REPEAT_COUNT)
                    {
                        if(data != nil)
                        {
                            retStatus = SendData(data: data!)
                            if(retStatus == (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue))
                            {
                                return (retStatus, bufferResponse)
                            }
                            else
                            {
                                _activationRepeatCount = _activationRepeatCount + 1
                                usleep(useconds_t(DOIPParameters.Instance.DOIP_ACTIVATION_CONFIRMATION_REPEAT_TIME * 1000))
                                
                                return (retStatus, bufferResponse)
                                
                            }
                            
                        }
                        else
                        {
                            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
                        }
                    }
                    else
                    {_activationRepeatCount = 0
                        return (DIAGNOSTIC_STATUS.CODE.ACTIVATIOMN_CONFIRMATION_TIMEOUT.rawValue, bufferResponse)
                        
                    }
                    
                    
                    
                }
                else if(code != Activation_Response_Codes.CODE.RA_RES_SUCCESS)
                {
                    retStatus = DIAGNOSTIC_STATUS().ResponseCode_ErrorCode[code]!
                    return (retStatus, bufferResponse)
                }
                
            }
            else
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Routing Activation Response Payload"))
                return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
            }
            
            if((Payload?.GetDOIPEntityLogicalAddress()) != nil)
            {
            DOIPSession.Instance.TargetAddress = (Payload?.GetDOIPEntityLogicalAddress())!
            }
            
            DOIPAccessImplementation.Instance.StartCheckkForTCPConnectionAlive()
             DOIPAccessImplementation.Instance.ResultConvey.LinkConnected(EndPoint: objResponse!.EndPoint)
            return (DIAGNOSTIC_STATUS.CODE.COMPLETE.rawValue, bufferResponse)
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Routing Activation Response Object"))
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
        }
        
//        if(DOIPParameters.Instance.DiagPowerModeSupported == 1)
//        {
//            DoIPTesterContext.Instance.setCurrentState(newState: DiagPowerModeDiagState())
//            retStatus = DoIPTesterContext.Instance.MoveNext()
//        }
//        else
//        {
//            if(DOIPParameters.Instance.DoIPEntityStatusSupported == 1)
//            {
//                DoIPTesterContext.Instance.setCurrentState(newState: DoIPEntityStatusDiagState())
//                retStatus = DoIPTesterContext.Instance.MoveNext()
//            }
//        }
//        else
        
      
        
       
        
       
        
    }
    
    public func SendData(data:[UInt8]) -> Int
    {
        TcpClient.Instance.SendData(data: data)
        if(TcpClient.Instance.ValidationErrors.Messages.count > 0)
        {
            return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
        }
        else
        {
            return DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
        }
    }
}

