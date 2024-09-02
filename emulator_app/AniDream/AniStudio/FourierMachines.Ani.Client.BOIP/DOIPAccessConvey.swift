//
//  DOIPAccessConvey.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 04/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol DOIPAccessConvey
{
    func DiscoveredEntity(DOIP:DOIPEntity)
    func DOIPError(code:DIAGNOSTIC_STATUS.CODE)
    func DOIPConnecting()
    func DOIPConnected()
    func DOIPDisconnected()
    func DOIPDataRecieved(Data:[UInt8])
}
