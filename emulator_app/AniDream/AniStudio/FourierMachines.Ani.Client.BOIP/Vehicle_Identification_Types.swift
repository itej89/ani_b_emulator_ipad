//
//  Vehicle_Identification_Types.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Vehicle_Identification_Types
{
    public static var Instance = Vehicle_Identification_Types()
    
    public enum CODE
    {
        case VEHICLE_IDENTIFICATION
        case VEHICLE_IDENTIFICATION_VIN
        case VEHICLE_IDENTIFICATION_EID
    }
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x01:CODE.VEHICLE_IDENTIFICATION,
        0x02: CODE.VEHICLE_IDENTIFICATION_EID,
        0x03: CODE.VEHICLE_IDENTIFICATION_VIN
    ]
    
    public func IsIdentificationMode(Mode:UInt8) -> Bool
    {
        return VALUE_TO_CODE.keys.contains(Mode)
    }
    
    public func DECODE(Vehicle_Identification_Value:UInt8)->CODE
    {
        if(VALUE_TO_CODE.keys.contains(Vehicle_Identification_Value))
        {
            return VALUE_TO_CODE[Vehicle_Identification_Value]!
        }
        else
        {
            return CODE.VEHICLE_IDENTIFICATION
        }
    }
}
