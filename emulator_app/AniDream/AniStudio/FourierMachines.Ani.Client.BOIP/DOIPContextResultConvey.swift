//
//  DOIPContextResultConvey.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 01/09/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol DOIPContextResultConvey
{
    func InitializeResultNotify(result:Int)
    func UDSSendResultNotify(result:Int)
    func LinkDisconnected()
    func LinkConnected(EndPoint:IPEndPoint)
}
