//
//  DOIPResponseObject.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPResponseObject
{
    //1 byte protocol version, 1-byte Invers protocol version
    //2 byte Payload Type, 4-bytes - Payload length
    
    public static let Number_Of_Bytes_In_Header:Int = 8
    
    public var EndPoint:IPEndPoint = IPEndPoint()
    
    private var ProtocolVersion:UInt8 = 0xff
    private var InverseProtocolVersion:UInt8 = 0x00
    
    private var Res_Payload_Type:Response_Payload_Types.CODE!
    private var Payload:PayloadObject!
    private var PayloadLength:Int = 0
    
    //Returns standard header length in bytes
    public static func GetHeaderLength() -> Int
    {
        return DOIPResponseObject.Number_Of_Bytes_In_Header
    }
    
    public func SetProtocolVersion(_ProtocolVersion:UInt8)
    {
        ProtocolVersion = _ProtocolVersion
     }
    
    public func GetProtocolVersion() -> UInt8
    {
        return ProtocolVersion
    }
    
    public func SetInverseProtocolVersion(_InverseProtocolVersion:UInt8)
    {
        InverseProtocolVersion = _InverseProtocolVersion
    }
    
    public func GetInverseProtocolVersion() -> UInt8
    {
        return InverseProtocolVersion
    }
    
    public func SetPayloadType(_Res_Payload_Type:Response_Payload_Types.CODE)
    {
        return Res_Payload_Type = _Res_Payload_Type
    }
    
    public func GetPayLoadType() -> Response_Payload_Types.CODE
    {
        return Res_Payload_Type
    }
    
    public func SetPayload(_Payload:PayloadObject)
    {
        Payload = _Payload
    }
    
    public func GetPayload() -> PayloadObject
    {
        return Payload
    }
    
    public func SetPayloadLength(_PayloadLength:Int)
    {
        PayloadLength = _PayloadLength
    }
    
    public func GetPayloadLength() -> Int
    {
        return PayloadLength
    }
}
