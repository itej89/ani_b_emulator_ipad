//
//  IDiagState.swift
//  FourierMachines.Ani.Client.BOIP
//
//  Created by Tej Kiran on 31/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol IDiagState
{
    var ValidationErrors:ValidationRuleMessages { get set }
    
    func HandleIncomingData(objResponse:DOIPResponseObject?) -> (Int, [UInt8]?)
}
