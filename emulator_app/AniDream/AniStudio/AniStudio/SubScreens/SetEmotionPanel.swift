//
//  SetEmotionPanel.swift
//  AniStudio
//
//  Created by Tej Kiran on 04/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit
import GraphicAnimation
import FourierMachines_Ani_Client_Common

class SetEmotionPanel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var sldrJoy: UISlider!
    @IBOutlet weak var sldrSurprise: UISlider!
    @IBOutlet weak var sldrFear: UISlider!
    @IBOutlet weak var sldrSadness: UISlider!
    @IBOutlet weak var sldrAnger: UISlider!
    @IBOutlet weak var sldrDisgust: UISlider!
    @IBOutlet weak var vwJoy: UIView!
    @IBOutlet weak var vwSurprise: UIView!
    @IBOutlet weak var vwFear: UIView!
    @IBOutlet weak var vwSadness: UIView!
    @IBOutlet weak var vwAnger: UIView!
    @IBOutlet weak var vwDisgust: UIView!
    
    public func initialize()
    {
        LoadDefaults()
    }
    
    func LoadDefaults()
    {
        sldrJoy.value = AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY]!
        
        sldrSurprise.value = AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE]!
        
        sldrFear.value = AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR]!
        
        sldrSadness.value = AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS]!
        
        sldrAnger.value  = AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER]!
        
        sldrDisgust.value = AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST]!
        
        
         vwJoy.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xA5E27F, alpha: sldrJoy.value)
        
        vwSurprise.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x145CC0, alpha: sldrSurprise.value)
        
          vwFear.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xFFFF52, alpha: sldrFear.value)
        
        vwSadness.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x3C3C3C, alpha: sldrSadness.value)
        
         vwAnger.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xFF4721, alpha: sldrAnger.value)
        
        vwDisgust.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xAFFBF5, alpha: sldrDisgust.value)
    }
    
    
    @IBAction func JoyValueSet(_ sender: Any) {
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY] = sldrJoy.value
        
        
        vwJoy.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xA5E27F, alpha: sldrJoy.value)
        
    }
    @IBAction func SurpriseValSet(_ sender: Any) {
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE] = sldrSurprise.value
        
        vwSurprise.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x145CC0, alpha: sldrSurprise.value)
    }
    @IBAction func FearValSet(_ sender: Any) {
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR] = sldrFear.value
        
        vwFear.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xFFFF52, alpha: sldrFear.value)
    }
    @IBAction func SadValSet(_ sender: Any) {
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS] = sldrSadness.value
        
        vwSadness.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x3C3C3C, alpha: sldrSadness.value)
    }
    @IBAction func AngerValSet(_ sender: Any) {
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER] = sldrAnger.value
        
        vwAnger.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xFF4721, alpha: sldrAnger.value)
    }
    @IBAction func DisgValSet(_ sender: Any) {
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST] = sldrDisgust.value
        
        vwDisgust.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xAFFBF5, alpha: sldrDisgust.value)
    }
    
    
    
}
