//
//  STATUS_CODES.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum VALIDATION_ERROR_CODES:String
{
    case FAIL
    case EMPTY
    case INCORRECT_LENGTH
    case INVALID_DATA
    case NO_PAYLOAD_ITEMS_FOUND
    case NETWORK_DISCONN
    case EMPTY_SOCKET
    case REMOTE_SOCKET_DISCONN
    case REMOTE_SOCKET_REFUSED_CONN
    case NO_PREVIOUS_DIAGNOSTIC_DATA
    case NO_SOURCE_ADDRESS
    
    var description:String{
        switch self {
        case .FAIL:
            return "FAIL"
        case .EMPTY:
             return "EMPTY"
        case .INCORRECT_LENGTH:
             return "INCORRECT_LENGTH"
        case .INVALID_DATA:
             return "INVALID_DATA"
        case .NO_PAYLOAD_ITEMS_FOUND:
             return "NO_PAYLOAD_ITEMS_FOUND"
        case .NETWORK_DISCONN:
             return "NETWORK_DISCONN"
        case .EMPTY_SOCKET:
             return "EMPTY_SOCKET"
        case .REMOTE_SOCKET_DISCONN:
             return "REMOTE_SOCKET_DISCONN"
        case .REMOTE_SOCKET_REFUSED_CONN:
             return "REMOTE_SOCKET_REFUSED_CONN"
        case .NO_PREVIOUS_DIAGNOSTIC_DATA:
             return "NO_PREVIOUS_DIAGNOSTIC_DATA"
        case .NO_SOURCE_ADDRESS:
             return "NO_SOURCE_ADDRESS"
        }
    }
}

public class DIAGNOSTIC_STATUS
{
    public enum CODE:Int
    {
        case COMPLETE
        case INTERNAL_ERROR
        case UDP_TIMEOUT
        case TCP_TIMEOUT
        case SUCCESS
        case DIAG_ACK_TIMEOUT
        case ACTIVATIOMN_CONFIRMATION_TIMEOUT
        case INVALID_HEADER
        case RESERVED_ISO13400
        
        //Routing activation resposnse codes
        case RA_RES_DENIED_UNKNOWN_SOURCE_ADDRESS
        case RA_RES_DENIED_ALL_SUPPORTED_SOCKETS_REGISTERED_AND_ACTIVE
        case RA_RES_DENIED_SOURCE_ADDRESS_MISMATCH
        case RA_RES_DENIED_SOURCE_ADDRESS_ACTIVE_OTHER_PORT
        case RA_RES_DENIED_MISSING_AUTHENTICATION
        case RA_RES_DENIED_REJECTED_CONFIRMATION
        case RA_RES_DENIED_UNSUPPORTED_ACTIVATION_TYPE
        case RA_RES_VEHICLE_MANUFACTURER_SPECIFIC
        
        //generic NAK (header+diagnostic)
        case MESSAGE_TOO_LARGE
        case OUT_OF_MEMORY
        
        //generic header NACK codes
        case NAK_INCORRECT_PATTERN
        case NAK_UNKNOWN_PAYLOAD
        case NAK_INVALID_PAYLOAD_LENGTH
        
        //diagnostic message negative ackowledgement codes
        case DIAG_NAK_UNKOWN_NETWORK
        case DIAG_NAK_INVALID_SOURCE_ADDRESS
        case DIAG_NAK_TARGET_UNREACHABLE
        case DIAG_NAK_TRANSPORT_PROTOCOL_ERROR
        case DIAG_NAK_UNKOWN_TARGET
        
        //diagnostic power mode information codes
        case DIAG_POWER_MODE_NOT_READY
        case DIAG_POWER_MODE_NOT_SUPPORTED
        
        //uds status codes
        case DIAG_RESPONSE_TIMEOUT
        case DIAG_RECONN_TIMEOUT
        
        case NO_RESPONSE
        
        case DIAG_PROGRESS
    }
    
    public var ResponseCode_ErrorCode:[Activation_Response_Codes.CODE:Int] = [
        Activation_Response_Codes.CODE.RA_RES_DENIED_ALL_SUPPORTED_SOCKETS_REGISTERED_AND_ACTIVE:CODE.RA_RES_DENIED_ALL_SUPPORTED_SOCKETS_REGISTERED_AND_ACTIVE.rawValue,
        Activation_Response_Codes.CODE.RA_RES_DENIED_MISSING_AUTHENTICATION:CODE.RA_RES_DENIED_MISSING_AUTHENTICATION.rawValue,
        Activation_Response_Codes.CODE.RA_RES_DENIED_REJECTED_CONFIRMATION:CODE.RA_RES_DENIED_REJECTED_CONFIRMATION.rawValue,
        Activation_Response_Codes.CODE.RA_RES_DENIED_SOURCE_ADDRESS_ACTIVE_OTHER_PORT:CODE.RA_RES_DENIED_SOURCE_ADDRESS_ACTIVE_OTHER_PORT.rawValue,
        Activation_Response_Codes.CODE.RA_RES_DENIED_SOURCE_ADDRESS_MISMATCH:CODE.RA_RES_DENIED_SOURCE_ADDRESS_MISMATCH.rawValue,
        Activation_Response_Codes.CODE.RA_RES_DENIED_UNKNOWN_SOURCE_ADDRESS:CODE.RA_RES_DENIED_UNKNOWN_SOURCE_ADDRESS.rawValue,
        Activation_Response_Codes.CODE.RA_RES_DENIED_UNSUPPORTED_ACTIVATION_TYPE:CODE.RA_RES_DENIED_UNSUPPORTED_ACTIVATION_TYPE.rawValue,
        
            Activation_Response_Codes.CODE.RA_RES_RESERVED_ISO13400:CODE.RESERVED_ISO13400.rawValue,
        Activation_Response_Codes.CODE.RA_RES_VEHICLE_MANUFACTURER_SPECIFIC:CODE.RA_RES_VEHICLE_MANUFACTURER_SPECIFIC.rawValue,
    ]
    
    public var HeaderNACKCode_ErrorCode:[NAK_Codes.CODE:Int] = [
        NAK_Codes.CODE.NAK_INCORRECT_PATTERN: CODE.NAK_INCORRECT_PATTERN.rawValue,
        NAK_Codes.CODE.NAK_INVALID_PAYLOAD_LENGTH: CODE.NAK_INVALID_PAYLOAD_LENGTH.rawValue,
        NAK_Codes.CODE.NAK_MESSAGE_TOO_LARGE: CODE.MESSAGE_TOO_LARGE.rawValue,
        NAK_Codes.CODE.NAK_OUT_OF_MEMORY: CODE.OUT_OF_MEMORY.rawValue,
        NAK_Codes.CODE.NAK_RESERVED_ISO13400: CODE.RESERVED_ISO13400.rawValue,
        NAK_Codes.CODE.NAK_UNKNOWN_PAYLOAD: CODE.NAK_UNKNOWN_PAYLOAD.rawValue
    ]
    
    public var DiagNACKCode_ErrorCode:[Diagnostic_NAK_Codes.CODE:Int] = [
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_RESERVED_ISO13400: CODE.RESERVED_ISO13400.rawValue,
    
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_INVALID_SOURCE_ADDRESS: CODE.DIAG_NAK_INVALID_SOURCE_ADDRESS.rawValue,
        
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_UNKOWN_TARGET: CODE.DIAG_NAK_UNKOWN_TARGET.rawValue,
        
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_MESSAGE_TOO_LARGE: CODE.MESSAGE_TOO_LARGE.rawValue,
        
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_OUT_OF_MEMORY: CODE.OUT_OF_MEMORY.rawValue,
        
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_TARGET_UNREACHABLE: CODE.DIAG_NAK_TARGET_UNREACHABLE.rawValue,
        
        Diagnostic_NAK_Codes.CODE.DIAG_NAK_UNKOWN_NETWORK: CODE.DIAG_NAK_UNKOWN_NETWORK.rawValue,
        
        Diagnostic_NAK_Codes.CODE.DAIG_NAK_TRANSPORT_PROTOCOL_ERROR: CODE.DIAG_NAK_TRANSPORT_PROTOCOL_ERROR.rawValue
    ]
    
    public var DiagPowerModeCode_ErrorCode:[Diagnostic_Power_mode_Values.CODE:Int] = [
        Diagnostic_Power_mode_Values.CODE.DIAG_POWER_MODE_NOT_READY: CODE.DIAG_POWER_MODE_NOT_READY.rawValue,
        Diagnostic_Power_mode_Values.CODE.DIAG_POWER_MODE_NOT_SUPPORTED: CODE.DIAG_POWER_MODE_NOT_SUPPORTED.rawValue,
        Diagnostic_Power_mode_Values.CODE.DIAG_POWER_MODE_RESERVED_ISO13400: CODE.RESERVED_ISO13400.rawValue,
    
    ]
    
    
}
