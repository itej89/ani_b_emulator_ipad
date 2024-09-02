//
//  ValidationRuleMessages.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 30/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class ValidationRuleMessages
{
    public var Messages:[ValidationRuleMessage] = []
    public func Add(item:ValidationRuleMessage)
    {
        Messages.append(item)
    }
}
