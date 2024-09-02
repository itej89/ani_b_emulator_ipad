//
//  TransformMatrixToValueConvertor.swift
//  FourierMachines.Ani.Client.Common
//
//  Created by Tej Kiran on 22/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation


public class TransformMatrixToValueConvertor {
    
    //Transformation Matrix
    //  -      -
    // | a  b  0 |
    // | c  d  0 |
    // | tx ty 1 |
    //  -      -
    public  static func  GetValuesFromMatrix(Transform:CGAffineTransform)->TransformValues
{
    let  tValues:TransformValues = TransformValues()
    tValues.Tx = Transform.tx
    tValues.Ty = Transform.ty
    tValues.ScaleX = (Transform.a.signum()*((pow(Transform.a,2)+pow(Transform.b,2)).squareRoot()));
    tValues.ScaleY = (Transform.d.signum()*((pow(Transform.c,2)+pow(Transform.d,2)).squareRoot()));
    tValues.RotationInRadians =  atan2(Transform.c, Transform.d);
    
    return  tValues
    }
    
}
