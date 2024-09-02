//
//  Servo_Calibration_Type.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation


class  Servo_Calibration_Type
{
    
    var Name:String = ""
    var Degree:UInt8 = 0
    var ADC:UInt16 = 0
    
    init(name:String, degree:UInt8, adc:UInt16)
    {
        Name = name
        Degree = degree
        ADC = adc
    }
    
    init(degree:UInt8, adc:UInt16)
    {
        Degree = degree
        ADC = adc
    }
    init()
    {
    }
}
