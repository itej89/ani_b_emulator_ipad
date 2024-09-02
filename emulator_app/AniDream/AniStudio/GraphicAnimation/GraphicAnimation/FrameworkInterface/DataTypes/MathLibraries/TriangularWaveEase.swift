//
//  TriangularWaveEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class TriangularWaveEase : EasingBase
{
    
    override public func easeIn(time_:Double) -> Double
    {
        let time:Int = Int(time_);
        let duration:Int = Int(_duration);
        
        var ctime_ = time_
        
        ctime_ = Double(time % duration);
        
        if(ctime_ <= (_duration/4))
        {
            return _change*ctime_/(_duration/4);
        }
        else
            if(ctime_ <= (_duration/2))
            {
                ctime_ = ctime_ - (_duration/4);
                
                return ((_change*ctime_ * -1)/(_duration/4))+_change;
            }
            else
                if(time_ <= ((3*_duration)/4))
                {
                    ctime_ = ctime_ -  (_duration/2);
                    return _change*ctime_ * -1/(_duration/4);
                }
                else
                    if(ctime_ <= _duration)
                    {
                        ctime_ = ctime_ -  (3 * _duration/4);
                        
                        return ((((_change*ctime_)/(_duration/4))-_change));
        }
        
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
