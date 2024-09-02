//
//  AnimationEngineParameterType.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 27/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class AnimationEngineParameterType
{
    
    
    public var delegate:AnimationParameterTypeDelegates!
    
    public var CustomPositionParameters:AnimationPositions!
    
    public var animationPosition:AnimationPositions!
    
    public var IsHalfBlink:Bool = false
    
    public var Json:NSDictionary!
    public var sentance:String = ""
    
    //Added for Choreogram
    public var audio:String = ""
    public var StartSec:Int = 0
    public var EndSec:Int = 0
    
    public var TriggerType:MotionStartType = MotionStartType.WAIT_AND_MOVE
    public func setParameter(object:AnimationObject)
    {
    
    }
    
    public  func  destroy()
    {
    if(animationPosition != nil)
    {
    animationPosition.destroy();
    // animationPosition = null;
    
    }
    }
}
