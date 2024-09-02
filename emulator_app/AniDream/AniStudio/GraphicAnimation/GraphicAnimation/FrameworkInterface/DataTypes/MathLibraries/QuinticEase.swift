//
//  QuinticEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class QuinticEase:EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        let ctime_ = time_/_duration
        return _change*ctime_*ctime_*ctime_*ctime_*ctime_
    }
    
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        let ctime_ = time_/(_duration-1)
        return -_change * (ctime_*ctime_*ctime_*ctime_*ctime_+1)
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        var ctime_ = time_/(_duration/2)
        if (ctime_<1)
        {
            return _change/2*ctime_*ctime_*ctime_*ctime_*ctime_
        }
        
        ctime_ = ctime_ - 2
        return -_change/2*(ctime_*ctime_*ctime_*ctime_*ctime_+2);
    }
}
