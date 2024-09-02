//
//  Request_Payload_Type_To_Object.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Request_Payload_Type_To_Object
{
    public func GetPayloadObjectOfType(Payload_Type: Request_Payload_Types.CODE, Payload:[UInt8]) -> PayloadObject
    {
        var payloadObject:PayloadObject = PayloadObject()
        switch Payload_Type {
        case .PLD_VEH_IDEN_REQ:
            break
        case .PLD_VEH_IDEN_REQ_EID:
            payloadObject = Payload_Vehicle_Request_EID(DOIPPayload: Payload)
            break
        case .PLD_VEH_IDEN_REQ_VIN:
            payloadObject = Payload_Vehicle_Request_VIN(DOIPPayload: Payload)
            break
        case .PLD_ROUTING_ACTIVATION_REQ:
            payloadObject = Payload_Routing_Activation_Requests(DOIPPayload: Payload)
            break
        case .PLD_ALIVE_CHECK_RES:
            payloadObject = Payload_Alive_Check_Response(DOIPPayload: Payload)
            break
        case .PLD_DOIP_ENTITY_STATUS_REQ:
            break
        case .PLD_DIAG_POWER_MODE_REQ:
            break
        case .PLD_RESERVED_ISO13400:
            break
        case .PLD_DIAG_MESSAGE:
            payloadObject = Payload_Diagnostic_Message(DOIPPayload: Payload)
            break
        case .PLD_MANUFACTURER_SPECIFIC_ACK:
            break
        case .DOIPTester_UNKNOWN_CODE:
            break
        }
        return payloadObject
    }
}
