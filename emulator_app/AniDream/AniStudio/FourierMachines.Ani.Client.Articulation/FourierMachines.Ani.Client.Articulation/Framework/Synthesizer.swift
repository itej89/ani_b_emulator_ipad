//
//  Synthesizer.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 30/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import AVFoundation

public class Synthesizer :  NSObject, AVSpeechSynthesizerDelegate {
    

    var sysnthesisDelegate:SynthesizerDelegates!
    
    override init() {
        super.init()
        synth.delegate = self
    }
    
    let synth = AVSpeechSynthesizer()
    let audioSession =  AVAudioSession.sharedInstance()
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
      if(sysnthesisDelegate != nil)
      {
        sysnthesisDelegate.SynthesisFinished()
      }
    }
    
    
    
    func textToSpeech(_content: String, _UtteranceRate:Float, _PitchMultiplier:Float, _language:String)
    {
        if(sysnthesisDelegate != nil && sysnthesisDelegate.CanStartSynthesis())
        {
           
        /////// code releated to texttospeech
        do{
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setMode(AVAudioSession.Mode.spokenAudio)
            try   AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            
            let  myUtterance = AVSpeechUtterance(string: _content)
            myUtterance.voice = AVSpeechSynthesisVoice(language: _language)
            myUtterance.rate = _UtteranceRate
            myUtterance.pitchMultiplier = _PitchMultiplier
            myUtterance.volume = 1.0
            synth.speak(myUtterance)
            
            
        }
        catch
        {
           sysnthesisDelegate.ReleaseAnyLocksOnSynthError()
        }
        ///////
            
        }
        
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
