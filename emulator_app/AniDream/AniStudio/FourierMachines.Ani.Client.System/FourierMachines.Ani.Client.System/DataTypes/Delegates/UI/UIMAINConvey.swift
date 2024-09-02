//
//  UIMAINConvey.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 01/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_Kinetics

public protocol UIMAINConvey
{
    func AppStarted()
    func ShowIdle()
    func StartBrowseAnimationsJob()
    func ShowBrowsedPlaneAnimation(ActionData:String)
    func ShowBrowsedAnimation(ActionData:String, MusicFile:String)
    func StartAddEmotionJob(InitAnimation:String)
    func ShowCreatedAnimation(ActionData:String)
    func ScanBot()
    func StopBotScan()
    func ConnectBot(_ID:String)
    func DisconnectBot()
}
