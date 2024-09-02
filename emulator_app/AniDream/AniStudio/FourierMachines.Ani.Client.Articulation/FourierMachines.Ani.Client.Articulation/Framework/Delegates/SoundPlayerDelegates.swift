//
//  SoundPlayerDelegates.swift
//  FourierMachines.Ani.Client.Articulation
//
//  Created by Tej Kiran on 31/03/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

protocol SoundPlayerDelegates {
    func CanPlaySound()->Bool
    func PlayingSoudFinished()
    func PlayingSoudProgress(progress:Double)
    func ReleaseAnyLocksOnPlayError()
}
