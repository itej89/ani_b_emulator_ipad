//
//  AliveCheckDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class AliveCheckDiagState:IDiagStateForSendRecieve
{
    public var ValidationErrors: ValidationRuleMessages
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func _Init(arrDataToBeSent: [UInt8]?) -> Int {
        
            var returnStatus:(Int, [UInt8]?) = FormatRequest()
            if(returnStatus.0 == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
            {
                if(returnStatus.1 != nil)
                {
                    returnStatus.0 = SendData(data: returnStatus.1!)
                }
                return returnStatus.0
            }
            else
            {
                return DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
            }
      
    }
    
    public func HandleIncomingData(objResponse: DOIPResponseObject?) -> (Int, [UInt8]?) {
       
        let bufferResponse:[UInt8]? = nil
        
        if(objResponse != nil)
        {
            return (_Init(arrDataToBeSent: nil), bufferResponse)
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, strAdditionalInfo: "Alive Check Request Object"))
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
        }
    }
    
    
    func FormatRequest() -> (Int, [UInt8]?)
    {
        var data:[UInt8]? = nil
        
        let formatRequest:DOIPFrameSynthesizer = DOIPFrameSynthesizer()
        
        let objAliveCheckPayload:Payload_Alive_Check_Response = Payload_Alive_Check_Response()
        objAliveCheckPayload.SetSourceAddress(SA: DOIPParameters.Instance.TesterAddress)
        
        let request:DOIPRequestObject = formatRequest.FormHeaderForDoIPFrame(payloadType: Request_Payload_Types.CODE.PLD_ALIVE_CHECK_RES)
        
        request.SetPayload(_Payload: objAliveCheckPayload)
        
        data  = formatRequest.CreateDOIPFrame(DOIPObject: request)
        
        return (DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue, data)
    }
    
    func SendData(data:[UInt8]) -> Int
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
