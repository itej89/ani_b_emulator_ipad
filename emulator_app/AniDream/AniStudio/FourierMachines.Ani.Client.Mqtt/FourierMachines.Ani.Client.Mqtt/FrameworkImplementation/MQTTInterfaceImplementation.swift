//
//  MQTTInterfaceImplementation.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class MQTTInterfaceImplementation:MqttManager, MqttAccess
{
    
    public static let Instance:MQTTInterfaceImplementation = MQTTInterfaceImplementation()
   
    
    public let ID =  UUID().uuidString
    public let NAME =  "Ani_Studio"+UUID().uuidString
    
    public override init()
    {
        super.init()
    }
    
    //MqttAccess
    public func ScanANI() -> String {
        let TxFrame = DISCOVER(_ID:ID, _NAME: NAME)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.ScanChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func ConnectANI(ID: String) -> String {
        let TxFrame = CONNECT(_ID: ID)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.ScanChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func DisconnectANI(ID: String) -> String {
        let TxFrame = DISCONNECT(_ID: ID)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.ScanChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func SendAlive(ID:String) ->String
    {
        let TxFrame = ALIVE(_ID:ID)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.AliveChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func SetANIActionMode(_ID: String, _CATEGORY: CATEGORY_TYPES) -> String {
        let TxFrame = CATEGORY(_ID: _ID, _TYPE: _CATEGORY)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.CategoryChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func RequestUpload(_ID: String, _Count: Int, _MD5: String) -> String
    {
        let TxFrame = REQEST_UPLOAD(_ID: _ID, _CHUNKCount: _Count,_MD5: _MD5)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.DataChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func SendData(_ID: String, _CATEGORY: CATEGORY_TYPES, _Data: [UInt8], _Block_Count:Int) -> String {
        let TxFrame = DATA(_ID: _ID, _TYPE: _CATEGORY,_DATA: _Data, _BLOCK_COUNT:_Block_Count)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.DataChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func ExitUpload(_ID: String) -> String
    {
        let TxFrame = UPLOAD_END(_ID: _ID)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.DataChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    
    public func SendCommand(_ID: String, _CATEGORY: CATEGORY_TYPES, _COMMAND: COMMAND_TYPES) -> String{
        let TxFrame = COMMAND(_ID: _ID, _TYPE: _CATEGORY,_COMMAND: _COMMAND)
        Send(FrameID: TxFrame.FRAME_ID, data: TxFrame.Json(), toChannel: MQTTMetaData.CommandChannel_Tx, IsWaitForAck: TxFrame.IsWaitForAck)
        return TxFrame.FRAME_ID
    }
    //End of MqttAccess
    
}
