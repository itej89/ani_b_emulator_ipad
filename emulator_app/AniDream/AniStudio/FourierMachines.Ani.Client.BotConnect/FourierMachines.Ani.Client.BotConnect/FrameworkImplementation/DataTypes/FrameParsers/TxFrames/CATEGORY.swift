//
//  CATEGORY.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class CATEGORY:TxBaseFrame
{
    var ID:String = ""
    var TYPE:CATEGORY_TYPES = CATEGORY_TYPES.NA
    
    public init(_ID:String, _TYPE:CATEGORY_TYPES) {
        super.init()
        jANSTMSG = ANSTMSG.CATEGORY
        ID = _ID
        TYPE = _TYPE
        IsWaitForAck = true
    }
    
    public func Json()->String
    {
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.CATEGORY.rawValue,
            "ID" : ID,
             "CATEGORY" : TYPE.description,
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
    }
}
