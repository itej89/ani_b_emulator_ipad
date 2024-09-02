//
//  DiagMessageNAKDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class DiagMessageNAKDiagState:IDiagState
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
            let Payload:Payload_Diagnostic_Message_Nack? = (objResponse!.GetPayload() as! Payload_Diagnostic_Message_Nack)
            
            if(Payload != nil)
            {
                let code:Diagnostic_NAK_Codes.CODE = Diagnostic_NAK_Codes.Instance.DECODE(NAK_Value: (Payload?.GetNAK())!)
                if(Payload!.ValidationErrors.Messages.count > 0)
                {
                    retStatus = DIAGNOSTIC_STATUS.CODE.INTERNAL_ERROR.rawValue
                    return (retStatus, bufferResponse!)
                }
                
                
                return (DIAGNOSTIC_STATUS().DiagNACKCode_ErrorCode[code]!, bufferResponse)
                
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
