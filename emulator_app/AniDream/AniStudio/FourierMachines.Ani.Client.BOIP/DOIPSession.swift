//
//  DOIPSession.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPSession
{
    public static var NLOG_LOGGER_NAME = "BOIPLOGGER"
    
    public var DaignosticMessageType:ADDRESSING_TYPES.MessageType = ADDRESSING_TYPES.MessageType.PHYSICAL
    public var TesterPresentMessageType:ADDRESSING_TYPES.MessageType = ADDRESSING_TYPES.MessageType.FUNCTIONAL
    
    public var UDSRequestType:ADDRESSING_TYPES.UDSRequestType = ADDRESSING_TYPES.UDSRequestType.TESTER_PRESENT
    
    public static var Instance:DOIPSession = DOIPSession()
    
    public init(){}
    
    private var InvalidAddresses:[[UInt8]] = [[]]
    
    public func getInvalidAddresses() -> [[UInt8]]
    {
        InvalidAddresses = [[0xE0, 0x00], [0x0F, 0xFF]]
        return InvalidAddresses
    }
    
    private var ValidProtocolVersions:[UInt8] = []
    
    public func getValidProtocolVersions() -> [UInt8]
    {
        ValidProtocolVersions = [0xFF, 0x01, 0x02]
        return ValidProtocolVersions
    }
    
    private var ValidFurtherActions:[UInt8] = []
    
    public func getValidFurtherActions() -> [UInt8]
    {
        ValidFurtherActions = [0x01, 0x0F]
        return ValidFurtherActions
    }
    
    public var RemoteEndPoint:IPEndPoint = IPEndPoint()
    
    public var LOCAL_TCP_PORT:Int = 13400
    public var LOCAL_UDP_PORT:Int = 13400
    
    public var DefaultProtocolVersion:UInt8 = 0xFF
    public func DefaultInverseProtocolVersion() -> UInt8
    {
        return DefaultProtocolVersion ^ 0xFF
    }
    
    public var ProtocolVersion:UInt8 = 0x01
    public func InverseProtocolVersion() -> UInt8
    {
        return ProtocolVersion ^ 0xFF
    }
    
    public var FurtherAction:UInt8 = 0x00
    
    var TargetAddress:[UInt8] = [0x00, 0x00]
    
    
    public var DiagnosticSessionSID:UInt8 = 0x10
    public var DefaultDiagSessionLID:UInt8 = 0x01
    public var ECUResetSID:UInt8 = 0x11
    
    
    public var LastDiagnosticResponseData:[UInt8]? = []
    
    public var RespondedDOIPEntityCachedData:DOIPEntity! = DOIPEntity()
    
    public func ResetSession()
    {
        RemoteEndPoint = IPEndPoint(_IPAddress: DOIPParameters.Instance.DOIP_Entity_IPAddress, _Port: DOIPParameters.Instance.DOIP_ENTITY_UDP_DISCOVER)
        
        LOCAL_UDP_PORT = DOIPParameters.Instance.TESTER_UDP_PORT
        
        LOCAL_TCP_PORT = 13400
    }
}
