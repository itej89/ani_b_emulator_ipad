//
//  SpeexTDelegates.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 30/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

protocol SpeexTDelegates {
    func SendSpeexT(data:String)
    func SpeexTStopped()
    func SpeexTListeningIDLETimeout()
}
