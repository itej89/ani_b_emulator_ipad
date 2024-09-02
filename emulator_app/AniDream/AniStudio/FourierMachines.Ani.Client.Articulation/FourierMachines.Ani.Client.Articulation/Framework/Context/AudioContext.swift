//
//  AudioContext.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 31/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public class AudioContext: SynthesizerDelegates, SoundPlayerDelegates, SpeexTDelegates{
  
    var notifyContext:AudioContextConvey!
    
    var speext: SpeexT = SpeexT()
    var synthesizer: Synthesizer = Synthesizer()
    var soundPlayer:SoundPlayer = SoundPlayer()
 
    var isRecMod: Bool = false
    
    
    var CurrentVoiceState: LISTENING_STATES = LISTENING_STATES.NOTLISTENING

    public var audSyncLock: pthread_mutex_t = pthread_mutex_t()
    

    
    init(delegate: AudioContextConvey)
    {
        var attr: pthread_mutexattr_t = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL)
        _ = pthread_mutex_init(&self.audSyncLock, &attr)
        pthread_mutexattr_destroy(&attr)
        
        
        notifyContext = delegate
        
        speext.speexTDelegate = self
        synthesizer.sysnthesisDelegate = self
        soundPlayer.soundPlayerDelegate = self
        
        
    }
    
    
    //public fucntions
    func StartListeningToUser() {
        speext.startRec()
         CurrentVoiceState = LISTENING_STATES.LISTENING
    }
    
    func StopListening() {
         speext.pauseRec()
         CurrentVoiceState = LISTENING_STATES.NOTLISTENING
    }
    
    
    func IsSoundPlayerPlaying() -> Bool
    {
        return soundPlayer.IsPlaying()
    }
    
    func PlaySound(fileName: String, StartSec:Int, EndSec:Int, Volume: Float, FadeDuration: Float) {
        if !speext.isRecRunning && isRecMod == false {
            soundPlayer.PlaySound(fileName: fileName, StartSec: StartSec, EndSec: EndSec, Volume: Volume, FadeDuration: FadeDuration)
        }
    }
    
    func PauseSound() {
         soundPlayer.PauseSound()
        notifyContext.FinishedPalyingSound()
        if isRecMod {
            // if (speext.timer?.isValid)!
            // {
            
            StartListeningToUser()
            
            //  }
        }
        isRecMod = false
        pthread_mutex_unlock(&audSyncLock)
       
    }
    
    func SpeakText(_content: String, _UtteranceRate: Float, _PitchMultiplier: Float, _language: String)
    {
        synthesizer.textToSpeech(_content: _content, _UtteranceRate: _UtteranceRate, _PitchMultiplier: _PitchMultiplier, _language: _language)
        
    }
  //end public funciions
    
    
    // SynthesizerDelegates
    func SynthesisFinished() {
        notifyContext.FinishedSynthesis()
        if isRecMod {
           // if (speext.timer?.isValid)!
           // {
                
                StartListeningToUser()
                
          //  }
        }
        pthread_mutex_unlock(&audSyncLock)
        isRecMod = false
    }
    
    func CanStartSynthesis()->Bool {
        
        if 0 != pthread_mutex_trylock(&audSyncLock) {
            return false
        }
        
        if  speext.isRecRunning
        {
            isRecMod = true
            speext.pauseRec()
        }
        
        return true
    }
    
    func ReleaseAnyLocksOnSynthError(){
         pthread_mutex_unlock(&audSyncLock)
    }
    //End SynthesizerDelegates
    
    
    
    //Sound Player Delegats
    func CanPlaySound() -> Bool {
        
        if 0 != pthread_mutex_trylock(&audSyncLock) {
            return false
        }
        
        if  speext.isRecRunning
        {
            isRecMod = true
            speext.pauseRec()
        }
        
        return true
        
      
    }
    
    func PlayingSoudFinished() {
        notifyContext.FinishedPalyingSound()
        if isRecMod {
            // if (speext.timer?.isValid)!
            // {
            
            StartListeningToUser()
            
            //  }
        }
        isRecMod = false
         pthread_mutex_unlock(&audSyncLock)
    }
    
    func ReleaseAnyLocksOnPlayError() {
          pthread_mutex_unlock(&audSyncLock)
    }
    
    func PlayingSoudProgress(progress:Double) {
        notifyContext.UpdateAudioPlayProgress(progress: progress)
    }
    //End Sound Player Delegats
    
    
    //Speext Control methods
    func SentanceFinalized()
    {
        speext.SentenceFinalizedByUppedLayer()
    }
    //End Speext Control methods
    
    //SpeexTDelegates
    func SendSpeexT(data: String) {
        notifyContext.SendArticulatedText(data: data)
    }
    
    func SpeexTStopped() {
        CurrentVoiceState = LISTENING_STATES.NOTLISTENING
        notifyContext.StoppedListeningToUser()
    }
    
    func SpeexTListeningIDLETimeout() {
        notifyContext.StoppedListeningIDLETimeout()
    }
    
    //End SpeexTDelegates
}

