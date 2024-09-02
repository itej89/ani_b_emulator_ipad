//
//  BrowseEmotions.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 28/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Scheduler
import GraphicAnimation

public class BrowseAnimationsJob: AnimateEngine
{
    
    public override init() {
        
        super.init()
        ShouldAutoTerinateJob = false
        PRIORITY = JOB_PRIORITY.BROWSE_EMOTIONS
        
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
            let dbHAndler = DB_Local_Store()
            
            let Expression =  dbHAndler.readExpression(Em_Synth_id: DB_Table_Columns.DEFAULT_EM_SYNTH_ID, ByName :"Stand_Straight")
            
            self.requestToDoPlaneAnimation(json: Expression.Action_Data)
            
               AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json:  Expression.Action_Data.parseJSONString as! NSDictionary)
        }
        
    }
    
    open override func TakeOverResources(_delegate: JobConvey)
    {
        self.STATE = JOB_STATE.NA
        super.TakeOverEngineResources(_delegate: _delegate)
        TakeOverMotionGraphicResourcesAndInitializeEngine()
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
    
    open override func Pause() {
        STATE = JOB_STATE.PAUSED
        self.PauseEngine()
        //self.delegate.notify_Finish(ID: ID)
    }
    
    public func requestToDoPlaneAnimation(json:String) {
        
        let ExpressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
        
        let arrayOfAnimations = ExpressionHelper.GetPlaneAnimationWithMusic(json:json)
        
        var animationGroup:[AnimationEngineParameterGroup] = []
        
        if(AnimateEngine.IsHalfBlink)
        {
            animationGroup.append(ExpressionHelper.GetBlinkCorrectionStraight())
        }
        
        animationGroup.append(arrayOfAnimations)
        UpdateAnimationsToEngineBuffer(PositionData: animationGroup)
        
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
    
    public func requestToDoAnimation(json:String,MusicFile:String) {
        
        
        let ExpressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
        
        let arrayOfAnimations = ExpressionHelper.GetPlaneAnimationWithMusic(json:json, MusicFile: MusicFile)
        
        var animationGroup:[AnimationEngineParameterGroup] = []
        
        if(AnimateEngine.IsHalfBlink)
        {
            animationGroup.append(ExpressionHelper.GetBlinkCorrectionStraight())
        }
        
        
        animationGroup.append(arrayOfAnimations)
        UpdateAnimationsToEngineBuffer(PositionData: animationGroup)
        
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

