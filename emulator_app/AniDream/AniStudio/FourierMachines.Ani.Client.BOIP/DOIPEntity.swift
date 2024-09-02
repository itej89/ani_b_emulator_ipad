//
//  DOIPEntity.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 04/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPEntity
{
    public init(){}
    
   public var VIN:[UInt8] = []
   public  var EID:[UInt8] = []
   public  var LogicalAddress:[UInt8] = []
   public  var GID:[UInt8] = []
   public  var FurtherActions:UInt8 = 0
   public  var IPAddress:String = UUID().uuidString
   public  var Port:Int = -1
   public  var ROUTING_ACTIVATION_RESPONSE_CODE:UInt8 = 0
   public  var IsConnected = false
   public  var ISResponded = false
}
