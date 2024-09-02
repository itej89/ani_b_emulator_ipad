//
//  Scheduler.swift
//  FourierMachines.Ani.Client.Scheduler
//
//  Created by Tej Kiran on 07/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation


public class Scheduler:JobConvey
{
  
    public static let SharedInstance:Scheduler = Scheduler()
    
  
    //Delegate job convey
    public func notify_Paused(ID:UUID) {
        
    }
    
    public func notify_LostResource(ID:UUID) {
        
    }
    
    public func notify_NextStep(ID:UUID) {
        let job = FindJobByID(UID: ID)
        if(job != nil)
        {
           job?.Resume()
        }
        
    }
    
    public func notify_Finish(ID:UUID) {
        DeleteJob(id: ID)
    }
    //End delegate
    
    
    var JOBS:[Job] = []
    
    var JOB_STORE:[Job] = []
    
    var Idle_JOB:Job = Job()
    
    var Current_JOB:Job!
    
  
    
    private init()
    {
        JOBS.append(Idle_JOB)
        Current_JOB = Idle_JOB
        Current_JOB.TakeOverResources(_delegate: self)
        Current_JOB.Resume()
    }
    
    public func FindJobByID(UID:UUID) -> Job!
    {
        if(Current_JOB != nil && Current_JOB.ID == UID)
        {
            return Current_JOB
        }
        
        for i in 1..<JOBS.count
        {
            if(JOBS[i].ID == UID)
            {
                return JOBS[i]
            }
            
        }
        
        for i in 0..<JOB_STORE.count
        {
            if(JOB_STORE[i].ID == UID)
            {
                return JOB_STORE[i]
            }
            
        }
        
        return nil
    }
    
    public func KillJobWithID(UID: UUID)
    {
        let job = FindJobByID(UID: UID)
        if(job != nil)
        {
            job?.Pause()
            if(job != nil && job?.delegate != nil)
            {
            job?.delegate.notify_Finish(ID: UID)
            }
        }
        
    }
    
    public func ScheduleNextJOB()
    {
        DoJob(job: FindHighestPriorityJob())
    }
    
    public func PauseCurrentJob()
    {
        if(Current_JOB != nil && Current_JOB.ID != JOBS[0].ID)
        {
            Current_JOB.Pause()
        }
    }
   
    
    public func AddJob(job: Job)->Bool
    {
        if(job.PRIORITY == JOB_PRIORITY.ZERO){
            return false
        }
        
        JOBS.append(job)
        if(Current_JOB == nil)
        {
            DoJob(job: job)
        }
        else
        if(job.PRIORITY.rawValue > Current_JOB.PRIORITY.rawValue)
        {
            Current_JOB.Pause()
            DoJob(job: job)
        }
        
        return true
        
    }
    
    public func FindHighestPriorityJob()->Job
    {
        var job:Job = JOBS[0]
        for i in 0..<JOBS.count
        {
            if(JOBS[i].PRIORITY.rawValue > job.PRIORITY.rawValue)
            {
                job = JOBS[i]
            }
        }
        return job
    }
    
    public func DeleteJob(id:UUID)
    {
        if(JOBS.count > 1){
        for i in 1..<JOBS.count
        {
            if JOBS[i].ID == id
            {
                JOBS.remove(at: i)
                if(Current_JOB != nil && Current_JOB.ID == id)
                {
                    Current_JOB = nil
                }
                break
            }
        }
        }
    }
    
    public func DoJob(job:Job)
    {
        if(Current_JOB != nil && Current_JOB.ID == job.ID){
        return
        }
        
        Current_JOB = job
        Current_JOB.TakeOverResources(_delegate: self)
        Current_JOB.Resume()
        
    }
    
    //This method is added to empty jobs que during system pause and-
    //-moves all the jobs other than IDLE job to store buffer
    //This will stop scheduler from executing peding jobs after pause
    public func MoveAllJobsToStoreBuffer()
    {
        let TotalNumberOfPendingJobs = JOBS.count
        if(TotalNumberOfPendingJobs > 1){
            //Move all pending jobs to store buffer exept for the IDLE job
            for i in 1..<TotalNumberOfPendingJobs
            {
                JOB_STORE.append(JOBS[i])
            }
            //Remove all pending jobs to from Jobs buffer
            while(JOBS.count > 1)
            {
                JOBS.remove(at: 1)
            }
        }
        
        if(Current_JOB != nil)
        {
            Current_JOB.Pause()
        }
        
        Current_JOB = JOBS[0]
       
        print("numberof jobs stored : ")
        print(TotalNumberOfPendingJobs)
    }
    
    //This method is added to restore jobs que after system restore
    //This will resume any jobs paused during system pause
    public func RestorePendingJobsFromStoreBuffer()
    {
        let TotalNumberOfPendingJobs = JOB_STORE.count
        if(TotalNumberOfPendingJobs > 0){
            //Move all stored pending jobs to JOBS que
            for i in 0..<TotalNumberOfPendingJobs
            {
                JOBS.append(JOB_STORE[i])
            }
            //Clear all store jobs
            while(JOB_STORE.count > 0)
            {
                JOB_STORE.remove(at: 0)
            }
        }
        
        DoJob(job: FindHighestPriorityJob())
    }
    
}
