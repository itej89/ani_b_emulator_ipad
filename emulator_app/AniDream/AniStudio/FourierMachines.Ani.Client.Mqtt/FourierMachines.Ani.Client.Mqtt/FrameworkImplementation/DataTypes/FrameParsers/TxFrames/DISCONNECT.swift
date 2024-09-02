//
//  DISCONNECT.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 13/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class DISCONNECT:TxBaseFrame
{
    var ID:String = ""
    
    public init(_ID:String) {
        super.init()
        jANSTMSG = ANSTMSG.DISCONNECT
        ID = _ID
        IsWaitForAck = true
    }
    
    public func Json()->String
    {
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.DISCONNECT.rawValue,
            "ID" : ID,
            "FRAME_ID" : FRAME_ID
        ]
        return DataDictionary.toString() ?? ""
    }
    
    public override func ParseJson(Json:String)
    {
        super.ParseJson(Json: Json)
        let Dict = Json.parseJSONString as! NSMutableDictionary
        ID = Dict["ID"] as! String
    }
    
}
