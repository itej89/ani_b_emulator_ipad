//
//  MatricesMathHelper.swift
//  FourierMachines.Ani.Client.Common
//
//  Created by Tej Kiran on 16/06/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation


public func Make3DAffineTransformFrom2DMatrix(_2DAffine:CGAffineTransform) -> CATransform3D
{
    var _3DAffine = CATransform3DIdentity
    
    _3DAffine.m11 = _2DAffine.a
    _3DAffine.m12 = _2DAffine.b
    _3DAffine.m13 = 0
    _3DAffine.m14 = 0
    
    
    _3DAffine.m21 = _2DAffine.c
    _3DAffine.m22 = _2DAffine.d
    _3DAffine.m23 = 0
    _3DAffine.m24 = 0
    
    
    _3DAffine.m31 = 0
    _3DAffine.m32 = 0
    _3DAffine.m33 = 1
    _3DAffine.m34 = 0
    
    
    _3DAffine.m41 = _2DAffine.tx
    _3DAffine.m42 = _2DAffine.ty
    _3DAffine.m43 = 0
    _3DAffine.m44 = 1
    
    return _3DAffine
}


public func Make3DAffineTransformFrom2DMatrix(_2DMatrix:[[CGFloat]]) -> CATransform3D
{
    var _3DAffine = CATransform3DIdentity
    
    _3DAffine.m11 = _2DMatrix[0][0]
    _3DAffine.m12 = _2DMatrix[0][1]
    _3DAffine.m13 = 0
    _3DAffine.m14 = _2DMatrix[0][2]
    
    
    _3DAffine.m21 = _2DMatrix[1][0]
    _3DAffine.m22 = _2DMatrix[1][1]
    _3DAffine.m23 = 0
    _3DAffine.m24 = _2DMatrix[1][2]
    
    
    _3DAffine.m31 = 0
    _3DAffine.m32 = 0
    _3DAffine.m33 = 1
    _3DAffine.m34 = 0
    
    
    _3DAffine.m41 = _2DMatrix[2][0]
    _3DAffine.m42 = _2DMatrix[2][1]
    _3DAffine.m43 = 0
    _3DAffine.m44 = _2DMatrix[2][2]
    
    return _3DAffine
}


public func Make3DMatrixFrom2DMatrix(_2DMatrix:[[CGFloat]]) -> [[CGFloat]]
{
    let _3DMatrix:[[CGFloat]] = [[_2DMatrix[0][0],_2DMatrix[0][1],0,_2DMatrix[0][2]],
                                 [_2DMatrix[1][0],_2DMatrix[1][1],0,_2DMatrix[1][2]],
                                 [      0,             0,         1,              0],
                                 [_2DMatrix[2][0],_2DMatrix[2][1],0,_2DMatrix[2][2]]]
    
    return _3DMatrix
}



// a  b  c
// d  e  f
// g  h  i
public func Multiple3X3Matrix(leftMatrix:[[CGFloat]], RightMatrix:[[CGFloat]]) -> [[CGFloat]]
{
    let a = (leftMatrix[0][0] * RightMatrix[0][0])+(leftMatrix[0][1] * RightMatrix[1][0])+(leftMatrix[0][2] * RightMatrix[2][0])
    let b = (leftMatrix[0][0] * RightMatrix[0][1])+(leftMatrix[0][1] * RightMatrix[1][1])+(leftMatrix[0][2] * RightMatrix[2][1])
    let c = (leftMatrix[0][0] * RightMatrix[0][2])+(leftMatrix[0][1] * RightMatrix[1][2])+(leftMatrix[0][2] * RightMatrix[2][2])
    
    
    let d = (leftMatrix[1][0] * RightMatrix[0][0])+(leftMatrix[1][1] * RightMatrix[1][0])+(leftMatrix[1][2] * RightMatrix[2][0])
    let e = (leftMatrix[1][0] * RightMatrix[0][1])+(leftMatrix[1][1] * RightMatrix[1][1])+(leftMatrix[1][2] * RightMatrix[2][1])
    let f = (leftMatrix[1][0] * RightMatrix[0][2])+(leftMatrix[1][1] * RightMatrix[1][2])+(leftMatrix[1][2] * RightMatrix[2][2])
    
    
    let g = (leftMatrix[2][0] * RightMatrix[0][0])+(leftMatrix[2][1] * RightMatrix[1][0])+(leftMatrix[2][2] * RightMatrix[2][0])
    let h = (leftMatrix[2][0] * RightMatrix[0][1])+(leftMatrix[2][1] * RightMatrix[1][1])+(leftMatrix[2][2] * RightMatrix[2][1])
    let i = (leftMatrix[2][0] * RightMatrix[0][2])+(leftMatrix[2][1] * RightMatrix[1][2])+(leftMatrix[2][2] * RightMatrix[2][2])
    
    return [[a,b,c],[d,e,f],[g,h,i]]
}
