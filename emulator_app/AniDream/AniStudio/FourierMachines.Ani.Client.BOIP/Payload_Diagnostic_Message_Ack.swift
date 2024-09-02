//
//  Payload_Diagnostic_Message_Ack.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class Payload_Diagnostic_Message_Ack:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.SOURCE_ADDRESS: Payload_Item_Type(_Position: 0,_Length: 2),
            TAG.TARGET_ADDRESS: Payload_Item_Type(_Position: 2,_Length: 2),
            TAG.ACK: Payload_Item_Type(_Position: 4,_Length: 1),
            TAG.PREVIOUS_DIAGNOSTIC_DATA: Payload_Item_Type(_Position: 5)
        ]
    }
    
    public  init(DOIPPayload:[UInt8]) {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func GetSourceAddress() -> [UInt8]!
    {
        return (Payload[TAG.SOURCE_ADDRESS]?.RawData)
    }
    
    public func GetTargetAddress() -> [UInt8]!
    {
        return (Payload[TAG.TARGET_ADDRESS]?.RawData)
    }
    
    public func GetAcknowledgement() -> UInt8
    {
        if((Payload[TAG.ACK]?.RawData) != nil)
        {
            return ((Payload[TAG.ACK]?.RawData[0])!)
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Diagnostic_Message_NAck:GetNAK" , strAdditionalInfo: ""))
            return 0x00
        }
    }
    
    public func GetValidationData() -> [UInt8]!
    {
        if(Payload[TAG.PREVIOUS_DIAGNOSTIC_DATA] != nil)
        {
            return Payload[TAG.PREVIOUS_DIAGNOSTIC_DATA]!.RawData
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.NO_PREVIOUS_DIAGNOSTIC_DATA, MethodInfo: "Payload_Diagnostic_Message_NAck:GetPreviousDiagnosticMessage" ,strAdditionalInfo: ""))
            return nil
        }
    }
    
}

