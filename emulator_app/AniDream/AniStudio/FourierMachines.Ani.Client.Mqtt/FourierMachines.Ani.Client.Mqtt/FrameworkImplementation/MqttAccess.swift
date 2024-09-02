//
//  MqttAccess.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol MqttAccess
{
   func Initialize(_delegate:MqttInterfaceConvey)
   func ConnectToBroker()
   func SubscribeTo(Channel:String)
   func UnSubscribeFrom(Channel:String)
   func DisconnectFromBroker()
   func ScanANI() -> String
   func ConnectANI(ID:String) -> String
   func DisconnectANI(ID: String) -> String
   func SendAlive(ID:String) ->String
   func SetANIActionMode(_ID: String, _CATEGORY: CATEGORY_TYPES) -> String
    
    
   func RequestUpload(_ID: String, _Count: Int, _MD5: String) -> String
   func SendData(_ID: String, _CATEGORY: CATEGORY_TYPES, _Data: [UInt8], _Block_Count:Int) -> String
   func ExitUpload(_ID: String) -> String
   func SendCommand(_ID: String, _CATEGORY: CATEGORY_TYPES, _COMMAND: COMMAND_TYPES) -> String
}
