//
//  Vehicle_Announce_FurtherActions.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Vehicle_Announce_Further_Actions
{
    public enum CODE
    {
        case NO_FURTHER_ACTION_REQD
        case RESERVED_ISO13400
        case ROUTING_REQD_CENTRAL_SECURITY
        case OEM_SPECIFIC
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00: CODE.NO_FURTHER_ACTION_REQD,
        0x01: CODE.RESERVED_ISO13400,
        0x0F: CODE.RESERVED_ISO13400,
        0x10: CODE.ROUTING_REQD_CENTRAL_SECURITY,
        0x11: CODE.OEM_SPECIFIC,
        0xFF: CODE.OEM_SPECIFIC,
    ]
    
    public func DECODE(FurtherActions_Value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains(FurtherActions_Value))
        {
            return VALUE_TO_CODE[FurtherActions_Value]!
        }
        else
        {
            return CODE.OEM_SPECIFIC
        }
    }
}
