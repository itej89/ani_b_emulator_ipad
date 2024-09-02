//
//  DOIP_Configuration.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
public enum DOIP_CONFIGURATION
{
    case DOIP_ENTITY_IP_ADDRESS,
    DOIP_ENTITY_UDP_DISCOVER,
    TESTER_IP_ADDRESS,
    TESTER_UDP_PORT,
    
    TESTER_ADDRESS,
    
    
    
    A_Doip_Ctrl,
    DOIP_TCP_RESPONSE_WAIT_TIME,
    DOIP_TCP_RECONNECT_WAIT_TIME,
    A_Doip_Diagnostic_Message,
    A_Processing_Time,
    
    
    DOIP_DEFAULT_PROTOCOL,
    DOIP_IDENTIFICATION_MODE,
    VIN,
    EID,
    A_DOIP_Activation_Request_OEM_SPECIFIC,
    A_DOIP_Activation_Request_ISO_RESERVED,
    Activation_Request_OEM_BYTES_ENABLED,
    RoutingActivationType,
    DOIP_DIAG_NO_ACKK_REPEAT_NUM,
    DOIP_ACTIVATION_CONFIRMATION_REPEAT_TIME,
    DOIP_ACTIVATION_CONFIRMATION_REPEAT_COUNT,
    
    
    DiagPowerModeSupported,
    DiagEntityStatusSupported,
    
    
    
    
    
    
    
    
    
    
    
    TxData,TargetAddress,
    RxData,RxMAsk, CycleTime,
    
    Nrc21or23RepeatCount,
    P6Client,
    P6ClientPhys,
    P6ClientResponsePending,
    
    ResponsePendingResponse,
    ResponsePendingMask,
    FunctionalTargetAddress,
    P3ClientFunc,
    
    
    nrc21,
    nrc23,
    nrcMask
    }

