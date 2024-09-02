//
//  UnitConvertor.swift
//  FourierMachines.Ani.Client.Common
//
//  Created by Tej Kiran on 23/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

public class FMUnitConvertor {
    
    public static func RadiasToDegree(radians:Float)->Float
    {
        return Float((180/Float.pi)*radians);
    }
    
    public static func DegreeToRadians(degree:Int)->Float
    {
        return Float((Float.pi/180.0)*Float(degree));
    }
    
    public static func UIColorFromRGB(rgbValue: UInt, alpha:Float) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha/100)
        )
    }
    
}
