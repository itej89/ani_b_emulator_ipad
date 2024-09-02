//
//  IDiagStateForSendRecieve.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol IDiagStateForSendRecieve:IDiagState
{
    func _Init(arrDataToBeSent:[UInt8]?) -> Int
}

