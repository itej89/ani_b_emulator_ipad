//
//  ApplicationStateDelegates.swift
//  FourierMachines.Ani.Client.Main
//
//  Created by Tej Kiran on 08/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol ApplicationStateDelegate
{
    func AudioAirdropped()
    func AppInterrupted()
    func AppInterruptOver()
    func AppInactive()
    func AppIsActive()
}
