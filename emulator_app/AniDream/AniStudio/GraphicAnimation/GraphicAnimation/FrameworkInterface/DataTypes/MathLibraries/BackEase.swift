//
//  BackEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public class BackEase:EasingBase
{
    var _overshoot:Double
    
    public override init() {
        _overshoot = 1.70158;
    }
    
    override public func easeIn(time_:Double) -> Double
    {
        let ctime_ = time_/_duration;
        return _change*ctime_*ctime_*((_overshoot+1)*ctime_-_overshoot);
    }
    
    /*
     * Ease out
     */
    
    override public  func easeOut(time_:Double) -> Double
    {
        let ctime_ = time_/_duration-1
        
        return _change*(ctime_*ctime_*((_overshoot+1)*ctime_+_overshoot)+1)
    }
    
    
    /*
     * Ease in and out
     */
    
    override public  func easeInOut(time_:Double) -> Double
    {
        var overshoot:Double
        
        overshoot=_overshoot*1.525;
        var ctime_ = time_/(_duration/2)
        
        if(ctime_<1)
        {
        return _change/2*(ctime_*ctime_*((overshoot+1)*ctime_-overshoot))
        }
        
        ctime_ = ctime_ - 2;
        return _change/2*(ctime_*ctime_*((overshoot+1)*ctime_+overshoot)+2)
    }
}
