//
//  DoIPGenericHeaderHandler.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DoIPGenericHeaderHandler:IValidation
{
    public var ValidationErrors: ValidationRuleMessages
    
    init()
    {
        ValidationErrors = ValidationRuleMessages()
    }
    
    public static var Instance:DoIPGenericHeaderHandler = DoIPGenericHeaderHandler()
    
    public func ValidateHeader(objResponse:DOIPResponseObject?) -> Bool
    {
        ValidationErrors.Messages.removeAll()
        if(objResponse != nil)
        {
            if(!DOIPSession.Instance.getValidProtocolVersions().contains((objResponse?.GetProtocolVersion())!))
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Protocol version"))
            }
            if((objResponse?.GetInverseProtocolVersion())! != (objResponse?.GetProtocolVersion())! ^ 0xFF)
            {
                ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.INVALID_DATA, strAdditionalInfo: "Inverse Protocol version"))
            }
        }
        else{
            ValidationErrors.Add(item: ValidationRuleMessage(lobjReturn: VALIDATION_ERROR_CODES.EMPTY, strAdditionalInfo: "Response Object"))
        }
        
        if(ValidationErrors.Messages.count > 0)
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
}
