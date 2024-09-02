//
//  Activation_Response_Codes.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Activation_Response_Codes
{
    public static var Instance = Activation_Response_Codes()
    
    public enum CODE
    {
        case RA_RES_DENIED_UNKNOWN_SOURCE_ADDRESS
        case RA_RES_DENIED_ALL_SUPPORTED_SOCKETS_REGISTERED_AND_ACTIVE
        case RA_RES_DENIED_SOURCE_ADDRESS_MISMATCH
        case RA_RES_DENIED_SOURCE_ADDRESS_ACTIVE_OTHER_PORT
        case RA_RES_DENIED_MISSING_AUTHENTICATION
        case RA_RES_DENIED_REJECTED_CONFIRMATION
        case RA_RES_DENIED_UNSUPPORTED_ACTIVATION_TYPE
        case RA_RES_SUCCESS
        case RA_RES_CONFIRMATION_REQUIRED
        case RA_RES_RESERVED_ISO13400
        case RA_RES_VEHICLE_MANUFACTURER_SPECIFIC
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00: CODE.RA_RES_DENIED_UNKNOWN_SOURCE_ADDRESS,
        0x01: CODE.RA_RES_DENIED_ALL_SUPPORTED_SOCKETS_REGISTERED_AND_ACTIVE,
        0x02: CODE.RA_RES_DENIED_SOURCE_ADDRESS_MISMATCH,
        0x03: CODE.RA_RES_DENIED_SOURCE_ADDRESS_ACTIVE_OTHER_PORT,
        0x04: CODE.RA_RES_DENIED_MISSING_AUTHENTICATION,
        0x05: CODE.RA_RES_DENIED_REJECTED_CONFIRMATION,
        0x06: CODE.RA_RES_DENIED_UNSUPPORTED_ACTIVATION_TYPE,
        0x07: CODE.RA_RES_RESERVED_ISO13400,
        0x0F: CODE.RA_RES_RESERVED_ISO13400,
        0x10: CODE.RA_RES_SUCCESS,
        0x11: CODE.RA_RES_CONFIRMATION_REQUIRED,
        0x12: CODE.RA_RES_RESERVED_ISO13400,
        0xDF: CODE.RA_RES_RESERVED_ISO13400,
        0xE0: CODE.RA_RES_VEHICLE_MANUFACTURER_SPECIFIC,
        0xFE: CODE.RA_RES_VEHICLE_MANUFACTURER_SPECIFIC,
        0xFF: CODE.RA_RES_RESERVED_ISO13400,
    ]
    
    public func DECODE(Activation_Response_Value:UInt8) ->CODE
    {
        if(VALUE_TO_CODE.keys.contains(Activation_Response_Value))
        {
            return VALUE_TO_CODE[Activation_Response_Value]!
        }
        else
        {
            return CODE.RA_RES_RESERVED_ISO13400
        }
    }
}
