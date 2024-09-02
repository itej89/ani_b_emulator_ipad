//
//  TranslateView.swift
//  Ani_AnimationStudio
//
//  Created by Uday on 26/05/17.
//  Copyright © 2017 Ani. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TranslateView: UIControl {
    
    
    var delegate:TranslationViewDelegates!
    
    var xCoord:CGFloat = 0
     var yCoord:CGFloat = 0
    var startPoint: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            startPoint = theTouch.location(in: self)
            let x = startPoint!.x
            let y = startPoint!.y
            xCoord = x
            yCoord = y
            if(delegate != nil){
                delegate.InitTranslate(sender: self)
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            
            let touchLocation = theTouch.location(in: self)
            let x = touchLocation.x
            let y = touchLocation.y
            
            xCoord = x
            yCoord = y
            
            if(delegate != nil){
                delegate.Translated(sender: self, x: startPoint!.x-xCoord, y: (startPoint?.y)!-yCoord)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            
            let endPoint = theTouch.location(in: self)
            let x = endPoint.x
            let y = endPoint.y
            
            xCoord = x
            yCoord = y
            if(delegate != nil){
                delegate.EndTranslate(sender: self)
            }
        }
    }

    
}
