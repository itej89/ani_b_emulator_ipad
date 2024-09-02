//
//  BotError.swift
//  FourierMachines.Ani.Client.BotConnect
//
//  Created by Tej Kiran on 16/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum BotConnectionInfo
{
    case CONNECTION_TIMEOUT
    case CONNECTED
    case DISCONNECTED
    case ERROR
    case CATEGORY_ACK
    case REQUP_ACK
    case SENDDATA_ACK
    case EXREQ_ACK
    case COMMAND_ACK
}
