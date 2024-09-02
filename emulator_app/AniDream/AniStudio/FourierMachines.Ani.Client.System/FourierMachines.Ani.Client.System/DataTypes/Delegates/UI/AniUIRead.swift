//
//  AniUI.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 06/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import SceneKit
import GraphicAnimation

public protocol AniUIRead
{
    func GetAllUIElements()->[AnimationObject:SCNNode]
}
