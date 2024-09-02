//
//  TxBaseFrame.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class TxBaseFrame
{
    var jANSTMSG:ANSTMSG!
    let FRAME_ID = UUID().uuidString
     public var IsWaitForAck = false
    
    public func ParseJson(Json:String)
    {
        let Dict = Json.parseJSONString as! NSMutableDictionary
        jANSTMSG = ANSTMSG(rawValue: Dict["ANSTMSG"] as! String) ?? ANSTMSG.NA
    }
}
