//
//  IDLEAnimationJob.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 16/06/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Scheduler
import GraphicAnimation

public class IDLEAnimationJob: AnimateEngine,AnimationParameterTypeDelegates
{
    
    var AnimationTimer:Timer!
    var ActivePeriod = 0 //InSTEPS_OF 1 Sec
    var SLEEP_TIMEOUT = 10 //GO TO Sleep After 60 seconds
    var Animation_Sleep_Buffer:[AnimationEngineParameterGroup] = []
    var NAPID:UUID = UUID()

    var IsJobResumedFirstTime:Bool = true;
    
    public override init() {
        
        super.init()
        ShouldAutoTerinateJob = false
        InitializeAnimationBuffer()
        PRIORITY = JOB_PRIORITY.LIVE
        
    }
    
    func InitializeAnimationBuffer()
    {
        
        RemoveBufferedDataWithID(ID:NAPID)
        DisableEmptyBufferFromIndex()
      
        if(self.IsBufferGoingEmpty())
        {
        var DefaultSetOfAnimationsGroups:[AnimationEngineParameterGroup] = []
        
        for _ in 0...5
        {
            let json = self.GetRandomNoAttentionAnimation()
            let expressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
            DefaultSetOfAnimationsGroups.append(expressionHelper.GetAnimationEngineParameterTypesTimeStretchedWithBlinkAndStraight(json: json))
        }
        
        
        self.UpdateAnimationsToEngineBuffer(PositionData: DefaultSetOfAnimationsGroups)
        }
    }
    
    func AnimationTimerTick()
    {
        ActivePeriod = ActivePeriod+1
        if(SLEEP_TIMEOUT <= ActivePeriod)
        {
            AnimationTimer!.invalidate()
            let expressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
            let napAnimation = expressionHelper.GetNapAnimation(delegate: self)
            NAPID = napAnimation.AnimationGroupID
            self.InsertAnimationAt(PositionData: [napAnimation], Index: 1)
            //Remove all animation which are on top of nap animation
            EmptyBufferFromIndex(Index: 2)
        }
        else
        if(self.IsBufferGoingEmpty())
        {
            let json = self.GetRandomNoAttentionAnimation()
            let expressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
            self.UpdateAnimationsToEngineBuffer(PositionData: [expressionHelper.GetAnimationEngineParameterTypesTimeStretchedWithBlinkAndStraight(json: json)])
        }
    }
    
    
    func GetRandomNoAttentionAnimation()->String
    {
        let NoAttention_Animations = ["gotdown_lookrightup_thinking", "gotdown_lookleftup_thinking", "gotdown_lookrightdown_thinking", "gotdown_lookleftdown_thinking", "look_right", "look_left", "focus_leftdown", "focus_rightdown", "focus_leftup", "think_leftup", "look_rightup"]
        
        let index = Int(arc4random_uniform(UInt32(NoAttention_Animations.count)))
        //let index = 1
        
        let dbHAndler = DB_Local_Store()
        
        let Expression =  dbHAndler.readExpression(Em_Synth_id: DB_Table_Columns.DEFAULT_EM_SYNTH_ID, ByName :NoAttention_Animations[index])
        
        return Expression.Action_Data
    }
    
    func TakeOverMotionGraphicResourcesAndInitializeEngine()
    {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async(group:group) {
                self.GraphicNodes =  UIMAINModuleHandler.Instance.AniUIHandler.GetAllUIElements()
            group.leave()
        }
        
       
        // does not wait. But the code in notify() gets run
        // after enter() and leave() calls are balanced
        group.notify(queue: .main) {
            
            self.InitializeEngine(PositionData: [])
            self.InitializeAnimationBuffer()
            
            //Runs only First time Job was initiliazed
            if(self.STATE == JOB_STATE.NA)
            {
                
                let expressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
                
                //coometed to avoid wrong overlapping transforms
               if(AnimateEngine.IsHalfBlink)
               {
                    self.PushImmediateAnimation(PositionData: [expressionHelper.GetBlinkCorrectionStraight()])
                }
                self.STATE = JOB_STATE.INITIALIZED
                self.CurrentAnimationEngineState = .SEND_MOTION_COMMAND
                self.Resume()
            }
            
        }
        
    }
    
    open override func TakeOverResources(_delegate: JobConvey)
    {
        self.STATE = JOB_STATE.NA
        ActivePeriod = 0
        super.TakeOverEngineResources(_delegate: _delegate)
        TakeOverMotionGraphicResourcesAndInitializeEngine()
    }
    
    open override func Resume() {
        
        if(STATE == JOB_STATE.INITIALIZED)
        {
            if(self.ReadyEngineToResume()){
                AnimationTimer?.invalidate()
                AnimationTimer  = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                _ in self.AnimationTimerTick()}
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
        AnimationTimer?.invalidate()
        self.PauseEngine()
    }
    
    
    //AnimationParameterTypeDelegates
    public func AnimationFinished() {
        //Pause()
    }
    //End of AnimationParameterTypeDelegates
}
