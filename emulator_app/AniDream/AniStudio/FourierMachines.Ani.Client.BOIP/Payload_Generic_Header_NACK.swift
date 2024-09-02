//
//  Payload_Generic_Header_NAK.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Generic_Header_NACK:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload=[
            TAG.HEADER_NACK:Payload_Item_Type(_Position: 0,_Length: 1)
        ]
    }
        public init(DOIPPayload:[UInt8])
        {
            super.init()
            initialize_PayloadItems()
            Decode_Payload(DOIPPayload: DOIPPayload)
        }
        
        public func GetNAK() -> UInt8
        {
            if(Payload[TAG.HEADER_NACK]?.RawData != nil)
            {
                return (Payload[TAG.HEADER_NACK]?.RawData[0])!
            }
            else
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Generic_Header_NAK:GetNAK", strAdditionalInfo: ""))
                return 0x00
            }
        }
}

