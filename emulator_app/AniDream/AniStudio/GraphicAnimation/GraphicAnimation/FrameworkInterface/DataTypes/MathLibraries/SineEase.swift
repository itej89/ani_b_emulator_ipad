//
//  SineEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class SineEase:EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        
        return -_change * cos(time_/_duration * .pi/2) + _change
    }
    
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        return _change * sin(time_/_duration * .pi/2);
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        return -_change/2 * (cos(.pi * time_/_duration) - 1);
    }
}
