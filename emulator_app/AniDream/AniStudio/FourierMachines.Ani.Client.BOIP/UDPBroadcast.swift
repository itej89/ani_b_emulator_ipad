//
//  UDPBroadcast.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class UDPBroadcast:IValidation
{
    public var ValidationErrors: ValidationRuleMessages
    
    public static var Instance:UDPBroadcast = UDPBroadcast()
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public func RemoteIPEndPoint() -> IPEndPoint
    {
        return IPEndPoint(_IPAddress: "255.255.255.255", _Port: DOIPParameters.Instance.DOIP_ENTITY_UDP_DISCOVER)
    }
    
    public func UDPBroadcastPacket(packet:[UInt8])
    {
        if(UDPListen.Instance.udpClient != nil)
        {
            do
                {             try UDPListen.Instance.udpClient.enableBroadcast(true)
            }
            catch{}
            UDPListen.Instance.udpClient.send(Data(bytes: UnsafeRawPointer(packet), count: packet.count), toHost: "255.255.255.255", port: UInt16(DOIPParameters.Instance.DOIP_ENTITY_UDP_DISCOVER), withTimeout: 5000, tag: 0)
        }
    }
    
    
    
}
