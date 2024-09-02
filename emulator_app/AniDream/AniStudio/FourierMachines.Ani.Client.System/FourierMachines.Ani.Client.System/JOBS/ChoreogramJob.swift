//
//  ChoreogramJob.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 10/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Scheduler
import GraphicAnimation
import FourierMachines_Ani_Client_Articulation


public class ChoreogramJob: AnimateEngine, PlayerConvey, ChoreogramBindings, ChoreogramRead
{
    
    public override init() {
        
        super.init()
        delChoreogramBinding = self
        ShouldAutoTerinateJob = false
        PRIORITY = JOB_PRIORITY.CHOREOGRAM
    }
    
    func TakeOverMotionGraphicResourcesAndInitializeEngine()
    {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async(group: group) {
            self.GraphicNodes =  UIMAINModuleHandler.Instance.AniUIHandler.GetAllUIElements()
            group.leave()
        }
        
        // does not wait. But the code in notify() gets run
        // after enter() and leave() calls are balanced
        
        group.notify(queue: .main) {
            
            self.InitializeEngine(PositionData: [])
            //            let dbHAndler = DB_Local_Store()
            
            //            let Expression =  dbHAndler.readExpression(ByName :"Stand_Straight")
            //            self.requestToDoAnimation(json: Expression.Action_Data)
        }
    }
    
    open override func TakeOverResources(_delegate: JobConvey)
    {
        self.STATE = JOB_STATE.NA
        super.TakeOverEngineResources(_delegate: _delegate)
        TakeOverMotionGraphicResourcesAndInitializeEngine()
        AudioContextConveyHandler.Instance.PullPlayerDelegates(delegate: self)
        UIChoreogramHandler.Instance.setNotifyOnRead(_choreogramRead: self)
    }
    
    open override func Resume() {
        if(STATE == JOB_STATE.INITIALIZED)
        {
            if(self.ReadyEngineToResume()){
                STATE = JOB_STATE.RUNNING
                
            }
            else
            {
                return
            }
        }
        
        if(STATE == JOB_STATE.RUNNING)
        {
            self.ResumeEngine()
        }
    }
    
    open func IsPaused() -> Bool
    {
        if(STATE == JOB_STATE.PAUSED)
        {
            return true
        }
        return false
    }
    
    open override func Pause() {
        STATE = JOB_STATE.PAUSED
        AudioContextConveyHandler.Instance.RevokePlayerDelegates()
        UIChoreogramHandler.Instance.RevokeChoreogramRead()
        self.PauseEngine()
        //self.delegate.notify_Finish(ID: ID)
    }
    
    //ChoreogramBindings
    public func ShouldWaitToTrigger(StartSec: Int) -> Bool {
        
        if(StartSec < 0)
        {
            return false
        }
        if(Int(audioProgress*1000) < StartSec)
        {
            return true
        }
        
        return false
    }
    //End of ChoreogramBindings
    
    //PlayerConvey
    public func FinishedPlayingSound() {
        
    }
    
    var audioProgress = 0.0
    var StopTime = 0.0
    public func UpdateAudioPlayProgress(progress: Double) {
        audioProgress = progress
        if(progress > StopTime)
        {
            Stop()
            UIChoreogramHandler.Instance.getChoreogramConvey().ChoreogramFinished()
        }
        else
        if(UIChoreogramHandler.Instance.getChoreogramConvey() != nil)
        {
            UIChoreogramHandler.Instance.getChoreogramConvey().ProgressUpdated(progress: progress)
        }
    }
    //End of PlayerConvey
    
    //ChoreogramRead
    public func IsPlaying() -> Bool {
       return ArticulationManager.Instance.IsSoundPlayerPlaying()
    }
    //End of ChoreogramRead
    
    public func Stop()
    {
        ArticulationManager.Instance.PauseSound()
        self.haltEngine()
    }
    
    public func requestToDoAnimation(audio:String, StartSec:Int, StopSec:Int, beats:[Beats_Type]) {
        
        audioProgress = 0
        
        let ExpressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
        
        let dbHAndler = DB_Local_Store()
        let Expression =  dbHAndler.readExpression(Em_Synth_id: DB_Table_Columns.DEFAULT_EM_SYNTH_ID, ByName :"Stand_Straight")
        let Straight_Aniamtion = ExpressionHelper.GetPlaneAnimation(json: Expression.Action_Data)
        
        var animationGroup:[AnimationEngineParameterGroup] = []
        
        if(AnimateEngine.IsHalfBlink)
        {
            animationGroup.append(ExpressionHelper.GetBlinkCorrectionStraight())
        }
        
        animationGroup.append(Straight_Aniamtion)
        
        animationGroup[0].Expressions[0].StartSec = -1
        
        if(beats.count > 0)
        {
         let arrayOfAnimations = ExpressionHelper.GetPlaneAnimationSetFromBeat(beats:beats)
        animationGroup.append(arrayOfAnimations)
       
            if(animationGroup.count > 1)
            {
                if(animationGroup[1].Expressions.count > 0)
                {
                    animationGroup[1].Expressions[0].audio = audio
                    
                    StopTime = Double(animationGroup[1].Expressions[animationGroup[1].Expressions.count-1].EndSec)/1000.0
                }
            }
        }
        else
        {
             animationGroup[0].Expressions[0].audio = audio
            animationGroup[0].Expressions[0].StartSec = StartSec
            StopTime = Double(StopSec)/1000
        }
        
        ClearBufferedData()
        self.InsertAnimationAt(PositionData: animationGroup, Index: 0)
        //EmptyBufferFromIndex(Index: animationGroup.count)
        
    
        //Restart animation state machine during job resume or when state machine finished
        if(self.STATE == JOB_STATE.NA || CurrentAnimationEngineState == AnimationEngineStates.NA)
        {
            self.STATE = JOB_STATE.INITIALIZED
            CurrentAnimationEngineState = AnimationEngineStates.SEND_MOTION_COMMAND
            Resume()
        }
        
        if(IsIDLE())
        {
            CurrentAnimationEngineState = AnimationEngineStates.SEND_MOTION_COMMAND;
            Resume();
        }
        
    }
}

