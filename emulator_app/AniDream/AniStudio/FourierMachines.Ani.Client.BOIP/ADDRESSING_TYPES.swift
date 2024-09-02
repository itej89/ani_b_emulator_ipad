//
//  ADDRESSING_TYPES.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class ADDRESSING_TYPES
{
    public enum MessageType
    {
        case PHYSICAL
        case FUNCTIONAL
    }
    
    public enum UDSRequestType
    {
        case UDS
        case TESTER_PRESENT
    }
    
    public static var ANI_DOIPTesterAddressingTypeMap:[String:MessageType] = ["Physical":.PHYSICAL, "Functional":.FUNCTIONAL]
    
    
}
