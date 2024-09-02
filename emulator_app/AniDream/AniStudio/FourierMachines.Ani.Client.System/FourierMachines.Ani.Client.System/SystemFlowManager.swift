//
//  SystemEventLimit.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 01/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Scheduler
import FourierMachines_Ani_Client_Kinetics
import GraphicAnimation
import FourierMachines_Ani_Client_Articulation
import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_BotConnect
import FourierMachines_Ani_Client_BOIP

public class SystemFlowManager: UIMAINConvey
{
    
    enum FLOW_STATES {
        case IDLE
        case BROWSE_ANIMATION
        case CHOREOGRAM
        case ADD_ANIMATION
        case NA
    }
    
    var CURRENT_STATE:FLOW_STATES = FLOW_STATES.NA
    
    var animationIDLEjob:IDLEAnimationJob!
    var browseAnimations:BrowseAnimationsJob!
    var AddAnimationJob:AddEmotionJob!
    var choreogramJob:ChoreogramJob!
    
    
    func PauseCurrentJOB()
    {
       Scheduler.SharedInstance.PauseCurrentJob()
    }
    
    func EndCurrentJob()
    {
        PauseCurrentJOB()
    }
    
    
    //UIMAINConvey
    public func AppStarted() {
       
    }
    public func ShowIdle()
    {
        if(CURRENT_STATE == FLOW_STATES.ADD_ANIMATION)
        {
            if(AddAnimationJob != nil)
            {
                Scheduler.SharedInstance.KillJobWithID(UID: AddAnimationJob.ID)
            }
        }
        
        if(CURRENT_STATE == FLOW_STATES.BROWSE_ANIMATION)
        {
            if(browseAnimations != nil)
            {
                Scheduler.SharedInstance.KillJobWithID(UID: browseAnimations.ID)
            }
        }
        
        if(animationIDLEjob == nil){
            animationIDLEjob =  IDLEAnimationJob()
            _=Scheduler.SharedInstance.AddJob(job: animationIDLEjob)
        }
        else
        {
            Scheduler.SharedInstance.ScheduleNextJOB()
        }
        
        CURRENT_STATE = FLOW_STATES.IDLE
    }
    
    
    
    public func ScanBot()
    {
        BotConnectionHandler.Instance.StartBotScan()
    }
    
    public func GetConnectedBot() -> BotDetails!
     {
        return BotConnectionHandler.Instance.GetConnectedBot()
     }

    public func StopBotScan()
    {
        BotConnectionHandler.Instance.StopBotScan()
    }
    public func ConnectBot(_ID:String)
    {
         BotConnectionHandler.Instance.ConnectToBot(_ID: _ID)
    }
    public func DisconnectBot()
    {
        BotConnectionHandler.Instance.DisconnectBot()
    }
    public func StartBrowseAnimationsJob()
    {
        
        if(CURRENT_STATE == FLOW_STATES.ADD_ANIMATION)
        {
            if(AddAnimationJob != nil)
            {
                Scheduler.SharedInstance.KillJobWithID(UID: AddAnimationJob.ID)
            }
        }
        
        if(CURRENT_STATE == FLOW_STATES.CHOREOGRAM)
        {
            if(choreogramJob != nil)
            {
                Scheduler.SharedInstance.KillJobWithID(UID: choreogramJob.ID)
            }
        }
        
        if(browseAnimations != nil)
        {
            Scheduler.SharedInstance.KillJobWithID(UID: browseAnimations.ID)
        }
        browseAnimations = BrowseAnimationsJob()
        _=Scheduler.SharedInstance.AddJob(job: browseAnimations)
        CURRENT_STATE = FLOW_STATES.BROWSE_ANIMATION
    }
    
    public func ShowBrowsedPlaneAnimation(ActionData:String)
    {
         if(CURRENT_STATE == FLOW_STATES.BROWSE_ANIMATION && browseAnimations != nil)
         {
            browseAnimations.requestToDoPlaneAnimation(json: ActionData)
         }
    }
    
    public func ShowBrowsedAnimation(ActionData:String, MusicFile:String)
    {
        if(CURRENT_STATE == FLOW_STATES.BROWSE_ANIMATION && browseAnimations != nil)
        {
            browseAnimations.requestToDoAnimation(json: ActionData, MusicFile: MusicFile)
        }
    }
    
    public func UploadEmSynthOnBot()
    {
        BotConnectionHandler.Instance.UploadEmSynth()
    }
    
    public func UploadChoreogramOnBot()
    {
        BotConnectionHandler.Instance.UploadChoreogram()
    }
    
    public func PlayChoreogramOnBot()
    {
        BotConnectionHandler.Instance.RunChoreogram()
    }
    
    public func StartChoreogramJob()
    {
        
        if(CURRENT_STATE == FLOW_STATES.ADD_ANIMATION)
        {
            if(AddAnimationJob != nil)
            {
                Scheduler.SharedInstance.KillJobWithID(UID: AddAnimationJob.ID)
            }
        }
        
        if(choreogramJob != nil)
        {
            Scheduler.SharedInstance.KillJobWithID(UID: choreogramJob.ID)
        }
        choreogramJob = ChoreogramJob()
        _=Scheduler.SharedInstance.AddJob(job: choreogramJob)
        CURRENT_STATE = FLOW_STATES.CHOREOGRAM
    }
    
    public func ShowChoreogram(audio:String, StartSec:Int, StopSec:Int, beats:[Beats_Type])
    {
        if(CURRENT_STATE == FLOW_STATES.CHOREOGRAM && choreogramJob != nil)
        {
            choreogramJob.requestToDoAnimation(audio: audio, StartSec:StartSec, StopSec:StopSec, beats: beats)
        }
    }
    
    public func PauseChoreogram()
    {
        if(CURRENT_STATE == FLOW_STATES.CHOREOGRAM && choreogramJob != nil)
        {
            choreogramJob.Stop()
        }
    }
    public func StartAddEmotionJob(InitAnimation:String = "")
    {
        if(AddAnimationJob != nil)
        {
            Scheduler.SharedInstance.KillJobWithID(UID: AddAnimationJob.ID)
        }
        AddAnimationJob = AddEmotionJob(InitAction: InitAnimation)
        _=Scheduler.SharedInstance.AddJob(job: AddAnimationJob)
        CURRENT_STATE = FLOW_STATES.ADD_ANIMATION
    }
    
    public func ShowCreatedAnimationWithMusic(ActionData:String, MusicFile:String)
    {
        if(CURRENT_STATE == FLOW_STATES.ADD_ANIMATION && AddAnimationJob != nil)
        {
            AddAnimationJob.requestToDoAnimation(json: ActionData, MusicFile: MusicFile)
        }
    }
    public func ShowCreatedAnimation(ActionData:String)
    {
        if(CURRENT_STATE == FLOW_STATES.ADD_ANIMATION && AddAnimationJob != nil)
        {
            AddAnimationJob.requestToDoPlaneAnimation(json: ActionData)
        }
    }
    //End of UIMAINConvey
    
    
    
    //Kinetics ApplicationstateChanged
    func WentBackground() {
        
    }
    
    func CameForeground() {
        
    }
    //End ApplicationstateChanged
    
    
    public static var Instance:SystemFlowManager = SystemFlowManager()
    
    private init()
    {
        ArticulationManager.Instance.InitializeArticulation()
//        let Db:DB_Local_Store = DB_Local_Store()
//       _ = Db.RemoveDB()
//       _ = Db.PlaceDB()
    }
    
}

