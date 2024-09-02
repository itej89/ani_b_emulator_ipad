//
//  DOIP_Status_Node_Type.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIP_Status_Node_Type
{
    public static var Instance = DOIP_Status_Node_Type()
    
    public enum CODE
    {
        case DOIP_STATUS_DOIP_GATEWAY
        case DOIP_STATUS_DOIP_NODE
        case DOIP_STATUS_RESERVED_ISO13400
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00: CODE.DOIP_STATUS_DOIP_GATEWAY,
        0x01: CODE.DOIP_STATUS_DOIP_NODE,
        0x02: CODE.DOIP_STATUS_RESERVED_ISO13400,
        0xFF: CODE.DOIP_STATUS_RESERVED_ISO13400,
    ]
    
    public func DECODE(NAK_Value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains(NAK_Value))
        {
            return VALUE_TO_CODE[NAK_Value]!
        }
        else
        {
            return CODE.DOIP_STATUS_RESERVED_ISO13400
        }
    }
    
}
