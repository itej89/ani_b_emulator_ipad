//
//  DISCOVER.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_Common

public class DISCOVER:TxBaseFrame
{
    public var ID:String = ""
    public var NAME:String = ""
    
    public init(_ID:String, _NAME:String) {
        super.init()
        jANSTMSG = ANSTMSG.DISCOVER
        ID = _ID
        NAME = _NAME
        IsWaitForAck = false
    }
    
    public func Json()->String
    {
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.DISCOVER.rawValue,
            "FRAME_ID" : FRAME_ID,
            "ID" : ID,
            "NAME" : NAME
        ]
        return DataDictionary.toString() ?? ""
    }
    
    public override func ParseJson(Json:String)
    {
        super.ParseJson(Json: Json)
        let Dict = Json.parseJSONString as! NSMutableDictionary
        ID = Dict["ID"] as! String
        NAME  = Dict["NAME"] as! String
    }
}
