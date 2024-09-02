//
//  Payload_Routing_Activation_Request.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Routing_Activation_Requests:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.SOURCE_ADDRESS:Payload_Item_Type(_Position: 0,_Length: 2),
            TAG.ACTIVATION_TYPE:Payload_Item_Type(_Position: 2,_Length: 1),
            TAG.ISO_RESERVED:Payload_Item_Type(_Position: 3,_Length: 4),
            TAG.OEM_RESERVED:Payload_Item_Type(_Position: 7)
        ]
    }
    
    public override init() {
        super.init()
        initialize_PayloadItems()
    }
    
    public  init(DOIPPayload:[UInt8]) {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func SetSourceAddress(SA:[UInt8])
    {
        Payload[TAG.SOURCE_ADDRESS]?.RawData = SA
    }
    
    public func SetActivationType(ActivationType:UInt8)
    {
        Payload[TAG.ACTIVATION_TYPE]?.RawData = [ActivationType]
    }
    
    public func SetISOReserved(Reserved:[UInt8])
    {
        Payload[TAG.ISO_RESERVED]?.RawData = Reserved
    }
    
    public func SetOEMReserved(Reserved:[UInt8])
    {
        Payload[TAG.OEM_RESERVED]?.RawData = Reserved
    }
    
    public override func TotalNumberOfBytesInPayload() -> UInt64 {
        var ValidData_Length:UInt64 = 0
        
        for pair in Payload
        {
            if(pair.value.RawData != nil)
            {
                ValidData_Length = ValidData_Length + UInt64(pair.value.RawData.count)
            }
        }
        return ValidData_Length
    }
    
    public  override  func Make_Payload() -> [UInt8]!
    {
        let Required_Payload_Length = TotalNumberOfBytesInPayload()
        
        if(Required_Payload_Length != 0)
        {
            if(Payload[TAG.SOURCE_ADDRESS]?.RawData == nil)
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.NO_SOURCE_ADDRESS, MethodInfo: "Payload_Routing_Activation_Request:Make_Payload",strAdditionalInfo: ""))
            }
            
            var DOIP_Payload:[UInt8] = [UInt8](repeating: 0, count: Int(Required_Payload_Length))
            
            if(Payload[TAG.OEM_RESERVED]?.RawData != nil)
            { DOIP_Payload.replaceSubrange((Payload[TAG.OEM_RESERVED]?.Position)!..<(Payload[TAG.OEM_RESERVED]?.Position)!+(Payload[TAG.OEM_RESERVED]?.RawData!)!.count, with: (Payload[TAG.OEM_RESERVED]?.RawData!)!)
            }
            DOIP_Payload.replaceSubrange((Payload[TAG.SOURCE_ADDRESS]?.Position)!..<(Payload[TAG.SOURCE_ADDRESS]?.Position)!+(Payload[TAG.SOURCE_ADDRESS]?.RawData!)!.count, with: (Payload[TAG.SOURCE_ADDRESS]?.RawData!)!)
            DOIP_Payload.replaceSubrange((Payload[TAG.ACTIVATION_TYPE]?.Position)!..<(Payload[TAG.ACTIVATION_TYPE]?.Position)!+(Payload[TAG.ACTIVATION_TYPE]?.RawData!)!.count, with: (Payload[TAG.ACTIVATION_TYPE]?.RawData!)!)
            DOIP_Payload.replaceSubrange((Payload[TAG.ISO_RESERVED]?.Position)!..<(Payload[TAG.ISO_RESERVED]?.Position)!+(Payload[TAG.ISO_RESERVED]?.RawData!)!.count, with: (Payload[TAG.ISO_RESERVED]?.RawData!)!)
            
            return DOIP_Payload
        }
        
         ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.NO_PAYLOAD_ITEMS_FOUND, MethodInfo: "Payload_Routing_Activation_Request:Make_Payload",strAdditionalInfo: ""))
        
        return nil
    }
}
