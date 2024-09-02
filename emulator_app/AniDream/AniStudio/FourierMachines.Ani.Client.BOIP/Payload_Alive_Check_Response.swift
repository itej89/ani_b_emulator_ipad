//
//  Payload_Alive_Check_Response.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Alive_Check_Response:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload=[
            TAG.SOURCE_ADDRESS:Payload_Item_Type(_Position: 0,_Length: 2)]
    }
    public override init()
        {
            super.init()
            initialize_PayloadItems()
        }
    
    public  init(DOIPPayload:[UInt8]) {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
        public func SetSourceAddress(SA:[UInt8]!)
        {
            Payload[TAG.SOURCE_ADDRESS]?.RawData = SA
        }
    
}
