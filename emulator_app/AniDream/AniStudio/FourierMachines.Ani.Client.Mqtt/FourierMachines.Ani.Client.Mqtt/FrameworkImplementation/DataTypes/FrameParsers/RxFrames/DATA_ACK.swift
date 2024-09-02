//
//  DATA_ACK.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DATA_ACK:RxBaseFrame
{
    public var ID:String = ""
    public var jACK:ACK = ACK.NA
    
    public override init()
    {
        super.init()
    }
    
    public init(_ID:String ,_ACK:ACK) {
        super.init()
        jANIMSG = ANIMSG.DATA_ACK
        ID = _ID
        jACK = _ACK
    }
    
    public override func ParseJson(Json:String)
    {
        super.ParseJson(Json: Json)
        let Dict = Json.parseJSONString as! NSMutableDictionary
        ID = Dict["ID"] as! String
        jACK = ACK(rawValue: Dict["ACK"] as! String) ?? ACK.NA
    }
}
