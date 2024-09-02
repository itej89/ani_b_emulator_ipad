//
//  LinearEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class LinearEase : EasingBase
{
    
    override public func easeIn(time_:Double) -> Double
    {
    return _change*time_/_duration;
    }
    
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        return easeIn(time_: time_);
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        return easeIn(time_: time_);
    }
}
