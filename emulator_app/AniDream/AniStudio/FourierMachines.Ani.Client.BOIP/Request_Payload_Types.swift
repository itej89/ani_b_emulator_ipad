//
//  Request_Payload_Types.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Request_Payload_Types
{
    public static let Instance = Request_Payload_Types()
    
    public enum CODE
    {
        case PLD_VEH_IDEN_REQ
        
        case PLD_VEH_IDEN_REQ_EID
        case PLD_VEH_IDEN_REQ_VIN
        
        
        case PLD_ROUTING_ACTIVATION_REQ
        
        case PLD_ALIVE_CHECK_RES
        
        case PLD_DOIP_ENTITY_STATUS_REQ
        case PLD_DIAG_POWER_MODE_REQ
        case PLD_RESERVED_ISO13400
        
        case PLD_DIAG_MESSAGE
        
        case PLD_MANUFACTURER_SPECIFIC_ACK
        case DOIPTester_UNKNOWN_CODE
    }
    
    public var CODE_TO_VALUE:[CODE:UInt16] = [
        CODE.PLD_VEH_IDEN_REQ:0x0001,
        CODE.PLD_VEH_IDEN_REQ_EID:0x0002,
        CODE.PLD_VEH_IDEN_REQ_VIN:0x0003,
        CODE.PLD_ROUTING_ACTIVATION_REQ:0x0005,
        CODE.PLD_ALIVE_CHECK_RES:0x0008,
        //CODE.PLD_RESERVED_ISO13400:0x0009
        //CODE.PLD_RESERVED_ISO13400:0x4000,
        CODE.PLD_DOIP_ENTITY_STATUS_REQ:0x4001,
        CODE.PLD_DIAG_POWER_MODE_REQ:0x4003,
        //CODE.PLD_RESERVED_ISO13400:0x4005,
        //CODE.PLD_RESERVED_ISO13400:0x8000,
        CODE.PLD_DIAG_MESSAGE:0x8001,
        //CODE.PLD_RESERVED_ISO13400:0x8004,
        //CODE.PLD_RESERVED_ISO13400:0xEFFF,
        //CODE.PLD_RESERVED_ISO13400:0xF000,
        //CODE.PLD_RESERVED_ISO13400:0xFFFF,
                                             ]
    
    public func Encode(Paylod_Type:CODE) -> [UInt8]
    {
        return [UInt8((CODE_TO_VALUE[Paylod_Type]!)&0xFF), UInt8((CODE_TO_VALUE[Paylod_Type]! >> 8)&0xFF) ]
    }
}
