//
//  ACK.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum ACK:String
{
    case OK
    case ERROR
    case WRONG_CLIENT_ID
    case INVALID_CATEGORY
    case INVALID_DATA
    case INVALID_COMMAND
    case CONNECTION_DENIED
    case MD5_MISMATCH
    case PART_MISSING
    case NA
    
    func GetString(type:ACK) -> String
    {
        switch type {
        case .NA:
            return ACK.NA.rawValue
        case .OK:
            return ACK.OK.rawValue
        case .ERROR:
            return ACK.ERROR.rawValue
        case .WRONG_CLIENT_ID:
            return ACK.WRONG_CLIENT_ID.rawValue
        case .INVALID_CATEGORY:
            return ACK.INVALID_CATEGORY.rawValue
        case .INVALID_DATA:
            return ACK.INVALID_DATA.rawValue
        case .INVALID_COMMAND:
            return ACK.INVALID_COMMAND.rawValue
        case .CONNECTION_DENIED:
            return ACK.CONNECTION_DENIED.rawValue
        case .MD5_MISMATCH:
            return ACK.MD5_MISMATCH.rawValue
        case .PART_MISSING:
            return ACK.PART_MISSING.rawValue
        }
    }
}

