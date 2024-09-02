//
//  DOIPFramePArser.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPFrameParser
{
    public func Parse(DOIPFrame:[UInt8]) -> DOIPResponseObject!
    {
        if(DOIPFrame.count < DOIPResponseObject.GetHeaderLength())
        {
            return nil
        }
        else
        {
            let doipResponseObject:DOIPResponseObject = DOIPResponseObject()
            doipResponseObject.SetProtocolVersion(_ProtocolVersion: DOIPFrame[0])
            doipResponseObject.SetInverseProtocolVersion(_InverseProtocolVersion: DOIPFrame[1])
            
            let PayloadTypeBytes = DOIPFrame[2...3]
            doipResponseObject.SetPayloadType(_Res_Payload_Type: Response_Payload_Types.Instance.DECODE(Payload_Type_Value: Array(PayloadTypeBytes)))
            doipResponseObject.SetProtocolVersion(_ProtocolVersion: DOIPFrame[0])
        
            if(doipResponseObject.GetPayLoadType() != Response_Payload_Types.CODE.DOIPTester_UNKNOWN_CODE)
            {
                var LengthBytes = DOIPFrame[4...7]
                LengthBytes.reverse()
                let payloadLength:Int = Int(GetLengthFromBytes(bytes:Array(LengthBytes)))
                doipResponseObject.SetPayloadLength(_PayloadLength: (payloadLength))
                
                if(payloadLength > 0 && payloadLength + DOIPResponseObject.Number_Of_Bytes_In_Header <= DOIPFrame.count)
                {
                    let PayloadBytes = DOIPFrame[8...]
                    
                    let responeToPayloadObject:Response_Payload_Type_To_Object = Response_Payload_Type_To_Object()
                    doipResponseObject.SetPayload(_Payload:responeToPayloadObject.GetPayloadObjectOfType(Payload_Type: doipResponseObject.GetPayLoadType(),Payload: Array(PayloadBytes)))
                }
            }
            
            return doipResponseObject
        
        }
    }
    
    private func GetLengthFromBytes(bytes:[UInt8]) -> UInt64
    {
        var value:UInt64 = 0
        for i in 0..<bytes.count
        {
            let shiftCount = 8 * i
            value = value + UInt64(((bytes[i] & 0xFF) << shiftCount))
        }
        return value
    }
}
