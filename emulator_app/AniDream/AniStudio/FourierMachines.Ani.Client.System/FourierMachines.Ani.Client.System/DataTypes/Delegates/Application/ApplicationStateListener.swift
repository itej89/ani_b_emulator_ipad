//
//  ApplicationsStateChanged.swift
//  FourierMachines.Ani.Client.Main
//
//  Created by Tej Kiran on 09/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol ApplicationStateListener {
    func WentBackground()
    func CameForeground()
}
