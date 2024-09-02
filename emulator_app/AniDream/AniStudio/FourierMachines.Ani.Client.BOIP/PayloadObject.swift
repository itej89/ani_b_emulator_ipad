//
//  PayloadObject.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class PayloadObject:IValidation
{
    public var ValidationErrors: ValidationRuleMessages
    
 
    
    public static let Max_DOIP_PAYLOAD_SIZE:UInt32 = 0
    
    public var Minimum_Payload_Length_In_Bytes:UInt64 = 0
    public var Maximum_Payload_Length_In_Bytes:UInt64 = 0
    
    var Payload:[TAG:Payload_Item_Type] = [:]
    
    
    //Calculate Payload Length according to the length specified in doip standard ISO 13400-2
    public func DOIPPayloadMinimumLengthInBytes() -> UInt64
    {
        var ValidData_Length:UInt64 = 0
        
        for pair in Payload
        {
            if(pair.value.IsItemLengthNotDefined())
            {
                Minimum_Payload_Length_In_Bytes = ValidData_Length
                Maximum_Payload_Length_In_Bytes = UInt64.max
                return ValidData_Length
            }
            else
            {
                ValidData_Length += pair.value.Length_ISO_13400
            }
        }
        
        Minimum_Payload_Length_In_Bytes = ValidData_Length
        Maximum_Payload_Length_In_Bytes = ValidData_Length
        
        return ValidData_Length
    }
    
    public func TotalNumberOfBytesInPayload() -> UInt64
    {
        var ValidData_Length:UInt64 = 0
        
        for pair in Payload
        {
            if(pair.value.RawData != nil)
            {
                ValidData_Length = ValidData_Length + UInt64(pair.value.RawData.count)
            }
        }
        
        return ValidData_Length
    }
    
    public func ExtractPayload(DOIPPayload:[UInt8])
    {
        for pair in Payload
        {
            if(pair.value.IsItemLengthNotDefined())
            {
                //This assignment will extract Payload Items whose length is not fixed
                pair.value.RawData = Array(DOIPPayload[pair.value.Position...])
            }
            else
            {
                let EndIndex = (pair.value.Position + Int(pair.value.Length_ISO_13400))
                 pair.value.RawData = Array(DOIPPayload[pair.value.Position..<EndIndex])
            }
        }
    }
    
    public enum TAG
    {
        case ISO_RESERVED,OEM_RESERVED,
        
        //Vehicle Identification REsponse Payload
        VIN,LOGICAL_ADDRESS,EID,GID,FURTHER_ACTION,VIN_GID,SYNC,
        
        //Routing Activation Request Payload
        SOURCE_ADDRESS, ACTIVATION_TYPE,//ISO_RESERVED,OEM_RESERVED,
        
        //Routing Activation response Payload
     LOGICAL_ADDRESS_TEST_EQUIPMENT,LOGICAL_ADDRESS_DOIP_ENTITY,ROUTING_ACTIVATION_RESPONSE_CODE,//ISO_RESERVED,OEM_RESERVED,
        
        //Diagnostic Message Request/Response Payload
        TARGET_ADDRESS,USER_DATA,//SOURCE_ADDRESS,TARGET_ADDRESS,ACK,PREVIOUS_DIAGNOSTIC_DATA
        
        //Diagnostic Message Positive Acknowledgement Payload
        ACK,PREVIOUS_DIAGNOSTIC_DATA,//SOURCE_ADDRESS,TARGET_ADDRESS_ACK,ACK,PREVIOUS_DIAGNOSTIC_DATA,
        
        //Diagnostic Message Negative Acknowledgement Payload
        NACK,//SOURCE_ADDRESS,TARGET_ADDRESS_ACK,ACK,PREVIOUS_DIAGNOSTIC_DATA,
        
        //Alive Check Request
        //No Payload
        
        //Diagnostic Power Mode
        //No Payload
        
        //Diagnostic Power Mode Response
        DIAGNOSTIC_POWER_MODE,
        
        //Diagnostic Status Request
        //Node Payload
        
        //Diagnostic Status Response
        NODE_TYPE,MAX_CONCURRENT_TCP_SOCKETS,CURRENT_OPEN_TCP_SOCKETS,MAX_DATA_SIZE,
        
        //Generic HEader NACK
        HEADER_NACK
        
    }
    
    public func Decode_Payload(DOIPPayload:[UInt8]!)
    {
        if(DOIPPayload == nil)
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, MethodInfo: "PayloadObject:Decode_Payload", strAdditionalInfo: ""))
            
            return
        }
        
        Minimum_Payload_Length_In_Bytes = DOIPPayloadMinimumLengthInBytes()
        
        if(DOIPPayload.count >= Minimum_Payload_Length_In_Bytes)
        {
            ExtractPayload(DOIPPayload: DOIPPayload)
        }
        else
        {
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INCORRECT_LENGTH, MethodInfo: "PayloadObject:Decode_Payload", strAdditionalInfo: ""))
        }
    }
    
    public func Make_Payload() -> [UInt8]!
    {
        let Required_Payload_Length = TotalNumberOfBytesInPayload()
        
        if(Required_Payload_Length != 0)
        {
//            var DOIP_Payload:[UInt8] = [UInt8](repeating: 0, count: Int(Required_Payload_Length))
            
            
             var DOIP_Payload:[UInt8] = [UInt8]()
            
          let sortedPayload  = Payload.sorted{ $0.value.Position < $1.value.Position }
            
            for pair in sortedPayload
            {
                DOIP_Payload.append(contentsOf: pair.value.RawData)
                
//                DOIP_Payload.replaceSubrange(pair.value.Position..<pair.value.Position + pair.value.RawData.count, with: pair.value.RawData)
            }
            
            return DOIP_Payload
        }
        
        return nil
    }
    
    public init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
}
