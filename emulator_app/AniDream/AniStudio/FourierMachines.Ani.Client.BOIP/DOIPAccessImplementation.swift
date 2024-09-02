//
//  DOIPAccessImplementation.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 04/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPAccessImplementation:DoIPTesterContext, DOIPAccess
{
    public static var Instance:DOIPAccessImplementation = DOIPAccessImplementation()
    

    public var ConnectingEntity:DOIPEntity!
    
    public func Initialize(ContextConvey:DOIPContextConvey, ResultConvey:DOIPContextResultConvey) -> Bool
     {
        let result =  _Initialize(_ContextConvey:ContextConvey, _ResultConvey: ResultConvey)
        if(result == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public func Uninitialize()
    {
        _UnInitialize()
    }
    
    public func SendScan() -> Bool
    {
        let result =  AnnounceDiscover()
        if(result == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    public func Connect(Entity:DOIPEntity) -> Bool
    {
        ConnectingEntity = Entity
        let result =   RoutingActivation(Entity: Entity)
        if(result == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public func Disconnect()
    {
        FianlizeDiag()
        DOIPSession.Instance.ResetSession()
        ConnectingEntity = nil
    }
    
    public func Send(Data: [UInt8]) -> Bool {
        
        let result = SendData(Data: Data)
        if(result == DIAGNOSTIC_STATUS.CODE.SUCCESS.rawValue)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
}
