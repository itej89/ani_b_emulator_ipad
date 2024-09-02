//
//  Payload_Diagnostic_StatusResponse.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Diagnostic_Status_Response:PayloadObject
{
    public func Initialize_PayloadItems()
    {
        Payload = [
            TAG.NODE_TYPE: Payload_Item_Type(_Position: 0,_Length: 1),
            TAG.MAX_CONCURRENT_TCP_SOCKETS: Payload_Item_Type(_Position: 1,_Length: 1),
            TAG.CURRENT_OPEN_TCP_SOCKETS: Payload_Item_Type(_Position: 2,_Length: 1),
            TAG.MAX_DATA_SIZE: Payload_Item_Type(_Position: 3),
        ]
    }
    
    public  init(DOIPPayload:[UInt8]) {
        super.init()
        Initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func GetNodeType() -> UInt8
    {
        if(Payload[TAG.NODE_TYPE]?.RawData != nil)
        {
            return (Payload[TAG.NODE_TYPE]?.RawData[0])!
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY,MethodInfo: "Payload_Diagnostic_Status_Response:GetNodeType",strAdditionalInfo: ""))
            return 0x00
        }
    }
    
    public func GetMaxTCPConnections() -> UInt8
    {
        if(Payload[TAG.MAX_CONCURRENT_TCP_SOCKETS]?.RawData != nil)
        {
            return (Payload[TAG.MAX_CONCURRENT_TCP_SOCKETS]?.RawData[0])!
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Diagnostic_Status_Response:GetMaxTCPConnections", strAdditionalInfo: ""))
            return 0x00
        }
    }
    
    public func GetNumberOfCurrentOpenTCPConnections() -> UInt8
    {
        if(Payload[TAG.CURRENT_OPEN_TCP_SOCKETS]?.RawData != nil)
        {
            return (Payload[TAG.CURRENT_OPEN_TCP_SOCKETS]?.RawData[0])!
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Diagnostic_Status_Response:GetNumberOfCurrentOpenTCPConnections", strAdditionalInfo: ""))
            return 0x00
        }
    }
    
    public func GetMAxDataSize() -> [UInt8]!
    {
        return Payload[TAG.MAX_DATA_SIZE]?.RawData
    }
}
