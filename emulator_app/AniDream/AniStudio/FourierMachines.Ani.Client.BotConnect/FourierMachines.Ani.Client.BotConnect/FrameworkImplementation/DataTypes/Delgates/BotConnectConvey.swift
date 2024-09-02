//
//  BotConnectConvey.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 11/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol BotConnectConvey
{
    func DiscoveredBots(Bots:[BotDetails])
    
    func BotConnected(_ID:String)
    func BotDisconnected(_ID:String)
    
    func BotLowStorage()
    func BotError(Error:BotConnectionInfo)
    
    
    func BrokerConenctionChanged(Status:Bool)
}
