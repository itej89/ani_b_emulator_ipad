//
//  DOIPAccess.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 03/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol DOIPAccess
{
    func Initialize(ContextConvey:DOIPContextConvey,ResultConvey:DOIPContextResultConvey) -> Bool
    func Uninitialize()
    func SendScan() -> Bool
    func Connect(Entity:DOIPEntity) -> Bool
    func Disconnect()
    func Send(Data:[UInt8]) -> Bool
}
