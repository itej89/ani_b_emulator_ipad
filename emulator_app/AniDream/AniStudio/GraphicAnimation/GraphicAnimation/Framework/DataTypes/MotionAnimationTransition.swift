//
//  MotionAnimationTransition.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_Kinetics

public class MotionAnimationTransition: AnimationTransition
{
   public var Timing:Int = 0
    public var Delay:Int = 0
   public  var Frequency:Int = 0
   public  var Damp:Int = 0
   public  var Velocity:Int = 0
   public  var EasingFunction:CommandHelper.EasingFunction = CommandHelper.EasingFunction.LIN
   public  var EasingType:CommandHelper.EasingType = CommandHelper.EasingType.IN
    
    
    override func parseJson(json : NSDictionary)
    {
        
        let dictionary =  json["Transition"] as! NSDictionary
        
        Timing = Int(dictionary["Timing"] as! String)!
        Delay = Int(dictionary["Delay"] as! String)!
        Frequency = Int(dictionary["Frequency"] as! String)!
        Damp = Int(dictionary["Damp"] as! String)!
        Velocity = Int(dictionary["Velocity"] as! String)!
        
        
        self.EasingFunction = CommandHelper.GetEasingFunciton(rawvalue: dictionary["EasingFunction"] as! String)
        self.EasingType = CommandHelper.GetEasingType(rawvalue: dictionary["EasingType"] as! String)
        
    }
    
    
    override func Json() -> String
    {
        
        var json = ""
        
        json.append("{ \"Transition\" : {")
        
        json.append(" \"Timing\" : \""+String(describing : Timing)+"\" ,")
        
        json.append(" \"Delay\" : \""+String(describing : Delay)+"\" ,")
        
        json.append(" \"Velocity\" : \""+String(describing : Velocity)+"\" ,")
        
        json.append(" \"Frequency\" : \""+String(describing : Frequency)+"\" ,")
        
        json.append(" \"Damp\" : \""+String(describing : Damp)+"\" ,")
        
        json.append(" \"EasingFunction\" : \""+EasingFunction.rawValue+"\" ,")
        
        json.append(" \"EasingType\" : \""+EasingType.rawValue+"\" ")
        
        json.append("}}")
        
        return json
        
    }
    
    
    override init()
    {}
    
    init(
        _Timing:Int,
        _Delay:Int,
        _Frequency:Int,
        _Damp:Int,
        _EasingFunction:CommandHelper.EasingFunction,
        _EasingType:CommandHelper.EasingType)
    {
        Timing = _Timing
        Delay = _Delay
        Frequency = _Frequency
        Damp = _Damp
        EasingFunction = _EasingFunction
        EasingType = _EasingType
    }
}
