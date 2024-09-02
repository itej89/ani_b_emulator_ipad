//
//  DOIPRequestObject.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPRequestObject
{
    //1 byte protocol version, 1-byte Invers protocol version
    //2 byte Payload Type, 4-bytes - Payload length
    
    private static let Number_Of_Bytes_In_Header:Int = 8
    
    private var ProtocolVersion:UInt8 = 0xff
    private var InverseProtocolVersion:UInt8 = 0x00
    
    private var Req_Payload_Type:Request_Payload_Types.CODE!
    private var Payload:PayloadObject!
    
    //Returns standard header length in bytes
    public static func GetHeaderLength() -> Int
    {
        return DOIPRequestObject.Number_Of_Bytes_In_Header
    }
    
    public func SetProtocolVersion(_ProtocolVersion:UInt8)
    {
        ProtocolVersion = _ProtocolVersion
        SetInverseProtocolVersion(_InverseProtocolVersion: _ProtocolVersion^0xFF)
    }
    
    public func GetProtocolVersion() -> UInt8
    {
        return ProtocolVersion
    }
    
    private func SetInverseProtocolVersion(_InverseProtocolVersion:UInt8)
    {
        InverseProtocolVersion = _InverseProtocolVersion
    }
    
    public func GetInverseProtocolVersion() -> UInt8
    {
        return InverseProtocolVersion
    }
    
    public func SetPayloadType(_Req_Payload_Type:Request_Payload_Types.CODE)
    {
         Req_Payload_Type = _Req_Payload_Type
    }
    
    public func GetPayLoadType() -> Request_Payload_Types.CODE
    {
        return Req_Payload_Type
    }
    
    public func SetPayload(_Payload:PayloadObject)
    {
        Payload = _Payload
    }
    
    public func GetPayload() -> PayloadObject!
    {
       return Payload
    }
    
}
