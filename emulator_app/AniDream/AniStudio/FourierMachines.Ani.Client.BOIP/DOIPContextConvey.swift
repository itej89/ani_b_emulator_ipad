//
//  DOIPContextConvey.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol DOIPContextConvey
{
    func FoundDOIPEntity(Entity:DOIPEntity)
    func UDSResponseRecieved(response:[UInt8])
}
