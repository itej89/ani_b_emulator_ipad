//
//  EmotionCreateScreen.swift
//  AniStudio
//
//  Created by Tej Kiran on 19/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import SceneKit

import FourierMachines_Ani_Client_System
import GraphicAnimation
import UIKit

import FourierMachines_Ani_Client_DB

public class EmotionCreateScreen:UIViewController, DialogDataNotify, HomeScreenChildProtocol, MainScreenEventProtocol
{
    public static var EM_SYNTH_ID:Int = DB_Table_Columns.DEFAULT_EM_SYNTH_ID
    var CurrentObjectTag:AnimationObject  = AnimationObject.NA
    var CurrentObjectDictionaryKey:AnimationObject  = AnimationObject.NA
    var CurrentSCNNode:SCNNode!
    
    //DialogDataNotify
    public func ItemUtilityButtonClicked(index: Int) {
        
    }
    
    public func ValidateText(text: String) -> (Bool, String) {
        let db:DB_Local_Store = DB_Local_Store()
        let Expression = db.readExpression(Em_Synth_id: EmotionCreateScreen.EM_SYNTH_ID, ByName: text)
        if Expression.Name != ""
        {
            return (false, "Name already exists ⃰")
        }
        return (true, "")
    }
    
    public func TextEntered(text:String)
    {
        if(text != "")
        {
            let dbHAndler = DB_Local_Store()
            let Expression = Expressions_Type(name: text, action_Data: AnimationActionCreator.instance.CurrentAnimation.Position.Json(), joy: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY]!, surprise: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE]!, fear: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR]!, sadness: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS]!, anger: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER]!, disgust: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST]!, em_synth_id: EmotionCreateScreen.EM_SYNTH_ID, Sound_Library_ID: AnimationActionCreator.instance.CurrentAnimation.Sound_ID)
        _ = dbHAndler.saveExpression(Data: Expression)
        
            btnCloseClicked(self)
        }
    }
    public func ItemSelected(index: Int) {
        
    }
    //End of DialogDataNotify
    
    @IBAction func btnElementSelected(_ sender: Any) {
        
      
        self.PanelContainer.subviews.forEach { $0.removeFromSuperview() }
        
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
    
    var homeScreenProtocol:HomeScreenProtocol!
    
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var PanelContainer: UIView!
    
    
    //HomeScreenChildProtocol
    func SetHomeScreen(HomeScreen : HomeScreenProtocol)
    {
        homeScreenProtocol = HomeScreen
    }
    //End of HomeScreenChildProtocol
    
    @IBAction func btnCloseClicked(_ sender: Any) {
//        if(homeScreenProtocol != nil)
//        {
//            homeScreenProtocol.GoBack(Screen: ScreenMode)
//        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        DialogManager.Instance.delTextDialogNotify = self
//        AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json: AnimationActionCreator.instance.DefaultState.Position.Json().parseJSONString as! NSDictionary)
    }
    
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func btnAnimateClicked(_ sender: Any) {
        
         UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowCreatedAnimation(ActionData: AnimationActionCreator.instance.CurrentAnimation.Position.Json())
    }
   
    @IBAction func btnSetEmotionClicked(_ sender: Any) {
        for subview in PanelContainer.subviews {
            subview.removeFromSuperview()
        }
        
        let SetEmotionPanel = Bundle.main.loadNibNamed("SetEmotionPanel",owner:self,options:nil)?.first as! SetEmotionPanel
        SetEmotionPanel.frame = self.PanelContainer.bounds
        
        PanelContainer.addSubview(SetEmotionPanel)
        SetEmotionPanel.initialize()
        
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        if(DialogManager.Instance.delDialogRequest != nil)
        {
            DialogManager.Instance.delDialogRequest.ShowTextDialog(placeholderText: "Enter the Expresion Name")
        }
    }
    
}
