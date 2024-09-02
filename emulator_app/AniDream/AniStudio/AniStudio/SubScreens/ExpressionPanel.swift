//
//  ExpressionPanel.swift
//  AniStudio
//
//  Created by Tej Kiran on 07/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import SceneKit

import FourierMachines_Ani_Client_System
import FourierMachines_Ani_Client_DB
import GraphicAnimation
import UIKit

class ExpressionPanel: UIView, UIGestureRecognizerDelegate, MainScreenEventProtocol
{
    var CurrentObjectTag:AnimationObject  = AnimationObject.NA
    var CurrentObjectDictionaryKey:AnimationObject  = AnimationObject.NA
    var CurrentSCNNode:SCNNode!
    
    
   
    @IBOutlet weak var vwMusic: UIView!
    
    @IBOutlet var EyeElemtViews: [UIView]!
    
    @IBOutlet var MotionElementViews: [UIView]!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
            let tapEyeElementGesture = UITapGestureRecognizer(target: self, action: #selector(handlElementTap(sender:)))
        
        tapEyeElementGesture.delegate = self as UIGestureRecognizerDelegate
        
            EyeElemtViews.forEach { view in
            view.gestureRecognizers?.append(tapEyeElementGesture)
            }
        
        MotionElementViews.forEach { view in
            view.gestureRecognizers?.append(tapEyeElementGesture)
        }
        
        
             let tapMusicElementGesture = UITapGestureRecognizer(target: self, action: #selector(handleMusicVWTap(sender:)))
        
       tapMusicElementGesture.delegate = self as UIGestureRecognizerDelegate
        vwMusic.gestureRecognizers?.append(tapMusicElementGesture)
        
       
    }
    
    
    
    @objc func handleMusicVWTap(sender: UITapGestureRecognizer) {
        if(ChildPanelProtocol != nil)
        {
            ChildPanelProtocol.SelectMusic()
        }
    }
    
    @objc func handlElementTap(sender: UITapGestureRecognizer) {
        if((sender.view?.subviews.count)! > 0)
        {
            btnElementSelected(sender.view?.subviews[0] as! UIButton)
        }
    }
    
    @IBAction func btnElementSelected(_ sender: Any) {
        
       
        
        let Element:UIButton = sender as! UIButton
        let Tag = Element.tag
        let ElementType: AnimationObject = AnimationObject.init(rawValue: Tag) ?? AnimationObject.NA
        
        if(ElementType != AnimationObject.NA)
        {
            
            CurrentObjectTag = ElementType
            CurrentObjectDictionaryKey = ElementType
            
            switch(ElementType)
            {
            case .Image_EyeBallLeft:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Left Eyeball"
                break
            case .Image_EyeBrowRight:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Right Eyebrow"
                break
            case .Image_EyeBrowLeft:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Left Eyebrow"
                break
            case .Image_EyeBallRight:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Right Eyeball"
                break
            case .Image_EyeRight:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Right Eye"
                break
            case .Image_EyeLeft:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Left Eye"
                break
            case .Image_EyePupilRight:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Right Pupil"
                break
            case .Image_EyePupilLeft:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Left Pupil"
                break
            case .Image_EyeLidRight:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Right Eyelid"
                break
            case .Image_EyeLidLeft:
                ShowGraphicControlPanel(Element: ElementType)
                TitleText.text = "Left Eyelid"
                break
            case .Motor_Turn:
                CurrentObjectDictionaryKey = AnimationObject.Motor_Turn_Graphic
                ShowMotionControlPanel(Element: CurrentObjectDictionaryKey)
                TitleText.text = "Motor Turn"
                break
            case .Motor_Lift:
                CurrentObjectDictionaryKey = AnimationObject.Motor_Lift_Graphic
                ShowMotionControlPanel(Element: CurrentObjectDictionaryKey)
                TitleText.text = "Motor Lift"
                break
            case .Motor_Lean:
                CurrentObjectDictionaryKey = AnimationObject.Motor_Lean_Graphic
                ShowMotionControlPanel(Element: CurrentObjectDictionaryKey)
                TitleText.text = "Motor Lean"
                break
            case .Motor_Tilt:
                CurrentObjectDictionaryKey = AnimationObject.Motor_Tilt_Graphic
                ShowMotionControlPanel(Element: CurrentObjectDictionaryKey)
                TitleText.text = "Motor Tilt"
                break
            case .Motor_Turn_Graphic:
                break
            case .Motor_Lift_Graphic:
                break
            case .Motor_Lean_Graphic:
                break
            case .Motor_Tilt_Graphic:
                break
            case .NA:
                break
            }
            
        }
    }
    
    func ShowGraphicControlPanel(Element:AnimationObject)
    {
        if(PanelContainer.subviews.count == 1)
        {
            if ((PanelContainer.subviews[0] as? GraphicControlPanel) != nil)
            {
                (PanelContainer.subviews[0] as! GraphicControlPanel).initialize(Element: Element)
                return
            }
        }
       
            for subview in PanelContainer.subviews {
                subview.removeFromSuperview()
            }
            let graphicControlPanel = Bundle.main.loadNibNamed("GraphicControlPanel",owner:self,options:nil)?.first as! GraphicControlPanel
            graphicControlPanel.frame = self.PanelContainer.bounds
            
            PanelContainer.addSubview(graphicControlPanel)
            graphicControlPanel.initialize(Element: Element)
        
    }
    
    func ShowMotionControlPanel(Element:AnimationObject)
    {
        if(PanelContainer.subviews.count == 1)
        {
            if ((PanelContainer.subviews[0] as? MotionControlPanel) != nil)
            {
                (PanelContainer.subviews[0] as! MotionControlPanel).initialize(Element: Element)
                return
            }
        }
        
        
            for subview in PanelContainer.subviews {
                subview.removeFromSuperview()
            }
            
            let motionControlPanel = Bundle.main.loadNibNamed("MotionControlPanel",owner:self,options:nil)?.first as! MotionControlPanel
            motionControlPanel.frame = self.PanelContainer.bounds
            
            PanelContainer.addSubview(motionControlPanel)
            motionControlPanel.initialize(Element: Element)
        
    }
    
    //MainScreenEventProtocol
    func NodeTouched(Node : MODEL_NODE_TYPE)
    {
        
    }
    //End of MainScreenEventProtocol
    
    var ChildPanelProtocol:ChildPanelProtocol!
    
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var PanelContainer: UIView!
    
    
    
    public func SetParentScreen(ParentScreen : ChildPanelProtocol)
    {
        ChildPanelProtocol = ParentScreen
    }

    
    @IBAction func btnCloseClicked(_ sender: Any) {
        if(ChildPanelProtocol != nil)
        {
            ChildPanelProtocol.ClosePanel()
        }
    }
    
    @IBAction func btnAnimateClicked(_ sender: Any) {
        if(AnimationActionCreator.instance.CurrentAnimation.Sound_ID.isEmpty)
        {
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowCreatedAnimation(ActionData: AnimationActionCreator.instance.CurrentAnimation.Position.Json())
        }
        else
        {
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowCreatedAnimationWithMusic(ActionData: AnimationActionCreator.instance.CurrentAnimation.Position.Json(), MusicFile: AnimationActionCreator.instance.CurrentAnimation.Sound_ID)
            
        }
    }
    
    @IBAction func btnSelectMusic(_ sender: Any) {
        if(ChildPanelProtocol != nil)
        {
            ChildPanelProtocol.SelectMusic()
        }
    }
    
    @IBAction func btnSetEmotionClicked(_ sender: Any) {
        if(PanelContainer.subviews.count == 1)
        {
            if ((PanelContainer.subviews[0] as? SetEmotionPanel) != nil)
            {
                (PanelContainer.subviews[0] as! SetEmotionPanel).initialize()
                return
            }
        }
        
        
            for subview in PanelContainer.subviews {
                subview.removeFromSuperview()
            }
            
            let SetEmotionPanel = Bundle.main.loadNibNamed("SetEmotionPanel",owner:self,options:nil)?.first as! SetEmotionPanel
            SetEmotionPanel.frame = self.PanelContainer.bounds
            
            PanelContainer.addSubview(SetEmotionPanel)
            SetEmotionPanel.initialize()
        
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        if(ChildPanelProtocol != nil)
        {
            ChildPanelProtocol.SaveClicked()
        }
    }
    
}

