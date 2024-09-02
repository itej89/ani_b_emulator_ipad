//
//  MqttInterfaceConvey.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol MqttInterfaceConvey
{
    func ConnectedToBroker(Status:Bool)
    func SubscribedToChannel(Channel:String, Status:Bool)
    func UnsubscribedFromChannel(Channel:String, Status:Bool)
    func FrameSent(Frame_ID:String, Status:Bool)
    func FrameRecieved(FrameType:ANIMSG, Json:String)
    func DisconnectedFromBroker(Status:Bool)
}
