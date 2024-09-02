//
//  EasingBase.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 23/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol IEasingBase
{
    var _change:Double { get set }
    var _duration:Double { get set }
    var _totalduration:Double { get set }
    var _damping:Double { get set }
    var _velocity:Double { get set }
    
     func easeIn(time_:Double) -> Double
     func easeOut(time_:Double)  -> Double
     func easeInOut(time_:Double) -> Double
    
    func setDuration( duration_:Double)
    func setTotalDuration( totalduration_:Double)
    func setTotalChangeInPosition( totalChangeInPosition_:Double)
    func setSpringWaveDamping( damping_:Double)
    func setSpringWaveVelocity( velocity_:Double)
}
