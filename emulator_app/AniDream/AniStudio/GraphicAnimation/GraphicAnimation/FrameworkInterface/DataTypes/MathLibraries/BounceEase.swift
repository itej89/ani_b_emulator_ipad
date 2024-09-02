//
//  BounceEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class BounceEase:EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        return _change-easeOut(time_: _duration-time_)
    }
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
       var ctime_ = time_/_duration;
        
        if(ctime_<(1/2.75))
        {
        return _change*(7.5625*ctime_*ctime_)
        }
        
        if(ctime_<(2/2.75))
        {
            ctime_ = ctime_ - 1.5/2.75;
            return _change*(7.5625*ctime_*ctime_+0.75);
        }
        
        if(ctime_<(2.5/2.75))
        {
            ctime_ = ctime_ - 2.25/2.75;
            return _change*(7.5625*ctime_*ctime_+0.9375);
        }
        
        ctime_ = ctime_ - 2.625/2.75;
        return _change*(7.5625*ctime_*ctime_+0.984375);
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        if(time_<_duration/2)
        {
            return easeIn(time_: time_*2)*0.5
        }
        else
        {
            return easeOut(time_: time_*2-_duration)*0.5+_change*0.5
        }
    }
}
