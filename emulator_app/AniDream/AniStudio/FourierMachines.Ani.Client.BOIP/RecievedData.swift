//
//  RecievedData.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class RecievedData
{
    public var RemoteEndPoint:IPEndPoint = IPEndPoint()
    public var recvBuffer:[UInt8] = []
    
    public init(_RemoteEndPoint:IPEndPoint, _recvBuffer:[UInt8])
    {
        RemoteEndPoint = _RemoteEndPoint
        recvBuffer = _recvBuffer
    }
}
