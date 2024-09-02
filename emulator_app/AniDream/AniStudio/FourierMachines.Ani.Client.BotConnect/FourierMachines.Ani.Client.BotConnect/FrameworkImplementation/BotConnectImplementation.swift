//
//  BotConnectImplementation.swift
//  FourierMachines.Ani.Client.BotConnect
//
//  Created by Tej Kiran on 11/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_BOIP

public class BotConnectImplementation: BotConnectManager, BotConnectAccess
{
  
    public static let  Instance:BotConnectImplementation = BotConnectImplementation()
    
    //BotConnectAccess
    public func ConnectToServer(delegate:BotConnectConvey)
    {
        botDelegate = delegate
        Initialize()
    }
    
    public func DisconnectFromServer()
    {
        UnInitialize()
    }
    
    
    public func StartScan() {
        StartBotScanBroadCastMessage()
    }
    
    public func StopScan() {
        StopBotScanBroadCastMessage()
    }
    
    public func ConnectToBot(_ID: String) {
            BeginConnectToBot(_ID: _ID)
    }
    
    public func DisconnectBot() {
            BeginDisconnectBot()
    }
    
    public func GetConnectedBot() -> BotDetails!
    {
        return ConnectedBot
    }
    
    public func UploadChoreogramForDebug() {
      
    }
    
    public func PlayChoreogramForDebug() {
       
    }
    
    public func PauseChoreogramForDebug() {
     
    }
    
    public func ResumeChoreogramForDebug() {
       
    }
    
    public func StopChoreogramForDebug() {
       
    }
    
    public func PlayChoreogramBeatForDebug() {
      
    }
    
    public func ShowEmotionForDebug() {
        
    }
    //End of BotConnectAccess
}
