//
//  Payload_Item_Type.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Item_Type
{
    public var RawData:[UInt8]!
    public var Position:Int = 0
    public var Length_ISO_13400:UInt64 = 0
    private var IsOfVariableLength:Bool = false
    
    public init(_Position:Int, _Length:UInt64)
    {
        Position = _Position
        Length_ISO_13400 = _Length
        RawData = [UInt8](repeating: 0,count: Int(_Length))
    }
    
    public init(_Position:Int)
    {
        Position = _Position
        IsOfVariableLength = true
        RawData = nil
    }
    
    public func IsItemLengthNotDefined() -> Bool
    {
        return IsOfVariableLength
    }
    
}
