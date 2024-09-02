//
//  Activation_Request_Types.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Activation_Request_Types
{
    public static let Instance:Activation_Request_Types = Activation_Request_Types()
    
    public enum CODE
    {
        case RA_REQ_DEFAULT,
        RA_REQ_WWH_OBD,
        RA_ISO13400_RESERVED,
        RA_REQ_CENTRAL_SECURITY,
        RA_OEM_SPECIFIC,
        DOIPTester_UNKNOWN_CODE
    }
    
    var CODE_TO_VALUE:[CODE:UInt8] = [
        CODE.RA_REQ_DEFAULT:0x00,
        CODE.RA_REQ_WWH_OBD:0x01,
        CODE.RA_REQ_CENTRAL_SECURITY:0xE0
    ]
    
    var VALUE_TO_CODE:[UInt8:CODE] = [
        0x00:CODE.RA_REQ_DEFAULT,
        0x01:CODE.RA_REQ_WWH_OBD,
        0x02:CODE.RA_ISO13400_RESERVED,
        0xDF:CODE.RA_ISO13400_RESERVED,
        0xE0:CODE.RA_REQ_CENTRAL_SECURITY,
        0xE1:CODE.RA_ISO13400_RESERVED,
        0xFF:CODE.RA_ISO13400_RESERVED,
    ]
    
    var FURTHER_ACTION_ROUTING_ACTIVATION:[Vehicle_Announce_Further_Actions.CODE:CODE] =
    [
        Vehicle_Announce_Further_Actions.CODE.NO_FURTHER_ACTION_REQD: CODE.RA_REQ_DEFAULT,
        Vehicle_Announce_Further_Actions.CODE.ROUTING_REQD_CENTRAL_SECURITY: CODE.RA_REQ_CENTRAL_SECURITY,
    ]
    
    public func DECODE(Activation_Request_value:UInt8) -> CODE
    {
        if(VALUE_TO_CODE.keys.contains(Activation_Request_value))
        {
            return VALUE_TO_CODE[Activation_Request_value]!
        }
        else
        {
            return CODE.DOIPTester_UNKNOWN_CODE
        }
    }
    
    public func Encode(Activation_Request_code:CODE) -> UInt8
    {
        return CODE_TO_VALUE[Activation_Request_code]!
    }
    
    public func getRoutingActivationTypeFromVehicleAnnouncementFurtherActions(furtheraction:UInt8) -> CODE
    {
        let furtherActions:Vehicle_Announce_Further_Actions = Vehicle_Announce_Further_Actions()
        
        let code = furtherActions.DECODE(FurtherActions_Value: furtheraction)
        
        return FURTHER_ACTION_ROUTING_ACTIVATION[code]!
    }
}
