//
//  CircularPathDirection.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 26/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


enum CircularPathDirection: Int, CustomStringConvertible {
    case clockwise = 0
    case anitiClockwise = 1
    
    static var count: Int { return CircularPathDirection.anitiClockwise.hashValue + 1 }
    
    var description: String {
        switch self {
        case .clockwise: return "clockwise"
        case .anitiClockwise   : return "anitiClockwise"
        }
    }
    
}

var CircularPathDirectionStringToOptions:[String : CircularPathDirection] = ["clockwise":CircularPathDirection.clockwise,
                                                                             "anitiClockwise":CircularPathDirection.anitiClockwise]


