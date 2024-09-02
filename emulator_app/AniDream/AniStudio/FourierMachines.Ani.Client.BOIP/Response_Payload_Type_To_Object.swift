//
//  Response_Payload_Type_To_Object.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class Response_Payload_Type_To_Object
{
    public func GetPayloadObjectOfType(Payload_Type: Response_Payload_Types.CODE, Payload:[UInt8]) -> PayloadObject!
    {
        var payloadObject:PayloadObject = PayloadObject()
        switch Payload_Type {
        case .PLD_VEH_IDEN_RES:
            payloadObject = Payload_Vehicle_Announcement(DOIPPayload: Payload)
            break
        case .PLD_ROUTING_ACTIVATION_RES:
            payloadObject = Payload_Routing_Activation_Response(DOIPPayload: Payload)
            break
        case .PLD_DOIP_ENTITY_STATUS_RES:
            payloadObject = Payload_Diagnostic_Status_Response(DOIPPayload: Payload)
            break
        case .PLD_DIAG_POWER_MODE_RES:
            payloadObject = Payload_Diagnostic_Power_Mode_Response(DOIPPayload: Payload)
            break
        case .PLD_DOIP_HEADER_NAK: payloadObject = Payload_Generic_Header_NACK(DOIPPayload: Payload)
            break
        case .PLD_DIAG_MESSAGE_POSITIVE_ACK:
            payloadObject = Payload_Diagnostic_Message_Ack(DOIPPayload: Payload)
            break
        case .PLD_DIAG_MESSAGE_NEGATIVE_ACK:
            payloadObject = Payload_Diagnostic_Message_Nack(DOIPPayload: Payload)
            break
        case .PLD_DIAG_MESSAGE:
            payloadObject = Payload_Diagnostic_Message(DOIPPayload: Payload)
            break
        case .PLD_ALIVE_CHECK_REQ:
            break
        case .PLD_MANUFACTURER_SPECIFIC_ACK:
            break
        case .PLD_RESERVED_ISO13400:
            break
        case .DOIPTester_UNKNOWN_CODE:
            break
        }
        
        if(payloadObject.ValidationErrors.Messages.count > 0)
        {
            return nil
        }
        else
        {
            return payloadObject
        }
    }
}
