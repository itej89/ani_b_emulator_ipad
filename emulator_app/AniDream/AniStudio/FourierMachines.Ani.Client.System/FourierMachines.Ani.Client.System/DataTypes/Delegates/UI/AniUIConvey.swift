//
//  AniUIConvey.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 18/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_BotConnect

public protocol AniUIConvey
{
    func BotsDiscovered(Bots:[BotDetails])
    func BotServerStateChanged(state:Bool)
}
