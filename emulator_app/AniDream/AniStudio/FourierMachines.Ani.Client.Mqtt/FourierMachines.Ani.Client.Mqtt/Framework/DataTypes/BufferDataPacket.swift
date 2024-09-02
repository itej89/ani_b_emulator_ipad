//
//  BufferDataPacket.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 22/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class BufferDataPacket
{
    public var FrameID:String
    public var data : String
    public var toChannel:String
    public var IsWaitForAck:Bool
    
    public init(_FrameID:String, _data : String, _toChannel:String, _IsWaitForAck:Bool)
    {
        FrameID = _FrameID
        data = _data
        toChannel = _toChannel
        IsWaitForAck = _IsWaitForAck
    }
}
