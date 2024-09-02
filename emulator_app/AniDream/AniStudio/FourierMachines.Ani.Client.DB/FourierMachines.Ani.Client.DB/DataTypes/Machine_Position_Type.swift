//
//  Machine_Position_Type.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 09/04/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation

public class Machine_Position_Type
{
    public var Name:String!
    public var TURN:Int32!
    public var LIFT:Int32!
    public var LEAN:Int32!
    public var TILT:Int32!
    
   public init(name:String, turn:Int32, lift:Int32, lean:Int32, tilt:Int32)
    {
        Name = name
        TURN = turn
        LIFT = lift
        LEAN = lean
        TILT = tilt
    }
   public init(name:String)
    {
        Name = name
    }
}
