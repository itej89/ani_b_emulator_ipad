//
//  COMMAND _TYPES.swift
//  FourierMachines.Ani.Client.Mqtt
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum COMMAND_TYPES:String
{
    case PLAY_EMSYNTH
    case STOP_EMSYNTH
    case PLAY_CHOREOGRAM
    case STOP_CHOREOGRAM
    case PLAY_TELTALE
    case STOP_TELTALE
    case NA
    
    var description:String
    {
        switch self {
        case .PLAY_CHOREOGRAM:
            return COMMAND_TYPES.PLAY_CHOREOGRAM.rawValue
        case .STOP_CHOREOGRAM:
            return COMMAND_TYPES.STOP_CHOREOGRAM.rawValue
        case .PLAY_TELTALE:
            return COMMAND_TYPES.PLAY_TELTALE.rawValue
        case .STOP_TELTALE:
            return COMMAND_TYPES.STOP_TELTALE.rawValue
        case .PLAY_EMSYNTH:
            return COMMAND_TYPES.PLAY_EMSYNTH.rawValue
        case .STOP_EMSYNTH:
            return COMMAND_TYPES.STOP_EMSYNTH.rawValue
        case .NA:
            return COMMAND_TYPES.NA.rawValue
        }
    }
}
