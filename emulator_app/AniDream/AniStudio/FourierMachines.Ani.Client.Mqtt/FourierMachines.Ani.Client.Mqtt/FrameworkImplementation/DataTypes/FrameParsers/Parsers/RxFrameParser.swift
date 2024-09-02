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
            case .FIND:
                baseFrame =  (ANIMSG.FIND, FIND())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .CONNECT_ACK:
                baseFrame =  (ANIMSG.CONNECT_ACK, CONNECT_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
            case .DISCONNECT_ACK:
                baseFrame =  (ANIMSG.DISCONNECT_ACK, DISCONNECT_ACK())
                baseFrame.1.ParseJson(Json: Json)
                break
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
            case .ALIVE_ACK:
                baseFrame =  (ANIMSG.ALIVE_ACK, ALIVE_ACK())
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
