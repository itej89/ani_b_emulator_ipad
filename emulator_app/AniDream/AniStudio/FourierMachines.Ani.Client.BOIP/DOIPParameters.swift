//
//  DOIPParameters.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DOIPParameters
{
    public static var Instance:DOIPParameters = DOIPParameters()
    
    public var Data = NSDictionary()
    
    public var DOIP_Entity_IPAddress:String = "255.255.255.255"
    public var DOIP_ENTITY_UDP_DISCOVER = 13400
    
    public var Tester_IPAddress:String = ""
     public var TESTER_UDP_PORT = 13401
    
    public var TesterAddress:[UInt8] = [0x0E, 0x85]
    
    
    
    public var VIN = [UInt8](repeating: 0,count: 17)
    public var EID = [UInt8](repeating: 0,count: 6)
    
    public var A_Doip_ctrl:Int32 = 10000
    
    public var DOIP_DEFAULT_PROTOCOL:UInt8 = 0xFF
    public var DOIP_IDENTIFICATION_MODE:UInt8 = 0x01
    
    
    public var DiagPowerModeSupported:Int = 0
    public var DoIPEntityStatusSupported:Int = 0
    
    
    public var A_DOIP_Activation_Request_OEM_SPECIFIC:[UInt8] = [0x00, 0x00, 0x00, 0x00]
    public var A_DOIP_Activation_Request_ISO_RESERVED:[UInt8] = [0x00, 0x00, 0x00, 0x00]
    
    public var Activation_Request_OEM_BYTES_ENABLED:Int = 1
    
    
    
    
    public var A_Processing_Time:Int32 = 13400
    public var DOIP_ACTIVATION_CONFIRMATION_REPEAT_TIME:Int32 = 3000
    public var DOIP_ACTIVATION_CONFIRMATION_REPEAT_COUNT:Int32 = 20
    
    public var DOIP_TCP_RESPONSE_WAIT_TIME:Int32 = 5000
    public var DOIP_TCP_RECONNECT_WAIT_TIME:Int32 = 5000
    
    public var A_Doip_Diagnostic_Message:Int32 = 5000
    public var DOIP_DIAG_NO_ACK_REPEAT_NUM:Int32 = 2
    public var RoutingActivationType:UInt8 = 0x00
    

    
    
    
    public var Nrc21or23RepeatCount:Int32 = 3
    
    public var P6Client:Int32 = 5000
    public var P3ClientPhys:Int32 = 5000
    public var P6ClientResponsePending = 5000
    
    public var ResponsePendingResponse:Int = 0x7F0078
    public var ResponsePendingMask:Int = 0xFF00FF
    
    public var FunctionaTargetAddress:[UInt8] = [0xe4, 0x00]
    public var P3ClientFunc:Int32 = 5000
    
    public var CycleTime:Int32 = 2000
    
    public var TxData:[UInt8] = [0x3E]
    
    public var TesterPresentTargetAddress:[UInt8] = [0xe4, 0x00]
    public var RxData:[UInt8] = [0x7E]
    public var RxMask:[UInt8] = [0xFF]
    
    
    public var nrc21:Int = 0x7f0021
    public var nrc23:Int = 0x7f0023
    
    public var nrcMask:Int = 0xff00ff
    
    
    public init()
    {
        
    }
    
}
