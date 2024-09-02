//
//  Payload_Vehicle_Request_VIN.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Vehicle_Request_VIN:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.VIN:Payload_Item_Type(_Position: 0,_Length: 17)
        ]
    }
    
    public override init() {
        super.init()
        initialize_PayloadItems()
    }
    
    public  init(DOIPPayload:[UInt8]) {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func SetVIN(VIN:[UInt8])
    {
        Payload[TAG.VIN]?.RawData = VIN
    }
}
