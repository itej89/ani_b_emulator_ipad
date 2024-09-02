//
//  COMMAND.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_Common

public class COMMAND:TxBaseFrame
{
    var ID:String = ""
    var TYPE:CATEGORY_TYPES = CATEGORY_TYPES.NA
    var COMMAND:COMMAND_TYPES = COMMAND_TYPES.NA
    
    public init(_ID:String, _TYPE:CATEGORY_TYPES, _COMMAND:COMMAND_TYPES) {
        super.init()
        jANSTMSG = ANSTMSG.COMMAND
        ID = _ID
        TYPE = _TYPE
        COMMAND = _COMMAND
        IsWaitForAck = true
    }
    
    public func Json()->String
    {
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.COMMAND.rawValue,
            "ID" : ID,
            "CATEGORY" : TYPE.description,
            "COMMAND" : COMMAND.description,
            "FRAME_ID" : FRAME_ID
        ]
        return DataDictionary.toString() ?? ""
    }
    
    public override func ParseJson(Json:String)
    {
        super.ParseJson(Json: Json)
        let Dict = Json.parseJSONString as! NSMutableDictionary
        ID = Dict["ID"] as! String
        TYPE = CATEGORY_TYPES(rawValue: Dict["CATEGORY"] as! String) ?? CATEGORY_TYPES.NA
        COMMAND = COMMAND_TYPES(rawValue: Dict["COMMAND"] as! String) ?? COMMAND_TYPES.NA
    }
}
