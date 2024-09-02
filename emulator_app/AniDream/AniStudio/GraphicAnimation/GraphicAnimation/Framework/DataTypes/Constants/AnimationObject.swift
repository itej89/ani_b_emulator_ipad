//
//  AnimationObject.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public enum AnimationObject:Int, CustomStringConvertible {
    case Image_EyeBrowRight = 20,
    Image_EyeBrowLeft = 15,
    Image_EyeBallRight = 17,
    Image_EyeBallLeft = 12,
    Image_EyeRight = 16,
    Image_EyeLeft = 11,
    Image_EyePupilRight = 18,
    Image_EyePupilLeft = 13,
    Image_EyeLidRight = 19,
    Image_EyeLidLeft = 14,
    Motor_Turn = 21,
    Motor_Lift = 22,
    Motor_Lean = 23,
    Motor_Tilt = 24,
    
    //Added for 3D Emulator Graphic Elements
    Motor_Turn_Graphic = 25,
    Motor_Lift_Graphic = 26,
    Motor_Lean_Graphic = 27,
    Motor_Tilt_Graphic = 28,
    
    NA = -1
    
    
    public var description: String {
        switch self {
        case .Image_EyeBrowRight: return "Image_EyeBrowRight"
        case .Image_EyeBrowLeft   : return "Image_EyeBrowLeft"
        case .Image_EyeBallRight  : return "Image_EyeBallRight"
        case .Image_EyeBallLeft : return "Image_EyeBallLeft"
        case .Image_EyeRight: return "Image_EyeRight"
        case .Image_EyeLeft   : return "Image_EyeLeft"
        case .Image_EyePupilRight  : return "Image_EyePupilRight"
        case .Image_EyePupilLeft : return "Image_EyePupilLeft"
        case .Image_EyeLidRight: return "Image_EyeLidRight"
        case .Image_EyeLidLeft   : return "Image_EyeLidLeft"
        case .Motor_Turn  : return "Motor_Turn"
        case .Motor_Lift : return "Motor_Lift"
        case .Motor_Lean  : return "Motor_Lean"
        case .Motor_Tilt : return "Motor_Tilt"
        default: return ""
        }
    }
    
}


public var SymmetricAnimationObject:[AnimationObject:AnimationObject] = [ AnimationObject.Image_EyeLidLeft:AnimationObject.Image_EyeLidRight, AnimationObject.Image_EyeBrowLeft:AnimationObject.Image_EyeBrowRight, AnimationObject.Image_EyeBallLeft:AnimationObject.Image_EyeBallRight, AnimationObject.Image_EyePupilLeft:AnimationObject.Image_EyePupilRight, AnimationObject.Image_EyeLeft:AnimationObject.Image_EyeRight,
    AnimationObject.Image_EyeRight:AnimationObject.Image_EyeLeft,
    AnimationObject.Image_EyePupilRight:AnimationObject.Image_EyePupilLeft,
    AnimationObject.Image_EyeBallRight:AnimationObject.Image_EyeBallLeft,
    AnimationObject.Image_EyeBrowRight:AnimationObject.Image_EyeBrowLeft,
    AnimationObject.Image_EyeLidRight:AnimationObject.Image_EyeLidLeft]
