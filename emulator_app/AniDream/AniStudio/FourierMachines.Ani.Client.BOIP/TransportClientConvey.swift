//
//  TCPClientConvey.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol TransportClientConvey
{
     func DataRecieved(recievedData:RecievedData)
    func Disconnected()
     func Timeout(code:Int)
}
