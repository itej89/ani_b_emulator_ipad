//
//  ExponentialEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class ExponentialEase:EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        
        return time_==0 ? 0 : _change*pow(2,10*(time_/_duration)-1)
    }
    
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        return time_==_duration ? _change : _change*(-pow(2,-10*time_/_duration)+1);
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        if(time_==0)
        {
        return 0
        }
        
        if(time_==_duration)
        {
        return _change
        }
        
        var ctime_ = time_/(_duration/2)
        
        if(ctime_<1)
        {
        return _change/2*pow(2,10*(ctime_-1))
        }
        
        ctime_ = ctime_ - 1
        return _change/2*(-pow(2,-10*ctime_)+2);
    }
}
