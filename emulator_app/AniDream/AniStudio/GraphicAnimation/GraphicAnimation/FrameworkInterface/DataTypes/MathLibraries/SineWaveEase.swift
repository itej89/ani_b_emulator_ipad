//
//  SineWaveEase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 01/10/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class SineWaveEase : EasingBase
{
    override public func easeIn(time_:Double) -> Double
    {
        let retValue = _change*sin(time_/_duration*2 * .pi);
       
      
        return retValue
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
