//
//  ArticulationConvey.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 31/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol ArticulationConvey {
    
    //CAlled for the second word recognition onwards
    func TextBeingArticulatedByUser(data:String)
    
    //Called for the first word recognized
    func TextArticulationBegan(data:String)
    
    //Called at the at of sentance recognition
    func TextArticulationFinishedByUser(data:String)
    
    func StoppedListeningToUser()
    
    //Called when listening timer timeout
    func ListeningIDLETimeout()
    
    func ListeningToUserNow()
    
    func ShouldContinueListeningForFullSentence()->Bool
    
}

public protocol SynthesizerConvey
{
    func FinishedSynthesis()
}

public protocol PlayerConvey
{
    func FinishedPlayingSound()
    func UpdateAudioPlayProgress(progress:Double)
}
