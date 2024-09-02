//
//  Payload_Vehicle_Request_EID.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Vehicle_Request_EID:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.EID:Payload_Item_Type(_Position: 0,_Length: 6)
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
    
    public func SetEID(EID:[UInt8])
    {
        Payload[TAG.EID]?.RawData = EID
    }
}
