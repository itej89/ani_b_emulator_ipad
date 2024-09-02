//
//  CHUNKDETAILS.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 22/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class REQEST_UPLOAD:TxBaseFrame
{
    var ID:String = ""
    var CHUNK_COUNT:Int = 0
    var MD5:String = ""
    
    public init(_ID:String, _CHUNKCount:Int, _MD5:String) {
        super.init()
        jANSTMSG = ANSTMSG.REQEST_UPLOAD
        ID = _ID
        CHUNK_COUNT = _CHUNKCount
        MD5 = _MD5
        IsWaitForAck = true
    }
    
    public func Json()->String
    {
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.REQEST_UPLOAD.rawValue,
            "ID" : ID,
            "CHUNK_COUNT" : String(CHUNK_COUNT),
            "MD5" : MD5,
            "FRAME_ID" : FRAME_ID
        ]
        return DataDictionary.toString() ?? ""
    }
    
    public override func ParseJson(Json:String)
    {
        super.ParseJson(Json: Json)
        let Dict = Json.parseJSONString as! NSMutableDictionary
        ID = Dict["ID"] as! String
        CHUNK_COUNT = Int(Dict["CHUNK_COUNT"] as! String) ?? 0
        MD5 = Dict["MD5"] as! String
    }
}
