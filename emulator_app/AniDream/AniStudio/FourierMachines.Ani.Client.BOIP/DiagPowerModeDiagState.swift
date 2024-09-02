//
//  DiagPowerModeDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DiagPowerModeDiagState:IDiagStateForSendRecieve
{
    public var ValidationErrors: ValidationRuleMessages
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func _Init(arrDataToBeSent: [UInt8]?) -> Int {
        UDPListen.Instance.StartListening(remoteEndPoint: nil)
        if(UDPListen.Instance.ValidationErrors.Messages.count == 0)
        {
            var data:[UInt8]? = nil
            var returnStatus:(Int, [UInt8]?) = FormatRequest()
            if(returnStatus.0 == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
            {
                data = returnStatus.1
                if(data != nil)
                {
                    returnStatus.0 = SendData(data: data!)
                }
                return returnStatus.0
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
    
    public func HandleIncomingData(objResponse: DOIPResponseObject?) -> (Int, [UInt8]?) {
        var retStatus = -1
        let bufferResponse:[UInt8]? = nil
        
        if(objResponse != nil)
        {
            let Payload:Payload_Diagnostic_Power_Mode_Response? = (objResponse!.GetPayload() as! Payload_Diagnostic_Power_Mode_Response)
            
            if(Payload != nil)
            {
                let code:Diagnostic_Power_mode_Values.CODE = Diagnostic_Power_mode_Values.Instance.CODE(NAK_Value: (Payload?.GetDiagnosticPowerMode())!)
                
                if(Payload!.ValidationErrors.Messages.count > 0)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
                    return (retStatus, bufferResponse!)
                }
                
                if(code == Diagnostic_Power_mode_Values.CODE.DIAG_POWER_MODE_READY)
                {
                    if(DOIPParameters.Instance.DoIPEntityStatusSupported == 1)
                    {
                        DOIPAccessImplementation.Instance.setCurrentState(newState: DoIPEntityStatusDiagState())
                        
                        retStatus = DOIPAccessImplementation.Instance.MoveNext()
                         return (retStatus, bufferResponse!)
                    }
                    else
                    {
                        return (DIAGNOSTIC_STATUS.CODE.COMPLETE.rawValue, bufferResponse!)
                    }
                }
                else
                {
                    return (DIAGNOSTIC_STATUS().DiagPowerModeCode_ErrorCode[code]!, bufferResponse!)
                }
                
                
//                return (DIAGNOSTIC_STATUS.CODE.COMPLETE.rawValue, bufferResponse)
            }
            else
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "DoIP Entity Status Information Response Payload"))
                return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
            }
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "DoIP Entity Status Information Response Object"))
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
        }
    }
    
    
    func FormatRequest() -> (Int, [UInt8]?)
    {
        var data:[UInt8]? = nil
        
        let formatRequest:DOIPFrameSynthesizer = DOIPFrameSynthesizer()
        
        let request:DOIPRequestObject = formatRequest.FormHeaderForDoIPFrame(payloadType: Request_Payload_Types.CODE.PLD_DIAG_POWER_MODE_REQ)
        
        data  = formatRequest.CreateDOIPFrame(DOIPObject: request)
        
        return (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue, data)
    }
    
    func SendData(data:[UInt8]) -> Int
    {
        UDPRequest.Instance.Send(packet: data)
        if(UDPRequest.Instance.ValidationErrors.Messages.count > 0)
        {
            return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
        }
        else
        {
            return DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
        }
    }
    
}
