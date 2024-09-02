//
//  ArticulationManager.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 31/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public class ArticulationManager: ArticulationAccess, AudioContextConvey
{
  
   
    var ARTICULATION_STATE:ArticulationStates = ArticulationStates.FINISH
    
    public static let Instance:ArticulationAccess  = ArticulationManager()
    
    var ArticulatedText:String = ""
    
    //Timer used for detecting end of speech
    var utterance_timer:Timer?
    
    var articulationContext:AudioContext!
    
    var notifyArticulationState:ArticulationConvey!
    var notifySynthesizerState:SynthesizerConvey!
    var notifyPlayerStatetate:PlayerConvey!
    
    public init()
    {
       
    }
    
    func StartUtteranceTimer(_time:Double) {
        
        utterance_timer = Timer.scheduledTimer(timeInterval: _time, target: self, selector: #selector(self.SendFullArticulatedText), userInfo: nil, repeats: false);
    }
    
    @objc func SendFullArticulatedText(){
        ARTICULATION_STATE = ArticulationStates.FINISH
        articulationContext.SentanceFinalized()
        if(notifyArticulationState != nil)
        {
        notifyArticulationState.TextArticulationFinishedByUser(data: ArticulatedText)
        }
    }
    
    //public functions
    public func InitializeArticulation()
    {
        articulationContext = AudioContext(delegate: self)
    }
    
    public func ResetAllSessions()
    {
        notifyArticulationState = nil
        notifySynthesizerState = nil
        notifyPlayerStatetate = nil
    }
    
    public func setOnArticulationListener(delegate: ArticulationConvey)
    {
         notifyArticulationState = delegate
    }
    
    public func setOnSynthesizerListener(delegate: SynthesizerConvey)
    {
        notifySynthesizerState = delegate
    }
    
    public func setOnPlaySoundListener(delegate: PlayerConvey)
    {
        notifyPlayerStatetate = delegate
    }
    
    
    public func StartListeningToUser() {
        articulationContext.StartListeningToUser()
         if(notifyArticulationState != nil)
         {
        notifyArticulationState.ListeningToUserNow()
        }
    }

    
    public func StopListening() {
        articulationContext.StopListening()
    }
    
    public func IsSoundPlayerPlaying() -> Bool
    {
       return articulationContext.IsSoundPlayerPlaying()
    }
    

    public func PlaySound(fileName: String, StartSec:Int, EndSec:Int, Volume: Float, FadeDuration: Float) {
        articulationContext.PlaySound(fileName: fileName, StartSec: StartSec, EndSec: EndSec, Volume: Volume, FadeDuration: FadeDuration)
    }
    public func PauseSound() {
        articulationContext.PauseSound()
    }
    
    public func PlayWaveData(fileName: String, Volume: Float, FadeDuration: Float) {
    }
    
    public func SpeakText(_content: String, _UtteranceRate: Float, _PitchMultiplier: Float, _language: String)
    {
       articulationContext.SpeakText(_content: _content, _UtteranceRate: _UtteranceRate, _PitchMultiplier: _PitchMultiplier, _language: _language)

    }
    //end public functions
    
    
    //AudioContextconvey
    
    func StoppedListeningIDLETimeout() {
        if(notifyArticulationState != nil){
        notifyArticulationState.ListeningIDLETimeout()
        }
    }
    
    
    func SendArticulatedText(data: String) {
        
        ArticulatedText = data
         if(notifyArticulationState != nil)
         {
            if(ARTICULATION_STATE == ArticulationStates.FINISH)
            {
                ARTICULATION_STATE = ArticulationStates.BEGIN
                notifyArticulationState.TextArticulationBegan(data: data)
            }
            else
            if(ARTICULATION_STATE == ArticulationStates.BEGIN)
            {
                    ARTICULATION_STATE = ArticulationStates.ONGOING
                notifyArticulationState.TextBeingArticulatedByUser(data: data)
            }
        
        if(notifyArticulationState.ShouldContinueListeningForFullSentence())
        {
            if(utterance_timer != nil)
            {
                utterance_timer?.invalidate()
            }
            
            if(ArticulatedText != "")
            {
                StartUtteranceTimer(_time: 1.5)
            }
        }
        }
    }
    
  
    
    func StoppedListeningToUser()
    {
        ARTICULATION_STATE = ArticulationStates.FINISH
         if(notifyArticulationState != nil)
         {
            notifyArticulationState.StoppedListeningToUser()
         }
    }
    
    func UpdateAudioPlayProgress(progress:Double)
    {
        if(notifyPlayerStatetate != nil)
        {
            notifyPlayerStatetate.UpdateAudioPlayProgress(progress:progress)
        }
    }
    
    func FinishedSynthesis()
    {
        if(notifySynthesizerState != nil)
        {
            notifySynthesizerState.FinishedSynthesis()
        }
    }
    
    func FinishedPalyingSound()
    {
        if(notifyPlayerStatetate != nil)
        {
            notifyPlayerStatetate.FinishedPlayingSound()
        }
    }
    //End AudioContextconvey
    
}
