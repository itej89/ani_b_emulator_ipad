//
//  JobPriority.swift
//  FourierMachines.Ani.Client.Scheduler
//
//  Created by Tej Kiran on 07/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public enum JOB_PRIORITY : Int
{
    case  ZERO = 0,
          LOW = 1,
          CASUAL = 2,
          LIVE = 3,
          BROWSE_EMOTIONS = 4,
          CHOREOGRAM = 5,
          ADD_EMOTIONS = 6,
    
          USER_ATTENTION = 1000,
          MACHINE_RESPONCE = 1001,
          USER_CRITICAL = 1002,
          SYSTEM_CRITICAL = 1003,
          EMERGENCY = 1004
}

