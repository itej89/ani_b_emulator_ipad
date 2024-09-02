//
//  Payload_Vehicle_Announcement.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Vehicle_Announcement:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.VIN:Payload_Item_Type(_Position: 0,_Length: 17),
            TAG.LOGICAL_ADDRESS:Payload_Item_Type(_Position: 17,_Length: 2),
            TAG.EID:Payload_Item_Type(_Position: 19,_Length: 6),
            TAG.GID:Payload_Item_Type(_Position: 25,_Length: 6),
            TAG.FURTHER_ACTION:Payload_Item_Type(_Position: 31,_Length: 1),
            TAG.VIN_GID:Payload_Item_Type(_Position: 32),
        ]
    }
    
    public init(DOIPPayload:[UInt8])
    {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public func GetVIN() -> [UInt8]!
    {
        return Payload[TAG.VIN]?.RawData
    }
    
    public func GetlogicalAddress() -> [UInt8]?
    {
        let address = Payload[TAG.LOGICAL_ADDRESS]?.RawData
        if(DOIPSession.Instance.getInvalidAddresses().contains(address!))
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Vehicle Identification Response Payload Loagical Address"))
            
            return nil
        }
        return address!
    }
    
    public func GetEID() -> [UInt8]!
    {
        return Payload[TAG.EID]?.RawData
    }
    
    public func GetGID() -> [UInt8]!
    {
        return Payload[TAG.GID]?.RawData
    }
    
    public func GetFurtherAction() -> UInt8
    {
        if(Payload[TAG.FURTHER_ACTION]?.RawData != nil)
        {
            let furtherAction = (Payload[TAG.FURTHER_ACTION]?.RawData[0])!
            if(furtherAction >= DOIPSession.Instance.getValidFurtherActions()[0] && furtherAction <= DOIPSession.Instance.getValidFurtherActions()[1])
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, MethodInfo: "Vehicle IDentification Response further Action code", strAdditionalInfo: ""))
                return 0x00
            }
            else
            {
                return furtherAction
            }
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Vehicle_Announcement:GetFurtherAction", strAdditionalInfo: ""))
            return 0x00
        }
    }
    
    public func GetVINGIDSync() -> UInt8
    {
        if(Payload[TAG.VIN_GID]?.RawData != nil)
        {
            return Payload[TAG.VIN_GID]?.RawData[0] ?? 0x00
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Vehicle_Announcement:GetVINGIDSync", strAdditionalInfo: ""))
            return 0x00
        }
    }
}
