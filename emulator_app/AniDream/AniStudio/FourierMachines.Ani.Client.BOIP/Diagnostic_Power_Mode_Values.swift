//
//  Diagnostic_Power_Mode_Values.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Diagnostic_Power_mode_Values
{
    public static var Instance = Diagnostic_Power_mode_Values()
    
    public enum CODE
    {
        case DIAG_POWER_MODE_NOT_READY
        case DIAG_POWER_MODE_READY
        case DIAG_POWER_MODE_NOT_SUPPORTED
        case DIAG_POWER_MODE_RESERVED_ISO13400
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00: CODE.DIAG_POWER_MODE_NOT_READY,
        0x01: CODE.DIAG_POWER_MODE_READY,
        0x02: CODE.DIAG_POWER_MODE_NOT_SUPPORTED,
        0x03: CODE.DIAG_POWER_MODE_RESERVED_ISO13400,
        0xFF: CODE.DIAG_POWER_MODE_RESERVED_ISO13400,
    ]
    
    public func CODE(NAK_Value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains(NAK_Value))
        {
            return VALUE_TO_CODE[NAK_Value]!
        }
        else
        {
            return .DIAG_POWER_MODE_RESERVED_ISO13400
        }
    }
}
