//
//  CommonEnum.swift
//  Ani_AnimationStudio
//
//  Created by Uday on 29/05/17.
//  Copyright © 2017 Ani. All rights reserved.
//

import Foundation
import UIKit


public enum AnimationType: Int, CustomStringConvertible {
    case Tranformation = 0
    case  CircularPath = 1
    case Identity = 2
    case TransformOverlay = 3
    case  NA = 4
   public static var count: Int { return AnimationType.NA.hashValue + 1 }
    
   public var description: String {
        switch self {
        case .Tranformation: return "Tranformation"
        case .CircularPath   : return "CircularPath"
        case .Identity : return "Identity"
        case .TransformOverlay : return "TransformOverlay"
        case .NA   : return "NA"
        }
    }
}

var AnimationTypeStringToOptions:[String : AnimationType] = ["Tranformation":AnimationType.Tranformation,
                                                             "CircularPath":AnimationType.CircularPath,
                                                             "Identity":AnimationType.Identity,
                                                             "TransformOverlay":AnimationType.TransformOverlay,
    "NA":AnimationType.NA]



//
//enum UIImageElementTags:Int {
//    case ImageLeftEye=11
//    case ImageLeftEyeBall=12
//    case ImageLeftEyePupil=13
//    case ImageLeftEyeClose=14
//    case ImageLeftEyeBrow=15
//    case ImageRightEye=16
//    case ImageRightEyeBall=17
//    case ImageRightEyePupil=18
//    case ImageRightEyeClose=19
//    case ImageRightEyeBrow=20
//}
//
//
//var UIImageElementStrings:[UIImageElementTags: String] = [ UIImageElementTags.ImageLeftEye : "ImageLeftEye", UIImageElementTags.ImageLeftEyeBall : "ImageLeftEyeBall", UIImageElementTags.ImageLeftEyePupil : "ImageLeftEyePupil", UIImageElementTags.ImageLeftEyeClose : "ImageLeftEyeClose", UIImageElementTags.ImageLeftEyeBrow : "ImageLeftEyeBrow", UIImageElementTags.ImageRightEye : "ImageRightEye", UIImageElementTags.ImageRightEyeBall : "ImageRightEyeBall", UIImageElementTags.ImageRightEyePupil : "ImageRightEyePupil", UIImageElementTags.ImageRightEyeClose : "ImageRightEyeClose", UIImageElementTags.ImageRightEyeBrow : "ImageRightEyeBrow"  ]
//
//
