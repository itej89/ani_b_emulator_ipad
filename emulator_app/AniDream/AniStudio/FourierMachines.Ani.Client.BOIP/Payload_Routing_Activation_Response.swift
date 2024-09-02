//
//  Payload_Routing_Activation_Response.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Routing_Activation_Response:PayloadObject
{
    public func initilize_PayloadItems()
    {
        Payload = [
            TAG.LOGICAL_ADDRESS_TEST_EQUIPMENT:Payload_Item_Type(_Position: 0,_Length: 2),
            TAG.LOGICAL_ADDRESS_DOIP_ENTITY:Payload_Item_Type(_Position: 2,_Length: 2),
            TAG.ROUTING_ACTIVATION_RESPONSE_CODE:Payload_Item_Type(_Position: 4,_Length: 1),
            TAG.ISO_RESERVED:Payload_Item_Type(_Position: 5,_Length: 4),
            TAG.OEM_RESERVED:Payload_Item_Type(_Position: 9)
        ]
    }
    
    public init(DOIPPayload:[UInt8]) {
        super.init()
        initilize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func GetTestEquipmentLogicalAddress() -> [UInt8]!
    {
        return Payload[TAG.LOGICAL_ADDRESS_TEST_EQUIPMENT]?.RawData
    }
    
    public func GetDOIPEntityLogicalAddress() -> [UInt8]!
    {
        return Payload[TAG.LOGICAL_ADDRESS_DOIP_ENTITY]?.RawData
    }
    
    public func GetRoutingActivationResponseCode() -> UInt8
    {
        if((Payload[TAG.ROUTING_ACTIVATION_RESPONSE_CODE]?.RawData != nil))
        {
            return (Payload[TAG.ROUTING_ACTIVATION_RESPONSE_CODE]?.RawData[0])!
        }
        else
        {
            return 0x00
        }
    }
    
    public func GetISOReserved() -> [UInt8]!
    {
        if((Payload[TAG.ISO_RESERVED]?.RawData != nil))
        {
            return (Payload[TAG.ISO_RESERVED]?.RawData)!
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Routing_Activation_Response:GetISOReserved", strAdditionalInfo: ""))
            return nil
        }
    }
    
    public func GetOEMReserved() -> [UInt8]!
    {
        if((Payload[TAG.OEM_RESERVED]?.RawData != nil))
        {
            return (Payload[TAG.OEM_RESERVED]?.RawData)!
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Routing_Activation_Response:GetOEMReserved", strAdditionalInfo: ""))
            return nil
        }
    }
    
    
    
}
