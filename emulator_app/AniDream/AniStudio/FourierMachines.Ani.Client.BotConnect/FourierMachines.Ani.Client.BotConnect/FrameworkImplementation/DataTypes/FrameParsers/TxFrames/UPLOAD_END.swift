//
//  UPLOAD_END.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 22/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class UPLOAD_END:TxBaseFrame
{
    var ID:String = ""
    
    public init(_ID:String) {
        super.init()
        jANSTMSG = ANSTMSG.UPLOAD_END
        ID = _ID
        IsWaitForAck = true
    }
    
    public func Json()->String
    {
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.UPLOAD_END.rawValue,
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
