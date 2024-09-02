//
//  AnimationAction.swift
//  BoltBot
//
//  Created by Uday on 17/05/17.
//  Copyright © 2017 itej89. All rights reserved.
//

import Foundation


public class AnimationAction
{
    
    public  var AnimationID:Int = -1
    
     public  var Name:String = ""
    
    public  var Position: AnimationPositions = AnimationPositions()
    
    public   var Emotion :AnimationEmotions = AnimationEmotions()
    
    public   var Sound_ID :String  = ""
    
    public   var Action: [AnimationAction] = []
    
   public func ParseJson(json: NSDictionary)  {
        
        
        let Action =  json["AnimationAction"] as! NSDictionary
        
        Name = Action["Name"] as! String
        
        let position = Action["Position"] as! NSDictionary
        
        Position.parseJson(json: position)
        
        let emotion = Action["Emotion"] as! NSDictionary
        
        Emotion.parseJson(json: emotion)
        
    }
    
    func Json() -> String {
        
        var json = ""
        
        
        json.append("{ \"AnimationAction\" : {")
        
        json.append(" \"Name\" : \""+Name+"\" , ")
        
        json.append(" \"Position\" : "+Position.Json()+" , ")
        
        json.append(" \"Emotion\" : "+Emotion.Json()+"  ")
        
        json.append("}}")
        
        return json
        
    }
    
}

