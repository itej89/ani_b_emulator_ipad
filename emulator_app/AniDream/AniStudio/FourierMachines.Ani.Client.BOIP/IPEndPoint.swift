//
//  IPEndPoint.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class IPEndPoint
{
   public var IPAddress:String = ""
   public var Port:Int = -1
    
    public init(){}
    
    public init(_IPAddress:String, _Port:Int)
    {
        IPAddress = _IPAddress
        Port = _Port
    }
}
