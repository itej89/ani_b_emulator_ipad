//
//  MotorAnimationState.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class MotorAnimationState: AnimationState
{
    public var TargetObject: AnimationObject = AnimationObject.NA
    public var IsDeltaAngle:Bool = false
    public var Angle:[Int : Bool] = [0 : false];
    
    
    override func parseJson(json : NSDictionary)
    {
        
        var dictionary =  json["AnimationState"] as! NSDictionary
        
        IsDeltaAngle = Bool(dictionary["IsDeltaAngle"] as! String)!
        
        dictionary =  dictionary["Angle"] as! NSDictionary
        
        Angle = [Int(dictionary["key"] as! String)! : Bool(dictionary["value"] as! String)!]
        
        
    }
    
    
    override func Json() -> String{
        
        
        var json = ""
        
        json.append("{ \"AnimationState\" : {")
        json.append(" \"IsDeltaAngle\" : \""+String(IsDeltaAngle)+"\" , ")
        json.append(" \"Angle\" : {")
        json.append(String(" \"key\" : \""+String(describing : Angle.keys.first!)+"\" , "+" \"value\" : \""+String(describing: Angle.values.first!)+"\" "))
        json.append("}}")
        
        json.append("}")
        
        return json
        
    }
    
    override init(){}
    
    init(_TargetObject: AnimationObject,
         _Angle:[Int : Bool]
        )
    {
        Angle = _Angle
    }
    
}



