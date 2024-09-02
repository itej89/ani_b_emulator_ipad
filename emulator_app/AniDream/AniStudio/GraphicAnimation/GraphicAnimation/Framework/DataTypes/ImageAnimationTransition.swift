//
//  ImageAnimationTransition.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


//All timings are in milliseconds

public class ImageAnimationTransition: AnimationTransition
{
    public enum TransitionType {case NA, Transition, Identity}
    
    public var ImageTransitionType:TransitionType = TransitionType.Transition
    
   public var Duration:Int = 1000
   public var Delay:Int = 0
   public var AnimationCurveType:UIView.AnimationOptions = [UIView.AnimationOptions.allowUserInteraction, UIView.AnimationOptions.transitionCrossDissolve]
    public var Damping:Double = 0.0
    public var Amplitude:Double = 0.0
    
    public var KeyframeAnimation_EasingFunction:AnimationEasingTypes = AnimationEasingTypes.linear
    public var KeyframeAnimation_FillMode:AnimationFillModes = AnimationFillModes.Removed
    
    
    
  public  override func parseJson(json : NSDictionary)
    {
        
        var dictionary =  json["Transition"] as! NSDictionary
        
        Duration = Int(dictionary["Duration"] as! String)!
        Delay = Int(dictionary["Delay"] as! String)!
        Amplitude = Double(dictionary["Amplitude"] as! String)!
        Damping = Double(dictionary["Damping"] as! String)!
        KeyframeAnimation_EasingFunction = AnimationEasingTypesStringToOptions[dictionary["KeyframeAnimation_EasingFunction"] as! String]!
        KeyframeAnimation_FillMode = AnimationFillModesStringToOptions[dictionary["KeyframeAnimation_FillMode"] as! String]!
        dictionary =  dictionary["AnimationCurveType"] as! NSDictionary
        
        
        
        for item in dictionary
        {
            AnimationCurveType.insert(UITransitionCurveStringToOptions[item.value as! String]!)
        }
        
        
    }
    
    
  public  override func Json() -> String
    {
        
        var json = ""
        
        json.append("{ \"Transition\" : {")
        
        json.append(" \"Duration\" : \""+String(describing : Duration)+"\" ,")
        
        json.append(" \"Delay\" : \""+String(describing : Delay)+"\" ,")
        
        json.append(" \"Damping\" : \""+String(describing : Damping)+"\" ,")
        
        json.append(" \"Amplitude\" : \""+String(describing : Amplitude)+"\" ,")
        
        json.append(" \"KeyframeAnimation_EasingFunction\" : \""+KeyframeAnimation_EasingFunction.description+"\" ,")
        
        json.append(" \"KeyframeAnimation_FillMode\" : \""+KeyframeAnimation_FillMode.description+"\" ,")
        
        json.append(" \"AnimationCurveType\" : {")
        
        var i = 0
        
        
        while i < UIElementAnimatioOptions.count
        {
            
            if(AnimationCurveType.contains(UITransitionCurveOptions[i]!))
            {
                json.append(" \"key\" : \""+(UIElementAnimatioOptions(rawValue: i)?.description)!+"\" ,")
            }
            
            i = i+1
            
        }
        
        
        json =  String(json.dropLast())
        
        json.append(" } ")
        
        json.append("}}")
        
        return json
        
    }
    
    
    override init()
    {}
    
    init(_ImageTransitionType:TransitionType,
         _Duration:Int,
         _Delay:Int,
         _AnimationCurveType:UIView.AnimationOptions,
         _Damping:Double,
         _Amplitude:Double)
    {
        ImageTransitionType = _ImageTransitionType
        Duration = _Duration
        Delay = _Delay
        AnimationCurveType = _AnimationCurveType
        Damping = _Damping
        Amplitude = _Amplitude
    }
    
}
