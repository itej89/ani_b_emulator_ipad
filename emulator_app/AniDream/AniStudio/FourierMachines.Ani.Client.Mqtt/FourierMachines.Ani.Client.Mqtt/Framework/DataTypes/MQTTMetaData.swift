//
//  MQTTMetaData.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 20/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class MQTTMetaData
{
    public static let CategoryChannel_Rx = "ani-studio-action_Rx";
    public static let ScanChannel_Rx = "ani-studio-scan_Rx";
    public static let DataChannel_Rx = "ani-studio-data_Rx";
    public static let CommandChannel_Rx = "ani-studio-command_Rx";
    public static let AliveChannel_Rx = "ani-studio-alive_Rx";
    
    
    public static let CategoryChannel_Tx = "ani-studio-action_Tx";
    public static let ScanChannel_Tx = "ani-studio-scan_Tx";
    public static let DataChannel_Tx = "ani-studio-data_Tx";
    public static let CommandChannel_Tx = "ani-studio-command_Tx";
    public static let AliveChannel_Tx = "ani-studio-alive_Tx";
    
    public static let BROKER_IP = "192.168.0.140"
    public static let BROKER_PORT:UInt16 = 1883
    public static let CLIENT_ID = "ani-studio-ipad" + String(ProcessInfo().processIdentifier)
}
