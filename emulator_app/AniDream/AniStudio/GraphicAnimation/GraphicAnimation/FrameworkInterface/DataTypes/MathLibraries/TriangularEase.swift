//
//  TriangularEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class TriangularEase:EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        let time:Int = Int(time_);
        let duration:Int = Int(_duration);
        var ctime_ = time % duration;
        
        if(ctime_ < Int((_duration/2)))
        {
            return _change * (Double(ctime_) / (Double(_duration)/2.0))
        }
        else
            if(ctime_ > Int((_duration/2)))
            {
                ctime_ = Int((_duration)) - ctime_;
                ctime_ = Int((_duration/2)) - ctime_;
                let tDivd = (Double(_change) * Double(ctime_) * -1.0)
                let tvar  = tDivd/(Double(_duration)/2.0)
                return  tvar + _change;
            }
            else
                {
                    ctime_ = Int(time_+1);
                    return   easeIn(time_: Double(ctime_));
                }
    }
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        return easeIn(time_: time_)
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        return easeIn(time_: time_)
    }
}
