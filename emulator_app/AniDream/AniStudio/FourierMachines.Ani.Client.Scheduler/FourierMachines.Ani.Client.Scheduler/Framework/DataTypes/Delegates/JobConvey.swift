//
//  JobConvey.swift
//  FourierMachines.Ani.Client.Scheduler
//
//  Created by Tej Kiran on 07/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol JobConvey
{
   func notify_LostResource(ID:UUID)
    func notify_Paused(ID:UUID)
   func notify_NextStep(ID:UUID)
   func notify_Finish(ID:UUID)
}
