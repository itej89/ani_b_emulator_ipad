//
//  Payload_Diagnostic_Message.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class Payload_Diagnostic_Message:PayloadObject
{
    public func initialize_PayloadItems()
    {
        Payload = [
            TAG.SOURCE_ADDRESS:Payload_Item_Type(_Position: 0,_Length: 2),
            TAG.TARGET_ADDRESS:Payload_Item_Type(_Position: 2,_Length: 2),
            TAG.USER_DATA:Payload_Item_Type(_Position: 4)//Max length can be found from DOIP_status_Response
        ]
    }
    
    public init(DOIPPayload:[UInt8])
    {
        super.init()
        initialize_PayloadItems()
        Decode_Payload(DOIPPayload: DOIPPayload)
    }
    
    public override init()
    {
        super.init()
        initialize_PayloadItems()
    }
    
    public func GetTargetAddress() -> [UInt8]!
    {
        return Payload[TAG.TARGET_ADDRESS]?.RawData
    }
    
    public func GetSourceAddress() -> [UInt8]!
    {
        return Payload[TAG.SOURCE_ADDRESS]?.RawData
    }
    
    public func GetUserData() -> [UInt8]!
    {
        let userData = Payload[TAG.USER_DATA]?.RawData
        
        if(userData == nil || userData?.count == 0)
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, strAdditionalInfo: "USerData in Diagnostic Message PAyload"))
        }
        
        return userData
    }
    
    public func SetSourceAddress(SA:[UInt8])
    {
        Payload[TAG.SOURCE_ADDRESS]?.RawData = SA
    }
    
    public func SetTArgetAddress(TA:[UInt8])
    {
        Payload[TAG.TARGET_ADDRESS]?.RawData = TA
    }
    
    public func SetUserData(User_Data:[UInt8]!)
    {
        if(User_Data != nil)
        {
            //Payload[TAG.USER_DATA]?.RawData = [UInt8](repeating: 0, count: User_Data.count)
            Payload[TAG.USER_DATA]?.RawData = [UInt8]()
            Payload[TAG.USER_DATA]?.RawData.append(contentsOf: User_Data)
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "Payload_Diagnostic_Message:SetUserData", strAdditionalInfo: ""))
        }
    }
}
