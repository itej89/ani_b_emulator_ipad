//
//  Job.swift
//  FourierMachines.Ani.Client.Scheduler
//
//  Created by Tej Kiran on 07/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

open class Job:NSObject
{
    public var  Name:String = "";
    public var ID:UUID = UUID()
    public var PRIORITY = JOB_PRIORITY.ZERO
    public var delegate:JobConvey!
    public var STATE = JOB_STATE.NA
    
    open func TakeOverResources(_delegate:JobConvey )
    {
        delegate = _delegate
    }
    
    open func Pause()
    {
        
        if(delegate != nil){
        delegate.notify_Paused(ID: ID)
        }
        
    }
    
    open func Resume()
    {
    }
    
}
