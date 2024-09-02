//
//  AudioContextConvey.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 31/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

protocol AudioContextConvey {
    func SendArticulatedText(data:String)
    func StoppedListeningToUser()
    func StoppedListeningIDLETimeout()
    
    func UpdateAudioPlayProgress(progress:Double)
    
    func FinishedSynthesis()
    
    func FinishedPalyingSound()
}
