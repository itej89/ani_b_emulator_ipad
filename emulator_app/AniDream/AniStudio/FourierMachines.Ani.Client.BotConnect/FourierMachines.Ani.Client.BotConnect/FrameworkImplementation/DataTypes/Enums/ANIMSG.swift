//
//  ANIMSG.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum ANIMSG:String
{
    case CATEGORY_ACK
    case DATA_ACK
    case COMMAND_ACK
    case REQEST_UPLOAD_ACK
    case UPLOAD_END_ACK
    case NA
    
   public static func GetString(type:ANIMSG) -> String
    {
        switch type {
        case .NA:
            return ANIMSG.NA.rawValue
        case .CATEGORY_ACK:
            return ANIMSG.CATEGORY_ACK.rawValue
        case .DATA_ACK:
            return ANIMSG.DATA_ACK.rawValue
        case .COMMAND_ACK:
            return ANIMSG.COMMAND_ACK.rawValue
        case .REQEST_UPLOAD_ACK:
            return ANIMSG.REQEST_UPLOAD_ACK.rawValue
        case .UPLOAD_END_ACK:
            return ANIMSG.UPLOAD_END_ACK.rawValue
        }
    }
}
