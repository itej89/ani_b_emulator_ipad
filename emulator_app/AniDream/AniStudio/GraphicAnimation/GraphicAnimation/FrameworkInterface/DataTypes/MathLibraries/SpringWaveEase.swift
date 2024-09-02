//
//  SpringWaveEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 01/10/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class SpringWaveEase : EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        let duration:Double = _duration*((pow(2,((time_ / _totalduration)))-0.2)*sin(time_/_totalduration * .pi/2) + (_velocity/10));
        return  _change*pow(2,-1 * _damping*(time_ / _totalduration)-1) * sin(time_ / duration * 2 * .pi);
    }
    
    override public  func easeOut(time_:Double) -> Double
    {
        return easeIn(time_: time_);
    }
    
    override public  func easeInOut(time_:Double) -> Double
    {
        return easeIn(time_: time_);
    }
}
