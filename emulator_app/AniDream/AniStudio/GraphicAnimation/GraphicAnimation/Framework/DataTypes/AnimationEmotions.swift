//
//  Animation_Emotions.swift
//  Ani_AnimationStudio
//
//  Created by Tej Kiran on 11/12/17.
//  Copyright © 2017 Ani. All rights reserved.
//

import Foundation


public class AnimationEmotions {
    public var EmotionData:[EmotionEnums.Emotions : Float] = [EmotionEnums.Emotions.JOY: 0.0,
                                                                              EmotionEnums.Emotions.SURPRISE: 0.0,
                                                                              EmotionEnums.Emotions.FEAR: 0.0,
                                                                              EmotionEnums.Emotions.SADNESS: 0.0,
                                                                              EmotionEnums.Emotions.ANGER: 0.0,
                                                                              EmotionEnums.Emotions.DISGUST: 0.0,]
    func parseJson(json : NSDictionary)
    {
        
        let dictionary =  json["AnimationEmotions"] as! NSDictionary
        
        
        EmotionData[EmotionEnums.Emotions.JOY] =  Float(dictionary["JOY"] as! String)
        EmotionData[EmotionEnums.Emotions.SURPRISE] = Float(dictionary["SURPRISE"] as! String)
        EmotionData[EmotionEnums.Emotions.FEAR] = Float(dictionary["FEAR"] as! String)
        EmotionData[EmotionEnums.Emotions.SADNESS] = Float(dictionary["SADNESS"] as! String)
        EmotionData[EmotionEnums.Emotions.ANGER] = Float(dictionary["ANGER"] as! String)
        EmotionData[EmotionEnums.Emotions.DISGUST] = Float(dictionary["DISGUST"] as! String)
        
    }
    
    func Json() -> String{
        
        var json = ""
        
        
        json.append("{ \"AnimationEmotions\" : {")
        
        
       
        json.append(" \"JOY\" : \""+String(describing: EmotionData[EmotionEnums.Emotions.JOY]!)+"\" , ")
        json.append(" \"SURPRISE\" : \""+String(describing: EmotionData[EmotionEnums.Emotions.SURPRISE]!)+"\" ,  ")
        json.append(" \"FEAR\" : \""+String(describing: EmotionData[EmotionEnums.Emotions.FEAR]!)+"\" ,  ")
        json.append(" \"SADNESS\" : \""+String(describing: EmotionData[EmotionEnums.Emotions.SADNESS]!)+"\" , ")
        json.append(" \"ANGER\" : \""+String(describing: EmotionData[EmotionEnums.Emotions.ANGER]!)+"\" , ")
        json.append(" \"DISGUST\" : \""+String(describing: EmotionData[EmotionEnums.Emotions.DISGUST]!)+"\"  ")
        
        json.append("}}")
        
        return json
        
    }
}
