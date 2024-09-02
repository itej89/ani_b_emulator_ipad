//
//  Diagnostic_ACK_Code.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Diagnostic_ACK_Codes
{
    public static var Instance = Diagnostic_ACK_Codes()
    
    public enum CODE
    {
        case DIAG_ACK_PASS,
        DIAG_ACK_RESERVED_ISO13400
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00:CODE.DIAG_ACK_PASS,
        0x01:CODE.DIAG_ACK_RESERVED_ISO13400,
        0xFF:CODE.DIAG_ACK_RESERVED_ISO13400
    ]
    
    public func DECODE(ACK_Value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains(ACK_Value))
        {
            return VALUE_TO_CODE[ACK_Value]!
        }
        else
        {
            return CODE.DIAG_ACK_RESERVED_ISO13400
        }
    }
    
}
