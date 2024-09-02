//
//  Response_Payload_Types.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Response_Payload_Types
{
    public static let Instance = Response_Payload_Types()
    
    public enum CODE
    {
        case PLD_DOIP_HEADER_NAK
        case PLD_VEH_IDEN_RES
        case PLD_ROUTING_ACTIVATION_RES
        case PLD_ALIVE_CHECK_REQ
        case PLD_DOIP_ENTITY_STATUS_RES
        case PLD_DIAG_POWER_MODE_RES
        case PLD_RESERVED_ISO13400
        case PLD_DIAG_MESSAGE
        case PLD_DIAG_MESSAGE_POSITIVE_ACK
        case PLD_DIAG_MESSAGE_NEGATIVE_ACK
        case PLD_MANUFACTURER_SPECIFIC_ACK
        case DOIPTester_UNKNOWN_CODE
    }
    
    public var VALUE_TO_CODE:[UInt16:CODE] = [
        0x0000:CODE.PLD_DOIP_HEADER_NAK,
        0x0004:CODE.PLD_VEH_IDEN_RES,
        0x0006:CODE.PLD_ROUTING_ACTIVATION_RES,
        0x0007:CODE.PLD_ALIVE_CHECK_REQ,
        0x0009:CODE.PLD_RESERVED_ISO13400,
        0x4000:CODE.PLD_RESERVED_ISO13400,
        0x4002:CODE.PLD_DOIP_ENTITY_STATUS_RES,
        0x4004:CODE.PLD_DIAG_POWER_MODE_RES,
        0x4005:CODE.PLD_RESERVED_ISO13400,
        0x8000:CODE.PLD_RESERVED_ISO13400,
        0x8001:CODE.PLD_DIAG_MESSAGE,
        0x8002:CODE.PLD_DIAG_MESSAGE_POSITIVE_ACK,
        0x8003:CODE.PLD_DIAG_MESSAGE_NEGATIVE_ACK,
        0x8004:CODE.PLD_RESERVED_ISO13400,
        0xEFFF:CODE.PLD_RESERVED_ISO13400,
        0xF000:CODE.PLD_MANUFACTURER_SPECIFIC_ACK,
        0xFFFF:CODE.PLD_MANUFACTURER_SPECIFIC_ACK,
    ]
    
    public func DECODE(Payload_Type_Value:[UInt8]) -> CODE
    {
        let data = Data(bytes: Payload_Type_Value)
        let value = UInt16(bigEndian: data.withUnsafeBytes { $0.pointee })
        if(VALUE_TO_CODE.keys.contains(value))
        {
            return VALUE_TO_CODE[value]!
        }
        else{
            return CODE.DOIPTester_UNKNOWN_CODE
        }
    }
}
