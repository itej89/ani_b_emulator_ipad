//
//  Diagnostic_ACK_Codes.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Diagnostic_NAK_Codes
{
    public static var Instance = Diagnostic_NAK_Codes()
    
    public enum CODE
    {
        case DIAG_NAK_INVALID_SOURCE_ADDRESS
        case DIAG_NAK_UNKOWN_TARGET
        case DIAG_NAK_MESSAGE_TOO_LARGE
        case DIAG_NAK_OUT_OF_MEMORY
        case DIAG_NAK_TARGET_UNREACHABLE
        case DIAG_NAK_RESERVED_ISO13400
        case DIAG_NAK_UNKOWN_NETWORK
        case DAIG_NAK_TRANSPORT_PROTOCOL_ERROR
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00: CODE.DIAG_NAK_RESERVED_ISO13400,
        0x01: CODE.DIAG_NAK_RESERVED_ISO13400,
        0x02: CODE.DIAG_NAK_INVALID_SOURCE_ADDRESS,
        0x03: CODE.DIAG_NAK_UNKOWN_TARGET,
        0x04: CODE.DIAG_NAK_MESSAGE_TOO_LARGE,
        0x05: CODE.DIAG_NAK_OUT_OF_MEMORY,
        0x06: CODE.DIAG_NAK_TARGET_UNREACHABLE,
        0x07: CODE.DIAG_NAK_UNKOWN_NETWORK,
        0x08: CODE.DAIG_NAK_TRANSPORT_PROTOCOL_ERROR,
        0x09: CODE.DIAG_NAK_RESERVED_ISO13400,
        0xFF: CODE.DIAG_NAK_RESERVED_ISO13400,
    ]
    
    public func DECODE(NAK_Value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains((NAK_Value)))
        {
            return VALUE_TO_CODE[NAK_Value]!
        }
        else
        {
            return .DIAG_NAK_RESERVED_ISO13400
        }
    }
    
}
