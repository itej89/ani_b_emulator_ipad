//
//  AnimationPropertySet.swift
//  BoltBot
//
//  Created by Uday on 14/05/17.
//  Copyright © 2017 itej89. All rights reserved.
//

import Foundation

public class AnimationStateSet
{
 
    public var StateSet:[AnimationObject: AnimationState] =
        [AnimationObject.Image_EyeBrowRight:ImageAnimationState(),
         AnimationObject.Image_EyeBrowLeft:ImageAnimationState(),
         AnimationObject.Image_EyeRight:ImageAnimationState(),
         AnimationObject.Image_EyeLeft:ImageAnimationState(),
         AnimationObject.Image_EyeBallRight:ImageAnimationState(),
         AnimationObject.Image_EyeBallLeft:ImageAnimationState(),
         AnimationObject.Image_EyePupilRight:ImageAnimationState(),
         AnimationObject.Image_EyePupilLeft:ImageAnimationState(),
         AnimationObject.Image_EyeLidLeft:ImageAnimationState(),
         AnimationObject.Image_EyeLidRight:ImageAnimationState(),
         
         AnimationObject.Motor_Tilt_Graphic:ImageAnimationState(),
         AnimationObject.Motor_Turn_Graphic:ImageAnimationState(),
         AnimationObject.Motor_Lift_Graphic:ImageAnimationState(),
         AnimationObject.Motor_Lean_Graphic:ImageAnimationState(),
         
         
         AnimationObject.Motor_Tilt:MotorAnimationState(),
         AnimationObject.Motor_Turn:MotorAnimationState(),
         AnimationObject.Motor_Lift:MotorAnimationState(),
         AnimationObject.Motor_Lean:MotorAnimationState(),
         ]
    
    func parseJson(json : NSDictionary)
    {
        
        let dictionary =  json["AnimationStateSet"] as! NSDictionary
        
        
        for item in StateSet {
            
            if(item.key.rawValue <= 24)
            {
            let dictionaryProperty =  dictionary[item.key.description] as! NSDictionary
            StateSet[item.key]?.parseJson(json: dictionaryProperty)
            }
            
        }
        
    }

    
    func Json() -> String{
        
        var json = ""
        
        
        json.append("{ \"AnimationStateSet\" : {")
        
         for item in StateSet {
            if(item.key.rawValue <= 24)
            {
            json.append(" \""+item.key.description+"\" : "+item.value.Json()+" ,")
            }
            
        }
        
     json =  String(json.dropLast())
        
        json.append("}")
        json.append("}")
        
        return json
        
    }
    
    public  func destry()
{
    StateSet.removeAll()
    // StateSet = null;
    
    }
}


