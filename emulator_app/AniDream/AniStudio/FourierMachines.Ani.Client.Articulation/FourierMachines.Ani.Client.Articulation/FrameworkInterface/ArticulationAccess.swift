//
//  ArticulationAccess.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 31/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol  ArticulationAccess {
    
    func InitializeArticulation()
    
    func StartListeningToUser()
    
    func StopListening()
    
    func IsSoundPlayerPlaying() -> Bool
    
    func PlaySound(fileName:String, StartSec:Int, EndSec:Int, Volume:Float, FadeDuration:Float)
    
    func PauseSound()
    
    func PlayWaveData(fileName: String, Volume: Float, FadeDuration: Float)

    func SpeakText(_content: String, _UtteranceRate:Float, _PitchMultiplier:Float, _language:String)
    
    func setOnArticulationListener(delegate: ArticulationConvey)
    
    func setOnSynthesizerListener(delegate: SynthesizerConvey)

    func setOnPlaySoundListener(delegate: PlayerConvey)
    
    func ResetAllSessions()
}
