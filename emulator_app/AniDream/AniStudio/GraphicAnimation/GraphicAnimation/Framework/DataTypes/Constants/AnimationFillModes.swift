//
//  AnimationFillModes.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public enum AnimationFillModes: Int, CustomStringConvertible {
    case Removed = 0
    case  Forward = 1
    case  Backward = 2
    case  ForwardAndBackWard = 3
    
    static var count: Int { return AnimationFillModes.ForwardAndBackWard.hashValue + 1 }
    
    public var description: String {
        switch self {
        case .Removed: return "Removed"
        case .Forward   : return "Forward"
        case .Backward  : return "Backward"
        case .ForwardAndBackWard : return "ForwardAndBackWard"
            
        }
    }
    
    
}

var AnimationFillModesStringToOptions:[String : AnimationFillModes] = ["Removed":AnimationFillModes.Removed,
                                                                       "Forward":AnimationFillModes.Forward,"Backward":AnimationFillModes.Backward,"ForwardAndBackWard":AnimationFillModes.ForwardAndBackWard]
var AnimationFillModesToCGPathFillMode:[AnimationFillModes : String] = [AnimationFillModes.Backward:CAMediaTimingFillMode.backwards.rawValue,
                                                                        AnimationFillModes.Forward:CAMediaTimingFillMode.forwards.rawValue,
                                                                        AnimationFillModes.ForwardAndBackWard:CAMediaTimingFillMode.both.rawValue,
                                                                        AnimationFillModes.Removed:CAMediaTimingFillMode.removed.rawValue]

