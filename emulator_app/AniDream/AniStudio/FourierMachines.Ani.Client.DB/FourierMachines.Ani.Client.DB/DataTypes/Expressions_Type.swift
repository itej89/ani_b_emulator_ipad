//
//  Expressions_Type.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation

public class  Expressions_Type
{
   public var ID:Int!
   public var Name:String!
   public var Action_Data:String!
   public var JOY:Float!
   public var SURPRISE:Float!
   public var FEAR:Float!
   public var SADNESS:Float!
   public var ANGER:Float!
   public var DISGUST:Float!
   public var EM_SYNTH_ID:Int!
   public var SOUND_LIBRARY_ID:String!
    
    public init(name:String, action_Data:String, joy:Float, surprise:Float, fear:Float, sadness:Float, anger:Float, disgust:Float, em_synth_id:Int, Sound_Library_ID:String)
    {
        Name = name
        Action_Data = action_Data
        JOY = joy
        SURPRISE = surprise
        FEAR = fear
        SADNESS = sadness
        ANGER = anger
        DISGUST = disgust
        EM_SYNTH_ID = em_synth_id
        SOUND_LIBRARY_ID = Sound_Library_ID
    }
    
    public init(id:Int, name:String, action_Data:String, joy:Float, surprise:Float, fear:Float, sadness:Float, anger:Float, disgust:Float, em_synth_id:Int, Sound_Library_ID:String)
    {
        ID = id
        Name = name
        Action_Data = action_Data
        JOY = joy
        SURPRISE = surprise
        FEAR = fear
        SADNESS = sadness
        ANGER = anger
        DISGUST = disgust
        EM_SYNTH_ID = em_synth_id
        SOUND_LIBRARY_ID = Sound_Library_ID
    }
}
