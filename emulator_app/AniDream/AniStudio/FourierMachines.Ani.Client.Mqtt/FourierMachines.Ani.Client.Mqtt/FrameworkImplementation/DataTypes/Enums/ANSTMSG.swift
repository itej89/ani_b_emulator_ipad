//
//  ANSTMSG.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

//Ani Studio Message
public enum ANSTMSG:String
{
    case DISCOVER
    case CONNECT
    case DISCONNECT
    case CATEGORY
    case DATA
    case COMMAND
    case ALIVE
    case REQEST_UPLOAD
    case UPLOAD_END
    case NA
    
    func GetString(type:ANSTMSG) -> String
    {
        switch type {
        case ANSTMSG.DISCOVER:
            return ANSTMSG.DISCOVER.rawValue
        case .CONNECT:
            return ANSTMSG.CONNECT.rawValue
        case .DISCONNECT:
            return ANSTMSG.DISCONNECT.rawValue
        case .CATEGORY:
            return ANSTMSG.CATEGORY.rawValue
        case .DATA:
            return ANSTMSG.DATA.rawValue
        case .COMMAND:
            return ANSTMSG.COMMAND.rawValue
        case .ALIVE:
            return ANSTMSG.ALIVE.rawValue
        case .REQEST_UPLOAD:
            return ANSTMSG.REQEST_UPLOAD.rawValue
        case .UPLOAD_END:
            return ANSTMSG.UPLOAD_END.rawValue
        case .NA:
            return ANSTMSG.NA.rawValue
        }
    }
}
