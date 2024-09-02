//
//  RxBaseFrame.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_Common

public class RxBaseFrame
{
    public var jANIMSG:ANIMSG = ANIMSG.NA
    public var FRAME_ID = ""
   
    
    public func ParseJson(Json:String)
    {
        let Dict = Json.parseJSONString as! NSMutableDictionary
        if(Dict["ANIMSG"] != nil)
        {
            jANIMSG = ANIMSG(rawValue: Dict["ANIMSG"] as! String) ?? ANIMSG.NA
        }
        FRAME_ID = Dict["FRAME_ID"] as! String
    }
}
