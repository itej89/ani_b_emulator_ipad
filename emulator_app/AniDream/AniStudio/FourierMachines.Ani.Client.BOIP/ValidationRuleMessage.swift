//
//  ValidationRuleMessage.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class ValidationRuleMessage
{
    public init()
    {}
    
    public init(lobjReturn:VALIDATION_ERROR_CODES, strAdditionalInfo:String)
    {
        ErrorCode = lobjReturn
        AdditionalInfo = strAdditionalInfo
    }
    
    public init(lobjReturn:VALIDATION_ERROR_CODES)
    {
        ErrorCode = lobjReturn
        DisplayMessage = ErrorCode.description
    }
    
    public init(lobjReturn:VALIDATION_ERROR_CODES, MethodInfo:String,strAdditionalInfo:String="")
    {
        ErrorCode = lobjReturn
        AdditionalInfo = MethodInfo
        DisplayMessage = ErrorCode.description
    }
    
    public var AdditionalInfo:String = ""
    public var ErrorCode:VALIDATION_ERROR_CODES = VALIDATION_ERROR_CODES.FAIL
    public var DisplayMessage:String = ""
}
