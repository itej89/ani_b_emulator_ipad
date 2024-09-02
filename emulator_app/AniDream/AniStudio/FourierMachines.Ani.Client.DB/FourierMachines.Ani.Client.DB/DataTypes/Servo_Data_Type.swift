//
//  Servo_Data_Type.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation

class  Servo_Data_Type
{
    var Name:String!
    var Address:Int!
    var Min_Angle:Int!
    var Max_Angle:Int!
    var SERVO_CALIBRATED_DATA = Array<Servo_Calibration_Type>()
    
    init(name:String, address:Int, min_Angle:Int, max_Angle:Int)
    {
        Name = name
        Address = address
        Min_Angle = min_Angle
        Max_Angle = max_Angle
    }
    
}
