//
//  Payload_Diagnostic_Power_Mode_Response.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Diagnostic_Power_Mode_Response:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.DIAGNOSTIC_POWER_MODE: Payload_Item_Type(_Position: 0,_Length: 1)
        ]
    }
    
    public  init(DOIPPayload:[UInt8]) {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func GetDiagnosticPowerMode() -> UInt8
    {
        if(Payload[TAG.DIAGNOSTIC_POWER_MODE]?.RawData != nil)
        {
            return (Payload[TAG.DIAGNOSTIC_POWER_MODE]?.RawData[0])!
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Diagnostic_Power_Mode_Response:GetDiagnosticPowerMode" ,strAdditionalInfo: ""))
            return 0x00
        }
    }
}

