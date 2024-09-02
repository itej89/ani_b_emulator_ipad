//
//  UDPRequest.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class UDPRequest:IValidation
{
    public var ValidationErrors: ValidationRuleMessages
    
    public static var Instance:UDPRequest = UDPRequest()
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func RemoteIPEndPoint() -> IPEndPoint
    {
        return DOIPSession.Instance.RemoteEndPoint
    }
    
    public func Send(packet:[UInt8])
    {
        if(Validate())
        {
            if(UDPListen.Instance.udpClient != nil)
            {
                do
                {             try UDPListen.Instance.udpClient.enableBroadcast(false)
                }
                catch{}
                UDPListen.Instance.udpClient.send(Data(bytes: UnsafeRawPointer(packet), count: packet.count), toHost: DOIPSession.Instance.RemoteEndPoint.IPAddress, port: UInt16(DOIPSession.Instance.RemoteEndPoint.Port), withTimeout: 5000, tag: 2345)
            }
            
        }
    }
    
    public func Validate() -> Bool
    {
        ValidationErrors = ValidationRuleMessages()
        if(RemoteIPEndPoint().IPAddress == "" || RemoteIPEndPoint().Port == -1)
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Remote end point empty", strAdditionalInfo: ""))
        }
        if(!TransportLayerHelper.NetworkAvailable())
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.NETWORK_DISCONN, MethodInfo: "Networkk disconnected", strAdditionalInfo: ""))
        }
        if(ValidationErrors.Messages.count > 0)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
}
