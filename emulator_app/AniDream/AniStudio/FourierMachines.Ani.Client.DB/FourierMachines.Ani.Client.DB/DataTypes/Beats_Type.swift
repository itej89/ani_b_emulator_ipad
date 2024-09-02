//
//  Beats_Type.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 28/05/19.
//  Copyright © 2019 Tej Kiran. All rights reserved.
//

import Foundation

public class Beats_Type
{
    
    public var Beat_Id:Int!
    public var Act_Id:Int!
    public var Action_Data:String!
    public var JOY:Float!
    public var SURPRISE:Float!
    public var FEAR:Float!
    public var SADNESS:Float!
    public var ANGER:Float!
    public var DISGUST:Float!
    public var StartSec:Int!
    public var EndSec:Int!
    
    public init(act_Id:Int, beat_ID:Int, action_Data:String, joy:Float, surprise:Float, fear:Float, sadness:Float, anger:Float, disgust:Float, startSec:Int, endSec:Int)
    {
        Act_Id = act_Id
        Beat_Id = beat_ID
        Action_Data = action_Data
        JOY = joy
        SURPRISE = surprise
        FEAR = fear
        SADNESS = sadness
        ANGER = anger
        DISGUST = disgust
        StartSec = startSec
        EndSec = endSec
    }
    
}
