//
//  AnimationTransitionSet.swift
//  BoltBot
//
//  Created by Uday on 15/05/17.
//  Copyright © 2017 itej89. All rights reserved.
//

import Foundation

public class AnimationTransitionSet
{
   
    
    
    public var TransitionSet:[AnimationObject: AnimationTransition] =
        [AnimationObject.Image_EyeBrowRight:ImageAnimationTransition(),
         AnimationObject.Image_EyeBrowLeft:ImageAnimationTransition(),
         AnimationObject.Image_EyeRight:ImageAnimationTransition(),
         AnimationObject.Image_EyeLeft:ImageAnimationTransition(),
         AnimationObject.Image_EyeBallRight:ImageAnimationTransition(),
         AnimationObject.Image_EyeBallLeft:ImageAnimationTransition(),
         AnimationObject.Image_EyePupilRight:ImageAnimationTransition(),
         AnimationObject.Image_EyePupilLeft:ImageAnimationTransition(),
         AnimationObject.Image_EyeLidLeft:ImageAnimationTransition(),
         AnimationObject.Image_EyeLidRight:ImageAnimationTransition(),
         
         AnimationObject.Motor_Tilt:MotionAnimationTransition(),
         AnimationObject.Motor_Turn:MotionAnimationTransition(),
         AnimationObject.Motor_Lift:MotionAnimationTransition(),
         AnimationObject.Motor_Lean:MotionAnimationTransition(),
         ]
    
    func parseJson(json : NSDictionary)
    {
        
        let dictionary =  json["AnimationTransitionSet"] as! NSDictionary
        
        
        for item in TransitionSet {
            
            let dictionaryProperty =  dictionary[item.key.description] as! NSDictionary
            TransitionSet[item.key]?.parseJson(json: dictionaryProperty)
            
        }
        
    }
    
    func Json() -> String{
        
        var json = ""
        
        
        json.append("{ \"AnimationTransitionSet\" : {")
        
        for item in TransitionSet {
            
            json.append(" \""+item.key.description+"\" : "+item.value.Json()+" ,")
            
        }
        
         json =  String(json.dropLast())
        
        json.append("}")
        json.append("}")
        
        return json
        
    }
    
    public  func destry()
    {
    TransitionSet.removeAll()
    // StateSet = null;
    }
    
}
