//
//  EM_SYNTH.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 27/02/20.
//  Copyright © 2020 Tej Kiran. All rights reserved.
//

import Foundation

public class  EM_SYNTH
{
    public var ID:Int!
    public var Name:String!
    
    public init(name:String)
    {
        Name = name
    }
    
    public init(id:Int, name:String)
    {
        ID = id
        Name = name
    }
}
