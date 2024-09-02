//
//  MotionControlPanel.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit
import SceneKit
import GraphicAnimation
import FourierMachines_Ani_Client_System
import FourierMachines_Ani_Client_Common

class MotionControlPanel: UIView, PickerViewEvents {
    
    var ImgSCNNode:SCNNode!
    var SCNTransform:SCNMatrix4!
    var ImgSCNNodeTag:AnimationObject = AnimationObject.NA
    
    var IsEnabled = false

    @IBOutlet weak var tglSwitch: UISwitch!
    @IBOutlet weak var pkrEasing: PickerViewFucntion!
    @IBOutlet weak var pkrTime: PickerViewTimeD4!
    @IBOutlet weak var pkrDelay: PickerViewTimeD4!
    @IBOutlet weak var pkrInterpolation: PickerViewIO!
    @IBOutlet weak var pkrFrequency: PickerViewTimeD4!
    @IBOutlet weak var pkrDamping: PickerViewDamping!
    @IBOutlet weak var pkrVelocity: PickerViewVelocity!
    
    
    @IBOutlet weak var sldrAngle: MTCircularSlider!
    
    @IBAction func MotorAngleChanged(_ sender: Any) {
        let angle  = sldrAngle.value
        
        let radAngle:Float = FMUnitConvertor.DegreeToRadians(degree: Int(angle))
        
        var Tag = ImgSCNNodeTag
        
        switch ImgSCNNodeTag {
        case .Motor_Turn_Graphic:
            let rotation = SCNMatrix4MakeRotation(radAngle,0, 1, 0)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Turn
            break
            
        case .Motor_Lift_Graphic:
            let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Lift
            break
            
        case .Motor_Lean_Graphic:
            let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Lean
            break
            
        case .Motor_Tilt_Graphic:
            let rotation = SCNMatrix4MakeRotation(radAngle,1, 0, 0)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Tilt
            break
            
        default:
            break
            
        }
        
         (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! MotorAnimationState).Angle = [Int(angle):tglSwitch.isOn]
    }
    
    @IBAction func MotorEnabledChanged(_ sender: Any) {
       
        let angle  = sldrAngle.value
        
        let radAngle:Float = FMUnitConvertor.DegreeToRadians(degree: Int(angle))
        
        var Tag = ImgSCNNodeTag
        
        switch ImgSCNNodeTag {
        case .Motor_Turn_Graphic:
            let rotation = SCNMatrix4MakeRotation(radAngle,0, 1, 0)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Turn
            break
            
        case .Motor_Lift_Graphic:
            let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Lift
            break
            
        case .Motor_Lean_Graphic:
            let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Lean
            break
            
        case .Motor_Tilt_Graphic:
            let rotation = SCNMatrix4MakeRotation(radAngle,1, 0, 0)
            ImgSCNNode.transform = SCNMatrix4Mult(rotation, SCNTransform)
            Tag = AnimationObject.Motor_Tilt
            break
            
        default:
            break
            
        }
        
        
        (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! MotorAnimationState).Angle = [Int(angle):tglSwitch.isOn]
    }
    
    public func initialize(Element:AnimationObject)
    {
        ImgSCNNodeTag = Element
        ImgSCNNode = UIMAINModuleHandler.Instance.AniUIHandler.GetAllUIElements()[Element]!
        SCNTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: ImgSCNNodeTag, image: ImgSCNNode)
        
        pkrTime.initialize(Delegate: self)
        pkrDelay.initialize(Delegate: self)
        pkrEasing.initialize(Delegate: self)
        pkrInterpolation.initialize(Delegate: self)
        pkrFrequency.initialize(Delegate: self)
        pkrDamping.initialize(Delegate: self)
        pkrVelocity.initialize(Delegate: self)
        
        LoadDefaults()
    }
    
    func LoadDefaults()
    {
         var Tag = ImgSCNNodeTag
        
        switch ImgSCNNodeTag {
            
        case AnimationObject.Motor_Turn_Graphic:
        Tag = AnimationObject.Motor_Turn
        break
        
        case AnimationObject.Motor_Lift_Graphic:
        Tag = AnimationObject.Motor_Lift
        break
        
        case AnimationObject.Motor_Lean_Graphic:
        Tag = AnimationObject.Motor_Lean
        break
        
        case AnimationObject.Motor_Tilt_Graphic:
        Tag = AnimationObject.Motor_Tilt
        break
        
        default:
        break
        
    }
        
        tglSwitch.setOn(     (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! MotorAnimationState).Angle.values.first! , animated: true)
        
        
        sldrAngle.value =      Float((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! MotorAnimationState).Angle.keys.first!)
        
        
        pkrTime.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Timing)
        
        pkrDelay.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Delay)
        
        pkrDamping.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Damp)
        
        pkrVelocity.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Velocity)
        
        pkrFrequency.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Frequency)
        
        pkrEasing.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).EasingFunction)
        
        pkrInterpolation.SetValue(value: (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).EasingType)
        
        
        
    }
    
    //PickerViewEvents
    func PickerValueChanged(PickerType: PickerViewType) {
        
        var Tag = ImgSCNNodeTag
        
        switch ImgSCNNodeTag {
            
        case AnimationObject.Motor_Turn_Graphic:
            Tag = AnimationObject.Motor_Turn
            break
            
        case AnimationObject.Motor_Lift_Graphic:
            Tag = AnimationObject.Motor_Lift
            break
            
        case AnimationObject.Motor_Lean_Graphic:
            Tag = AnimationObject.Motor_Lean
            break
            
        case AnimationObject.Motor_Tilt_Graphic:
            Tag = AnimationObject.Motor_Tilt
            break
            
        default:
            break
            
        }
        
        switch PickerType {
        case .TIMING:
            (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Timing = pkrTime.Value
            break
        case .DELAY:
            (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Delay = pkrDelay.Value
            break
        case .FREQUENCY:
            (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Frequency = pkrFrequency.Value
            break
        case .DAMPING:
            (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Damp = pkrDamping.Value
            break
        case .VELOCITY:
            (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Velocity = pkrVelocity.Value
            break
        case .EASING_FUNCTION:
             (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).EasingFunction = pkrEasing.Value
            break
        case .INO:
             (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).EasingType = pkrInterpolation.Value
            break
        case .GRAPHIC_INTERPOLATION:
            break
        case .NA:
            break
        }
    }
    //End of PickerViewEvents
    
}
