//
//  GraphicControlPanel.swift
//  AniStudio
//
//  Created by Tej Kiran on 19/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit
import SceneKit
import GraphicAnimation
import FourierMachines_Ani_Client_System
import FourierMachines_Ani_Client_Common

class GraphicControlPanel: UIView, PickerViewEvents, TranslationViewDelegates
{
    
    
    //TranslationViewDelegates
    var Startx:CGFloat = 0
    var Starty:CGFloat = 0
    func InitTranslate(sender: UIView) {
        if((sender as! TranslateView) == TranslateArea)
        {
            Startx = 0
            Starty = 0
        }
    }
    
    func Translated(sender: UIView, x: CGFloat, y: CGFloat) {
        if((sender as! TranslateView) == TranslateArea)
        {
            var Transform = ImgSCNNode.transform
            Transform = SCNMatrix4Translate(Transform, 0, Float(((y*0.01)-Starty)), Float(((x*0.01)-Startx)))
            
            Startx = x*0.01
            Starty = y*0.01
            ImgSCNNode.transform = Transform
        }
    }
    
    func EndTranslate(sender: UIView) {
        UpdateTransform(Transform: ImgSCNNode.transform)
    }
    //End of TranslationViewDelegates
    
    
    
    var ImgSCNNode:SCNNode!
    var SCNTransform:SCNMatrix4!
    var ImgSCNNodeTag:AnimationObject = AnimationObject.NA
    
    @IBOutlet weak var TranslateArea: TranslateView!
    @IBOutlet weak var sldrRotate: MTCircularSlider!
    @IBOutlet weak var sldrScaleX: UISlider!
    @IBOutlet weak var sldrScaleY: UISlider!
    @IBOutlet weak var sldrAnchorX: UISlider!
    @IBOutlet weak var sldrAnchorY: UISlider!
    @IBOutlet weak var sldrOpacity: UISlider!
    
    @IBOutlet weak var PanelView: UIView!
    
    @IBOutlet weak var pkrTiming: PickerViewTimeD4!
    @IBOutlet weak var pkrDelay: PickerViewTimeD4!
    @IBOutlet weak var pkrInterpolator: PickerViewGraphicInterpolator!
    
    @IBAction func RotationAngleChanged(_ sender: Any) {
        
        var Transform = ImgSCNNode.transform
        
        let CurrentRotation = (atan2f(Float(Transform.m23), Float(Transform.m22)))
        let Degree = (sender as! MTCircularSlider).value
        let NewRotation = (Float.pi/180)*(Degree)
        
        let rotation = SCNMatrix4MakeRotation(Float(NewRotation-CurrentRotation),1, 0, 0)
        Transform = SCNMatrix4Mult(rotation, Transform)
        
       // Transform = SCNMatrix4Rotate(ImgSCNNode.transform, Float(NewRotation-CurrentRotation), 1, 0, 0)
        
        ImgSCNNode.transform = Transform
       
       UpdateTransform(Transform: Transform)
        
    }
    
    @IBAction func OpacityChanged(_ sender: Any) {
        
        let Tag = ImgSCNNodeTag
        
        ImgSCNNode.opacity = CGFloat((sender as! UISlider).value)
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).opacity = [Double((sender as! UISlider).value):true]
    }
    
    
    @IBAction func ScaleXChanged(_ sender: Any) {
        var Transform = ImgSCNNode.transform
        
        let CurrentScaleX = Transform.m33
        
        let NewScaleX = (sender as! UISlider).value
        
        
        Transform = SCNMatrix4Scale(Transform, 1, 1,  1+(NewScaleX - CurrentScaleX))
        
        ImgSCNNode.transform = Transform
        
         UpdateTransform(Transform: Transform)
    }
    
    @IBAction func ScaleYChanged(_ sender: Any) {
        var Transform = ImgSCNNode.transform
        
        let CurrentScaleY = Transform.m22
        
        let NewScaleY = (sender as! UISlider).value
        
        
        Transform = SCNMatrix4Scale(Transform, 1,  1+(NewScaleY - CurrentScaleY), 1)
        
        ImgSCNNode.transform = Transform
        
         UpdateTransform(Transform: Transform)
    }
    
    
    @IBAction func PivotXChanged(_ sender: Any) {
        
    }
    
    @IBAction func PivotYChanged(_ sender: Any) {
        
    }
    
    
    public func initialize(Element:AnimationObject)
    {
        ImgSCNNodeTag = Element
        ImgSCNNode = UIMAINModuleHandler.Instance.AniUIHandler.GetAllUIElements()[Element]!
        SCNTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: ImgSCNNodeTag, image: ImgSCNNode)
        
        TranslateArea.delegate = self
        pkrTiming.initialize(Delegate: self)
        pkrDelay.initialize(Delegate: self)
        pkrInterpolator.initialize(Delegate: self)
        
        LoadDefaults()
    }
    
    func LoadDefaults()
    {
        let Tag = ImgSCNNodeTag
        
        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.Tranformation || (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.TransformOverlay){
        let Transform2D = TransformMatrixToValueConvertor.GetValuesFromMatrix(Transform: CGAffineTransform(a: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a.keys.first!), b: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b.keys.first!), c: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c.keys.first!), d: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d.keys.first!), tx: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx.keys.first!), ty: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty.keys.first!)))
        
        sldrScaleX.value = Float(Transform2D.ScaleX)
        sldrScaleY.value = Float(Transform2D.ScaleY)
        
        sldrRotate.value = FMUnitConvertor.RadiasToDegree(radians: Float(Transform2D.RotationInRadians))
        }
        else if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.Tranformation)
        {
            AnimationActionCreator.instance.SetDefault(gTag: ImgSCNNodeTag, image: ImgSCNNode, convey: nil, Timing: 0, Delay: 0)
            
        }
        
        sldrOpacity.value = Float((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).opacity.keys.first!)
        
        pkrTiming.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).Duration)
        
        
        pkrDelay.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).Delay)
        
        pkrInterpolator.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).KeyframeAnimation_EasingFunction)
        
    }
    
    
    //PickerViewEvents
    func PickerValueChanged(PickerType: PickerViewType) {
        
        let Tag = ImgSCNNodeTag
        
        switch PickerType {
        case .TIMING:
             (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).Duration = pkrTiming.Value
            break
        case .DELAY:
             (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).Delay = pkrDelay.Value
            break
        case .GRAPHIC_INTERPOLATION:
             (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).KeyframeAnimation_EasingFunction = pkrInterpolator.Value
            break
        default:
            break
        }
    }
    //End of PickerViewEvents
    
    
    func UpdateTransform(Transform:SCNMatrix4)
    {
        let InverseIdentity = SCNMatrix4Invert(AnimationActionCreator.instance.GetDefaultTransform(gTag: ImgSCNNodeTag, image: ImgSCNNode))
        
        let IdentityReferance = SCNMatrix4Mult(Transform, InverseIdentity)
        
        
        let Tag = ImgSCNNodeTag
        
        
        //2D Coordinate system extracted from 3D
        //           y
        //           .
        //           .
        //     z . . .
        
        
        //Required 2D coordinate system
        //           y
        //           .
        //           .
        //     x . . .
        
        
        //3D change of basis matrix transposed and multiplied
        //0  0  1  0
        //0  1  0  0
        //1  0  0  0
        //0  0  0  1
        
        var ChangeOfBasis3D = SCNMatrix4Identity
        ChangeOfBasis3D.m11 = 0; ChangeOfBasis3D.m12 = 0; ChangeOfBasis3D.m13 = 1; ChangeOfBasis3D.m14 = 0;
        ChangeOfBasis3D.m21 = 0; ChangeOfBasis3D.m22 = 1; ChangeOfBasis3D.m23 = 0; ChangeOfBasis3D.m24 = 0;
        ChangeOfBasis3D.m31 = 1; ChangeOfBasis3D.m32 = 0; ChangeOfBasis3D.m33 = 0; ChangeOfBasis3D.m34 = 0;
        ChangeOfBasis3D.m41 = 0; ChangeOfBasis3D.m42 = 0; ChangeOfBasis3D.m43 = 0; ChangeOfBasis3D.m44 = 1;
        
        let IdentityReferanceB = SCNMatrix4Mult(IdentityReferance, ChangeOfBasis3D)
        

        
        let Required2D = CGAffineTransform(a: CGFloat(IdentityReferanceB.m31), b: CGFloat(IdentityReferanceB.m32), c: CGFloat(IdentityReferanceB.m21), d: CGFloat(IdentityReferanceB.m22),  tx: CGFloat(IdentityReferanceB.m41), ty: CGFloat(IdentityReferanceB.m42))
        

        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a = [Double(Required2D.a):true]
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b = [Double(Required2D.b):true]
        
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c = [Double(Required2D.c):true]
        
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d = [Double(Required2D.d):true]
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx = [-100*Double(Required2D.tx):true]
        
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty = [-100*Double(Required2D.ty):true]
       
        
                (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind = AnimationType.Tranformation
    }
    
    @IBAction func btnIdentityClicked(_ sender: Any) {
        AnimationActionCreator.instance.SetDefault(gTag: ImgSCNNodeTag, image: ImgSCNNode, convey: nil, Timing: 0, Delay: 0)
        let Tag = ImgSCNNodeTag
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind = AnimationType.Identity
    }
    
    
    @IBAction func btnSymmentryClicked(_ sender: Any) {
        
        var json = (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[SymmetricAnimationObject[ImgSCNNodeTag]!] as! ImageAnimationState).Json()
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag]as! ImageAnimationState).parseJson(json: json.parseJSONString as! NSDictionary)
        
        json = (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[SymmetricAnimationObject[ImgSCNNodeTag]!] as! ImageAnimationTransition).Json()
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[ImgSCNNodeTag] as! ImageAnimationTransition).parseJson(json: json.parseJSONString as! NSDictionary)
        
        
        
          if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).AnimationKind == AnimationType.Tranformation)
          {
            var ImageOpacity = ImgSCNNode.opacity
            
            if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).opacity.values.first)!{
                
                
                ImageOpacity = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).opacity.keys.first!)
                
            }
            
            //                        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.values.first)!{
            //
            //
            //                            image.center.x = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.keys.first!)
            //
            //                        }
            //
            //
            //                        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.values.first)!{
            //
            //
            //                            image.center.y = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.keys.first!)
            //
            //                        }
            
            
            var transform:CGAffineTransform = CGAffineTransform();
            
            transform.a = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).Matrix.a.keys.first!)
            
            transform.b = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).Matrix.b.keys.first!)
            
            transform.c = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).Matrix.c.keys.first!)
            
            transform.d = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).Matrix.d.keys.first!)
            
            transform.tx = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).Matrix.tx.keys.first!)
            
            transform.ty = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).Matrix.ty.keys.first!)
            
            
            let transform2D:TransformValues = TransformMatrixToValueConvertor.GetValuesFromMatrix(Transform: transform);
            var oldTransform = ImgSCNNode.transform
            oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: ImgSCNNodeTag, image: ImgSCNNode)
            
            
            let rotation = SCNMatrix4MakeRotation(Float(transform2D.RotationInRadians),1, 0, 0)
            oldTransform = SCNMatrix4Mult(rotation, oldTransform)
            let scale = SCNMatrix4Scale(oldTransform, 1, Float(transform2D.ScaleY), Float(transform2D.ScaleX))
            let ty = (Float(transform2D.Ty))/100
            let tx = (Float(transform2D.Tx))/100
            let trasnlate = SCNMatrix4Translate(scale, 0, -1*ty, -1*tx)
            
            
            
                ImgSCNNode.transform = trasnlate
                ImgSCNNode.opacity = ImageOpacity
                
            
            
          }
        
            
    else if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[ImgSCNNodeTag] as! ImageAnimationState).AnimationKind == AnimationType.Identity)
    {
    AnimationActionCreator.instance.SetDefault(gTag: ImgSCNNodeTag, image: ImgSCNNode, convey: nil, Timing: 0, Delay: 0)
    }
         LoadDefaults()
    }
}
