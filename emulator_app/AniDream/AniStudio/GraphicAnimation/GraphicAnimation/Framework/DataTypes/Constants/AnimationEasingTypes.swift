//
//  AnimationEasingTypes.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum AnimationEasingTypes: Int, CustomStringConvertible {
    case linear = 0
    case  easeIN = 1
    case  easeOut = 2
    case  easeInOut = 3
    
    public  static var count: Int { return AnimationEasingTypes.easeInOut.hashValue + 1 }
    
    public  var description: String {
        switch self {
        case .linear: return "linear"
        case .easeIN   : return "easeIN"
        case .easeOut  : return "easeOut"
        case .easeInOut : return "easeInOut"
            
        }
    }
    
}

public var AnimationEasingTypesStringToOptions:[String : AnimationEasingTypes] = ["linear":AnimationEasingTypes.linear,
                                                                                  "easeIN":AnimationEasingTypes.easeIN,"easeOut":AnimationEasingTypes.easeOut,"easeInOut":AnimationEasingTypes.easeInOut]

public var AnimationEasingTypesToCAMediaTimingFunction:[AnimationEasingTypes : String] = [AnimationEasingTypes.linear:CAMediaTimingFunctionName.linear.rawValue, AnimationEasingTypes.easeIN:CAMediaTimingFunctionName.easeIn.rawValue, AnimationEasingTypes.easeOut:CAMediaTimingFunctionName.easeOut.rawValue,AnimationEasingTypes.easeInOut:CAMediaTimingFunctionName.easeInEaseOut.rawValue,]

