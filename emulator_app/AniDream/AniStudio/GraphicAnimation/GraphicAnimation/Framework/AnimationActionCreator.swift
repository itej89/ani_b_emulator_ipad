//
//  AnimationActionCreator.swift
//  Ani_AnimationStudio
//
//  Created by Uday on 03/06/17.
//  Copyright © 2017 Ani. All rights reserved.
//

import Foundation
import UIKit

import SceneKit

public class AnimationActionCreator {
    
   public var DefaultState:AnimationAction = AnimationAction()
    
     public var CurrentAnimation:AnimationAction = AnimationAction()

     var CurrentImageView:SCNNode!
    
    init()
    {
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Turn_Graphic] = ImageAnimationState(_TargetObject: AnimationObject.Motor_Turn_Graphic, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Lift_Graphic] = ImageAnimationState(_TargetObject: AnimationObject.Motor_Lift_Graphic, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Lean_Graphic] = ImageAnimationState(_TargetObject: AnimationObject.Motor_Lean_Graphic, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Tilt_Graphic] = ImageAnimationState(_TargetObject: AnimationObject.Motor_Tilt_Graphic, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeBrowRight] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeBrowLeft] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeRight] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeLeft] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeBallRight] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeBallLeft] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyePupilRight] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyePupilLeft] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeLidLeft] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Image_EyeLidRight] = ImageAnimationState(_TargetObject: AnimationObject.Image_EyeBrowRight, _a: [1:true], _b: [0:true], _c: [0:true], _d: [1:true], _tx: [0 : true], _ty: [0: true],_opacity: [0:false], _centreX: [0:false], _centreY: [0:false], _anchorX: [0:false], _anchorY: [0:false])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Tilt] = MotorAnimationState(_TargetObject: AnimationObject.Motor_Tilt, _Angle: [81 : true])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Lean] = MotorAnimationState(_TargetObject: AnimationObject.Motor_Lean, _Angle: [89 : true])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Lift] = MotorAnimationState(_TargetObject: AnimationObject.Motor_Lift, _Angle: [90 : true])
        
        DefaultState.Position.State.StateSet[AnimationObject.Motor_Turn] = MotorAnimationState(_TargetObject: AnimationObject.Motor_Turn, _Angle: [99 : true])
        
     /*   var data = DefaultState.Json()
        let jsonObject = data.parseJSONString
        DefaultState.Position.parseJson(json: (jsonObject as! NSDictionary))
        data = DefaultState.Json()
        */

    }
    
    
    public func GetDefaultTransform(gTag:AnimationObject, image:SCNNode)->SCNMatrix4
    {
        var Tag = gTag
        
        if(Tag == AnimationObject.Motor_Turn)
        {
            Tag = AnimationObject.Motor_Turn_Graphic
        }
        else
            if(Tag == AnimationObject.Motor_Lift)
            {
                Tag = AnimationObject.Motor_Lift_Graphic
            }
            else
                if(Tag == AnimationObject.Motor_Lean)
                {
                    Tag = AnimationObject.Motor_Lean_Graphic
                }
                else
                    if(Tag == AnimationObject.Motor_Tilt)
                    {
                        Tag = AnimationObject.Motor_Tilt_Graphic
        }
        
        var transform = SCNMatrix4Identity
        transform.m11 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a.keys.first!))
        transform.m12 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b.keys.first!))
        transform.m13 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m13.keys.first!))
        transform.m14 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m14.keys.first!))
        
        transform.m21 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c.keys.first!))
        transform.m22 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d.keys.first!))
        transform.m23 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m23.keys.first!))
        transform.m24 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m24.keys.first!))
        
        transform.m31 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m31.keys.first!))
        transform.m32 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m32.keys.first!))
        transform.m33 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m33.keys.first!))
        transform.m34 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m34.keys.first!))
        
        transform.m41 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx.keys.first!))
        transform.m42 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty.keys.first!))
        transform.m43 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m43.keys.first!))
        transform.m44 = Float(((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m44.keys.first!))
        
        //        SCNTransaction.begin()
        //        SCNTransaction.animationDuration = CFTimeInterval(1000)
       
        //        SCNTransaction.commit()
        
        
      
        
         return transform
    }
    
    public  func SetDefault(gTag:AnimationObject, image:SCNNode,  convey:AnimationActionCreatorConvey!,   Timing:Int,  Delay:Int) {
        
        var Tag = gTag
        
        if(Tag == AnimationObject.Motor_Turn)
        {
            Tag = AnimationObject.Motor_Turn_Graphic
        }
        else
            if(Tag == AnimationObject.Motor_Lift)
            {
                Tag = AnimationObject.Motor_Lift_Graphic
            }
            else
                if(Tag == AnimationObject.Motor_Lean)
                {
                    Tag = AnimationObject.Motor_Lean_Graphic
                }
                else
                    if(Tag == AnimationObject.Motor_Tilt)
                    {
                        Tag = AnimationObject.Motor_Tilt_Graphic
        }
        
        
        
        let transform = GetDefaultTransform(gTag: gTag, image: image)
        let ImageOpacity = CGFloat((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).opacity.keys.first!)
        
            Timer.scheduledTimer(withTimeInterval: TimeInterval(Delay), repeats: false) {_ in
                
       
                image.pivot.m43 = Float((self.DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorX.keys.first!)
                
                 image.pivot.m42 = Float((self.DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorY.keys.first!)
//
//                image.position  = SCNVector3(Float((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.keys.first!), Float((DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.keys.first!), image.position.z)
        
                SCNTransaction.begin()
                SCNTransaction.animationDuration = CFTimeInterval(Timing)
                SCNTransaction.completionBlock =  {
                    if(convey != nil){
                    convey.SetDefaultCompleted(Tag: Tag)
                    }
                }
                image.transform = transform
                image.opacity = ImageOpacity
                
                SCNTransaction.commit()
        }
    }
    
  public  func updateDefaultState(Tag:AnimationObject,image:SCNNode)
    {
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a = [Double(image.transform.m11):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b = [Double(image.transform.m12):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c = [Double(image.transform.m21):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d = [Double(image.transform.m22):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx = [Double(image.transform.m41):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty = [Double(image.transform.m42):true]
        
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m13 = [Double(image.transform.m13):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m14 = [Double(image.transform.m14):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m23 = [Double(image.transform.m23):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m24 = [Double(image.transform.m24):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m31 = [Double(image.transform.m31):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m32 = [Double(image.transform.m32):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m33 = [Double(image.transform.m33):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m34 = [Double(image.transform.m34):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m43 = [Double(image.transform.m43):true]
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.m44 = [Double(image.transform.m44):true]
        
        
        
//        if(Tag == AnimationObject.Image_EyeBrowLeft || Tag == AnimationObject.Image_EyeBrowRight)
//        {
//            (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty  = [1.48:true]
//        }
//        else
//        {
//            (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty  = [-0.37:true]
//        }
        
        
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).opacity = [Double(image.opacity):true]
        
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).centreX = [Double(image.position.z):true]
        
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).centreY = [Double(image.position.y):true]
        
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorX = [Double(image.pivot.m43):true]
        
        
        (DefaultState.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorY = [Double(image.pivot.m42):true]
        
    }
    
    
  public static let instance = AnimationActionCreator()
    
}


