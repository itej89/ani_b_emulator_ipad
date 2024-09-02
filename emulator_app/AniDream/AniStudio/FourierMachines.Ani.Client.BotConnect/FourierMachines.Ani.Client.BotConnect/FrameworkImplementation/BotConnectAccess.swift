//
//  BotConnectAccess.swift
//  FourierMachines.Ani.Client.BotConnect
//
//  Created by Tej Kiran on 11/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol BotConnectAccess
{

    func StartScan()
    func StopScan()
//
    func GetConnectedBot() -> BotDetails!
    
//    func ConnectToBot(_ID:String)
//    func DisconnectBot()
//
//
//    func ShowEmotionForDebug()
//
//    func UploadChoreogramForDebug()
//    func PlayChoreogramForDebug()
//    func StopChoreogramForDebug()
//
//    func PauseChoreogramForDebug()
//    func ResumeChoreogramForDebug()
//    func PlayChoreogramBeatForDebug()
}
