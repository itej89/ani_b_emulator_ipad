//
//  DiagMessagePosACKDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class DiagMessagePosACKDiagState:IDiagState
{
    public var ValidationErrors: ValidationRuleMessages
    
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func HandleIncomingData(objResponse: DOIPResponseObject?) -> (Int, [UInt8]?) {
        var retStatus = -1
        let bufferResponse:[UInt8]? = nil
        
        if(objResponse != nil)
        {
            let Payload:Payload_Diagnostic_Message_Ack? = (objResponse!.GetPayload() as! Payload_Diagnostic_Message_Ack)
            
            if(Payload != nil)
            {
                let ack = Payload?.GetAcknowledgement()
                if(Payload!.ValidationErrors.Messages.count > 0)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
                    return (retStatus, bufferResponse!)
                }
                else
                if(Diagnostic_ACK_Codes.Instance.DECODE(ACK_Value: ack!) == Diagnostic_ACK_Codes.CODE.DIAG_ACK_PASS)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue
                    return (retStatus, bufferResponse!)
                }
                else
                    {
                        retStatus = DIAGNOSTIC_STATUS.CODE.RESERVED_ISO13400.rawValue
                        return (retStatus, bufferResponse!)
                    }
                
            }
            else
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Generic Header NAK Payload"))
                return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
            }
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Generic Header NAK Object"))
            return (DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue, bufferResponse)
        }
    }
}
