//
//  UIElementAnimatioOptions.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

enum UIElementAnimatioOptions : Int, CustomStringConvertible {
    case autoreverse = 0
    case  beginFromCurrentState = 1
    case  curveEaseIn = 2
    case  curveEaseInOut = 3
    case  curveEaseOut = 4
    case  curveLinear = 5
    case  showHideTransitionViews = 6
    case  transitionCrossDissolve = 7
    case  transitionCurlDown = 8
    case  transitionCurlUp = 9
    case  transitionFlipFromBottom = 10
    case  transitionFlipFromLeft = 11
    case  transitionFlipFromRight = 12
    case  transitionFlipFromTop = 13
    case allowUserInteraction = 14
    
    static var count: Int { return UIElementAnimatioOptions.allowUserInteraction.rawValue + 1 }
    
    var description: String {
        switch self {
        case .autoreverse: return "autoreverse"
        case .beginFromCurrentState   : return "beginFromCurrentState"
        case .curveEaseIn  : return "curveEaseIn"
        case .curveEaseInOut : return "curveEaseInOut"
        case .curveEaseOut: return "curveEaseOut"
        case .curveLinear   : return "curveLinear"
        case .showHideTransitionViews  : return "showHideTransitionViews"
        case .transitionCrossDissolve : return "transitionCrossDissolve"
        case .transitionCurlDown: return "transitionCurlDown"
        case .transitionCurlUp   : return "transitionCurlUp"
        case .transitionFlipFromBottom  : return "transitionFlipFromBottom"
        case .transitionFlipFromLeft : return "transitionFlipFromLeft"
        case .transitionFlipFromRight  : return "transitionFlipFromRight"
        case .transitionFlipFromTop : return "transitionFlipFromTop"
        case .allowUserInteraction : return "allowUserInteraction"
        }
    }
    
    
}

var UITransitionCurveStringToOptions:[String : UIView.AnimationOptions] = ["autoreverse":UIView.AnimationOptions.autoreverse,
                                                                           "beginFromCurrentState":UIView.AnimationOptions.beginFromCurrentState,"curveEaseIn":UIView.AnimationOptions.curveEaseIn, "curveEaseInOut":UIView.AnimationOptions.curveEaseInOut, "curveEaseOut":UIView.AnimationOptions.curveEaseOut, "curveLinear":UIView.AnimationOptions.curveLinear, "showHideTransitionViews":UIView.AnimationOptions.showHideTransitionViews, "transitionCrossDissolve":UIView.AnimationOptions.transitionCrossDissolve, "transitionCurlDown":UIView.AnimationOptions.transitionCurlDown, "transitionCurlUp":UIView.AnimationOptions.transitionCurlUp, "transitionFlipFromBottom":UIView.AnimationOptions.transitionFlipFromBottom, "transitionFlipFromLeft":UIView.AnimationOptions.transitionFlipFromLeft, "transitionFlipFromRight":UIView.AnimationOptions.transitionFlipFromRight, "transitionFlipFromTop":UIView.AnimationOptions.transitionFlipFromTop , "allowUserInteraction":UIView.AnimationOptions.allowUserInteraction ]

var UITransitionCurveOptions:[Int : UIView.AnimationOptions] = [0:UIView.AnimationOptions.autoreverse,
                                                                1:UIView.AnimationOptions.beginFromCurrentState,2:UIView.AnimationOptions.curveEaseIn, 3:UIView.AnimationOptions.curveEaseInOut, 4:UIView.AnimationOptions.curveEaseOut, 5:UIView.AnimationOptions.curveLinear, 6:UIView.AnimationOptions.showHideTransitionViews, 7:UIView.AnimationOptions.transitionCrossDissolve, 8:UIView.AnimationOptions.transitionCurlDown, 9:UIView.AnimationOptions.transitionCurlUp, 10:UIView.AnimationOptions.transitionFlipFromBottom, 11:UIView.AnimationOptions.transitionFlipFromLeft, 12:UIView.AnimationOptions.transitionFlipFromRight, 13:UIView.AnimationOptions.transitionFlipFromTop , 14:UIView.AnimationOptions.allowUserInteraction ]

