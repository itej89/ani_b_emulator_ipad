//
//  EasingBase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class EasingBase: IEasingBase
{
    public var _change: Double
    
    public var _duration:Double = 0
    
    public var _totalduration: Double = 0
    
    public var _damping: Double = 0
    
    public var _velocity: Double = 0
    
    public func easeIn(time_: Double) -> Double {
        return 0
    }
    
    public func easeOut(time_: Double) -> Double {
        return 0
    }
    
    public func easeInOut(time_: Double) -> Double {
        return 0
    }
    
    public func setDuration(duration_: Double) {
        _duration=duration_;
    }
    
    public func setTotalDuration(totalduration_: Double) {
        _totalduration = totalduration_;
    }
    
    public func setTotalChangeInPosition(totalChangeInPosition_: Double) {
        _change=totalChangeInPosition_;
    }
    
    public func setSpringWaveDamping(damping_: Double) {
        _damping = damping_;
    }
    
    public func setSpringWaveVelocity(velocity_: Double) {
        _velocity = velocity_;
    }
    
    public init()
    {
    _change=0;
    }
    
}
