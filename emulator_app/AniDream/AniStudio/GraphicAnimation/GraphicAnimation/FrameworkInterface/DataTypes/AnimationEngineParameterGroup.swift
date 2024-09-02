//
//  AnimationEngineParameterGroup.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 27/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class AnimationEngineParameterGroup
{
    //Used to connect multipleAnimations that are part of a one complete expression
    public let AnimationGroupID:UUID = UUID()
    
    public var OnPauseAction:AnimationOnPauseRestartAction = AnimationOnPauseRestartAction.DESTROY
    
    public var Expressions:[AnimationEngineParameterType] = []
    
    public func destroy()
    {
        for expression in Expressions
        {
            expression.destroy();
        }
        Expressions.removeAll()
        //  Expressions = null;
    }
}
