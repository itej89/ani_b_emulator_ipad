//
//  File.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum CATEGORY_TYPES:String
{
    case EMSYNTH
    case CHOREOGRAM
    case TELTALE
    case NA
    
   var description : String
    {
        switch self {
        case .EMSYNTH:
            return CATEGORY_TYPES.EMSYNTH.rawValue
        case .CHOREOGRAM:
            return CATEGORY_TYPES.CHOREOGRAM.rawValue
        case .TELTALE:
            return CATEGORY_TYPES.TELTALE.rawValue
        case .NA:
            return CATEGORY_TYPES.NA.rawValue
        }
    }
}
