//
//  AudioContextConveyHandler.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 10/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_Articulation

public class AudioContextConveyHandler:PlayerConvey
{
    
    public static let Instance:AudioContextConveyHandler  = AudioContextConveyHandler()
    
    //PlayerConvey
    public func FinishedPlayingSound() {
        
    }
    
    public func UpdateAudioPlayProgress(progress: Double) {
        
    }
    //end of PlayerConvey
    
    
    public func RevokePlayerDelegates()
    {
        ArticulationManager.Instance.setOnPlaySoundListener(delegate: self)
    }
    
    public func PullPlayerDelegates(delegate:PlayerConvey)
    {
        ArticulationManager.Instance.setOnPlaySoundListener(delegate: delegate)
    }
    
}

