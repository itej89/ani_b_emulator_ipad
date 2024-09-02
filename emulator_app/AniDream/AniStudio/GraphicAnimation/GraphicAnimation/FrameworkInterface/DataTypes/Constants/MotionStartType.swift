//
//  MotionStartType.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 27/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public enum MotionStartType
{
    //Defines how the current animation going to be started
    case WAIT_AND_MOVE  //Wait till previous motion is finished
    case INSTANT_MOVE   //stops previous on going motion and start the motion for present animation immediately
}
