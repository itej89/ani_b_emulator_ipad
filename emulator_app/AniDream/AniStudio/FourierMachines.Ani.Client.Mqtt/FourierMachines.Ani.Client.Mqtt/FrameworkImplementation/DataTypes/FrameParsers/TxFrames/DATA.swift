//
//  DATA.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DATA:TxBaseFrame
{
    var ID:String = ""
    var TYPE:CATEGORY_TYPES = CATEGORY_TYPES.NA
    var BLOCK_COUNT:Int = 0
    var DATA:[UInt8] = []
    
    public init(_ID:String, _TYPE:CATEGORY_TYPES, _DATA:[UInt8], _BLOCK_COUNT:Int) {
        super.init()
        jANSTMSG = ANSTMSG.DATA
        ID = _ID
        TYPE = _TYPE
        DATA = _DATA
        BLOCK_COUNT = _BLOCK_COUNT
        IsWaitForAck = true
    }
    
    public func Json()->String
    {
        //Convert [UInt8] to NSData
        let data = NSData(bytes: DATA, length: DATA.count)
        
        //Encode to base64
        let base64Data = data.base64EncodedString()
        
        let DataDictionary:NSDictionary = [
            "ANSTMSG" : ANSTMSG.DATA.rawValue,
            "ID" : ID,
            "CATEGORY" : TYPE.description,
            "DATA" : base64Data,
            "BLOCK_COUNT" : BLOCK_COUNT,
            "FRAME_ID" : FRAME_ID
        ]
        return DataDictionary.toString() ?? ""
    }
    
    public override func ParseJson(Json:String)
    {
        super.ParseJson(Json: Json)
        let Dict = Json.parseJSONString as! NSMutableDictionary
        ID = Dict["ID"] as! String
        BLOCK_COUNT = Dict["BLOCK_COUNT"] as! Int
        TYPE = CATEGORY_TYPES(rawValue: Dict["CATEGORY"] as! String) ?? CATEGORY_TYPES.NA
        DATA = [UInt8](NSData(base64Encoded: Dict["DATA"] as! String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters) ?? NSData())
        

    }
}
