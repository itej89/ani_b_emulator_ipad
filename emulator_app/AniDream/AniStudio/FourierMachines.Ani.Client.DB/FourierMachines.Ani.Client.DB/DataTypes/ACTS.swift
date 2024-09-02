//
//  Animation_Act_Type.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation

public class  ACTS
{
   public var ID:Int!
   public var Name:String!
   public var Audio:String!
    
    public init(name:String, id:Int)
    {
        Name = name
        ID = id
        Audio = ""
    }
    
   public init(name:String, audio:String)
    {
        ID = -1
        Name = name
        Audio = audio
    }
}
