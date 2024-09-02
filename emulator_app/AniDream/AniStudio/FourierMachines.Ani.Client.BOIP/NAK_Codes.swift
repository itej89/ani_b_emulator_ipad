//
//  NAK_Codes.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class NAK_Codes
{
    public static var Instance = NAK_Codes()
    
    public enum CODE
    {
        case NAK_INCORRECT_PATTERN
        case NAK_UNKNOWN_PAYLOAD
        case NAK_MESSAGE_TOO_LARGE
        case NAK_OUT_OF_MEMORY
        case NAK_INVALID_PAYLOAD_LENGTH
        case NAK_RESERVED_ISO13400
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00: CODE.NAK_INCORRECT_PATTERN,
        0x01: CODE.NAK_UNKNOWN_PAYLOAD,
        0x02: CODE.NAK_MESSAGE_TOO_LARGE,
        0x03: CODE.NAK_OUT_OF_MEMORY,
        0x04: CODE.NAK_INVALID_PAYLOAD_LENGTH,
        0x05: CODE.NAK_RESERVED_ISO13400,
        0xFF: CODE.NAK_RESERVED_ISO13400,
    ]
    
    public func DECODE(NAK_Value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains(NAK_Value))
        {
            return VALUE_TO_CODE[NAK_Value]!
        }
        else
        {
            return CODE.NAK_RESERVED_ISO13400
        }
    }
}
