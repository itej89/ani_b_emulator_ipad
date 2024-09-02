//
//  AnimationsDefault.swift
//  BoltBot
//
//  Created by Uday on 14/05/17.
//  Copyright © 2017 itej89. All rights reserved.
//

import Foundation




public class AnimationPositions
{
    public var State:AnimationStateSet = AnimationStateSet()
    public var Transition:AnimationTransitionSet = AnimationTransitionSet()
    public var sentance:String = "";
    public var audio:String = "";
    public var StartSec:Int = 0;
    public var EndSec:Int = 0;
    public var volume:Double = 0.2;
    
 public  func parseJson(json : NSDictionary)
    {
     
      let dictionary =  json["AnimationPositions"] as! NSDictionary
        
        var dictionaryProperty = dictionary["State"] as! NSDictionary
        
        State.parseJson(json: dictionaryProperty)
        
         dictionaryProperty = dictionary["Transition"] as! NSDictionary
        
        Transition.parseJson(json: dictionaryProperty)
        
       audio = dictionary["audio"] as! String
       volume = Double(dictionary["volume"] as! String)!
      
    }
    
   public func Json() -> String{
        
        var json = ""
        
        
        json.append("{ \"AnimationPositions\" : {")
        
        
        json.append(" \"State\" : "+State.Json()+" , ")
        json.append(" \"Transition\" : "+Transition.Json()+" , ")
        
        json.append(" \"audio\" : \""+audio+"\" , ")
        json.append(" \"volume\" : \""+String(volume)+"\"  ")
        
        
       
     
        json.append("}}")
        
        return json
        
    }

    public  func destroy()
{
    State.destry();
    // State=  null;
    Transition.destry();
    // Transition = null;
    
    }
    
}
