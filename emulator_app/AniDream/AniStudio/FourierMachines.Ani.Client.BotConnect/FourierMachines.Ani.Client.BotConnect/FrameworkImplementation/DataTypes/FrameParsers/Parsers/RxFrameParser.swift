//
//  RxFrameParser.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class RxFrameParser
{
    public init(){}
    
    func GetBaseFrame(Json:String) -> (ANIMSG,RxBaseFrame)
    {
        var baseFrame = (ANIMSG.NA, RxBaseFrame())
        baseFrame.1.ParseJson(Json: Json)
        baseFrame.0 = baseFrame.1.jANIMSG
        return baseFrame
    }
    
   public func GetRxObject(Json:String) -> (ANIMSG,RxBaseFrame)
    {
        var baseFrame = (ANIMSG.NA, RxBaseFrame())
        baseFrame.1.ParseJson(Json: Json)
            switch baseFrame.1.jANIMSG {
            case .CATEGORY_ACK:
                baseFrame =  (ANIMSG.CATEGORY_ACK, CATEGORY_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .DATA_ACK:
                baseFrame =  (ANIMSG.DATA_ACK, DATA_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .COMMAND_ACK:
                baseFrame =  (ANIMSG.COMMAND_ACK, COMMAND_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .REQEST_UPLOAD_ACK:
                baseFrame =  (ANIMSG.REQEST_UPLOAD_ACK, REQEST_UPLOAD_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .UPLOAD_END_ACK:
                baseFrame =  (ANIMSG.UPLOAD_END_ACK, UPLOAD_END_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .NA:
                break
        }
        
        
            return baseFrame
        
    }
}
