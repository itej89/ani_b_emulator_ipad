//
//  AnimateEngine.swift
//  Ani_AnimationStudio
//
//  Created by Uday on 11/06/17.
//  Copyright © 2017 Ani. All rights reserved.
//

import Foundation
import  UIKit
import SceneKit
import QuartzCore

import FourierMachines_Ani_Client_Scheduler
import  FourierMachines_Ani_Client_Articulation
import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_Kinetics

 open class AnimateEngine: Job, CAAnimationDelegate, AnimationActionCreatorConvey {
    
  
    
   public static let instance = AnimateEngine()
    
    
    public var GraphicNodes :[AnimationObject:SCNNode] = [:]
    
    
    
    
    public static var IsHalfBlink:Bool = false
    
    public var ShouldAutoTerinateJob:Bool = true;
    
    
    var notifyAfterAnimationFinished:Bool = false
    
    public var delChoreogramBinding:ChoreogramBindings? = nil
    var delNotifyAnimFinish:AnimationParameterTypeDelegates? = nil
    var delAnimationEngineConvey:AnimationEngineConvey? = nil
    
    
    var ImageAnimationSemaphore:Int = 0
    
    var MotorImageAnimationSemaphore:Int = 0
    
    
    public  enum AnimationEngineStates {
        case NA
        case SEND_MOTION_COMMAND
        case  SEND_TRIGGER
        case  START_ANIMATION
        case  SEND_NEXT_MOTION_COMMAND
        case  SEND_WAIT_TRIGGER
        case FINALIZE}
    
    
   public  var CurrentAnimationEngineState:AnimationEngineStates = AnimationEngineStates.NA
    
    
    //ExpressionBuffer contains a list of expressions (each expression is a list of  "grouped Animations" ex: Blink and strainght)
    var ExpressionBuffer:[AnimationEngineParameterGroup] = []
    var  ExpressionBufferParameterIndexer = 0;
    
    
    
    public static var Views:[AnimationObject: SCNNode] = [:]
    public static var Motors:[AnimationObject:SCNNode] = [:]
    
    
    public func EmptyExpressionBuffer()
{
    ExpressionBuffer.removeAll()
    ExpressionBufferParameterIndexer = 0;
    }
    
    public func ReadyEngineToResume()->Bool
{
    var Status:Bool = false
    if(ExpressionBuffer.count > 0)
    {
    if(ExpressionBufferParameterIndexer == 0)
    {
    Status = true;
    }
    else
    if(ExpressionBufferParameterIndexer > 0)
    {
    if(ExpressionBuffer[0].OnPauseAction == AnimationOnPauseRestartAction.DESTROY)
    {
    
    ExpressionBuffer.remove(at: 0)
    
    ExpressionBufferParameterIndexer = 0;
    if(ExpressionBuffer.count > 0)
    {
    Status = true;
    }
    }
    else
    if(ExpressionBuffer[0].OnPauseAction == AnimationOnPauseRestartAction.RESTART)
    {
    ExpressionBufferParameterIndexer = 0;
    Status = true;
    }
    }
    }
    
    if(!Status)
    {
    CurrentAnimationEngineState  = AnimationEngineStates.NA;
    }
    return Status;
    }
    
    
    
    public func GetCurrentExpressionParameterType()->AnimationEngineParameterType
{
    
    return ExpressionBuffer[0].Expressions[ExpressionBufferParameterIndexer]
    }
    
    public func GetCurrentAnimaitonPosition()->AnimationPositions!
    {
        return ExpressionBuffer[0].Expressions[ExpressionBufferParameterIndexer].animationPosition;
   
    }
    
    public func AreAllAnimationsFinished()->Bool
{
    
    if(EmptyBufferFromIndex && EmptyBufferIndex > 0)
    {
        while (ExpressionBuffer.count > EmptyBufferIndex)
        {
            ExpressionBuffer[EmptyBufferIndex].destroy()
            ExpressionBuffer.remove(at: EmptyBufferIndex)
        }
        
        EmptyBufferFromIndex = false;
        EmptyBufferIndex = -1;
    }
    
    if(ExpressionBuffer.count > 1 || (ExpressionBuffer.count == 1 && ExpressionBuffer[0].Expressions.count-1 > ExpressionBufferParameterIndexer))
    {
    return false;
    }
    return true;
    }
    
    public func IsIDLE()->Bool
    {
    if(CurrentAnimationEngineState == AnimationEngineStates.NA)
    {
    return  true;
    }
    
    return false;
    }
    
    public func IsFistExpressionAlreadyPerformed()->Bool
{
    if(ExpressionBuffer.count == 0) {
    return  false;
    }
    
    if (ExpressionBuffer[0].Expressions.count == 0) {
    
    return true;
    }
    
    
    return  false;
    }
    
    public func MoveAnimationParameterIndexUp()->Bool
{
    if(ExpressionBuffer.count > 0)
    {
    
    
    if(ExpressionBuffer[0].Expressions.count-1 > ExpressionBufferParameterIndexer)
    {
        ExpressionBufferParameterIndexer = ExpressionBufferParameterIndexer + 1;
    return true;
    }
    else
    {
 
    ExpressionBufferParameterIndexer = 0;
        ExpressionBuffer.remove( at: 0);
    
    
    if(ExpressionBuffer.count > 0)
    {
    return true;
    }
    else
    {
    return false;
    }
    }
    }
    else
    {
    return false;
    }
    }
    
    public func IsBufferEmpty()->Bool
{
    if(ExpressionBuffer.count > 0)
    {
    return false;
    }
    else
    {
    return true;
    }
    }
    
    public func IsBufferGoingEmpty()->Bool
{
    if(ExpressionBuffer.count > 2)
    {
    return false;
    }
    else
    {
    return true;
    }
    }
    
    public func InsertAnimationAt( PositionData:[AnimationEngineParameterGroup] ,Index:Int)
{
    
    for group in PositionData
    {
        for position in group.Expressions
        {
            
            position.animationPosition =  AnimationPositions()
            
            position.animationPosition.parseJson( json: position.Json)
            
            position.animationPosition.sentance = position.sentance
            
            position.animationPosition.audio = position.audio
            
            position.animationPosition.StartSec = position.StartSec
            
            position.animationPosition.EndSec = position.EndSec
        }
        
    }
    
    
    if(ExpressionBuffer.count > Index)
    {
        if(Index == 0)
        {
            ExpressionBufferParameterIndexer = 0
        }
        ExpressionBuffer.insert(contentsOf: PositionData, at: Index);
    }
    else
    {
        ExpressionBufferParameterIndexer = 0
        ExpressionBuffer.append(contentsOf:PositionData)
    }
    
    }
    
    public func PushImmediateAnimation(PositionData:[AnimationEngineParameterGroup])
{
    if(ExpressionBuffer.count > 0)
    {
    for group in PositionData
    {
    for position in group.Expressions
    {
    
    position.animationPosition =  AnimationPositions();
    
        position.animationPosition.parseJson(json: position.Json);
    
    position.animationPosition.sentance = position.sentance
    }
    
    }
    
        ExpressionBuffer.insert( contentsOf: PositionData,at: 0);
    }
    }
    
    
    public func UpdateAnimationsToEngineBuffer(PositionData:[AnimationEngineParameterGroup])
    {
    for group in PositionData
    {
        for position in group.Expressions
        {
            position.animationPosition =  AnimationPositions()
            
            position.animationPosition.parseJson(json: position.Json)
            position.animationPosition.sentance = position.sentance
            position.animationPosition.audio = position.audio
            position.animationPosition.StartSec = position.StartSec
            position.animationPosition.EndSec = position.EndSec
        }
        
        ExpressionBuffer.append(group)
    }
    }
    
    public var EmptyBufferFromIndex:Bool = false;
    public var EmptyBufferIndex:Int = -1;
    
    public func RemoveBufferedDataWithID(ID:UUID)
    {
        for i in 0..<ExpressionBuffer.count
        {
           if(ExpressionBuffer[i].AnimationGroupID == ID)
           {
            ExpressionBuffer.remove(at: i)
            break;
            }
        }
    }
    
    public func ClearBufferedData()
    {
       ExpressionBuffer.removeAll()
        ExpressionBufferParameterIndexer = 0
    }
    
    public func DisableEmptyBufferFromIndex()
    {
        EmptyBufferIndex = -1
        EmptyBufferFromIndex = false
    }
    
    public func EmptyBufferFromIndex(Index:Int)
    {
        EmptyBufferIndex = Index
        EmptyBufferFromIndex = true
    }
    //
    //    public void InitializeEngine(ArrayList<AnimationEngineParameterGroup> PositionData, Map<AnimationObject, View> _Views, ArrayList<AnimationObject> _Motors)
    //    {
    //
    //            UpdateAnimationsToEngineBuffer(PositionData);
    //
    //
    //        Views = _Views;
    //        Motors = _Motors;
    //
    //        CurrentAnimationEngineState  = AnimationEngineStates.SEND_MOTION_COMMAND;
    //
    //    
    
    public func InitializeEngine(PositionData:[AnimationEngineParameterGroup])
    {
    
    UpdateAnimationsToEngineBuffer(PositionData: PositionData)
    
    //Condition added for pause and resume case.. where index 0 animation is altready performed, but not removed from buffer
    while(IsFistExpressionAlreadyPerformed())
    {
        _ = MoveAnimationParameterIndexUp()
    }
    
    CurrentAnimationEngineState  = AnimationEngineStates.SEND_MOTION_COMMAND;
    
    }
    
    
    
    public func TakeOverEngineResources( _delegate:JobConvey) {
    
        super.TakeOverResources(_delegate: _delegate);
    }
    
    public func haltEngine() {
        
        CurrentAnimationEngineState = AnimationEngineStates.NA
    }
    
    public func PauseEngine() {
    
    GraphicNodes.removeAll()
    CurrentAnimationEngineState = AnimationEngineStates.NA
    super.Pause();
    }
    
    public func ResumeEngine() {
    DoSTEP();
    }

    
    func DoSTEP(){
    
    if(STATE == JOB_STATE.RUNNING)
    {
    
    switch(CurrentAnimationEngineState)
    {
    case AnimationEngineStates.SEND_MOTION_COMMAND:
    
        if (IsMotionCommandPresent(position: GetCurrentAnimaitonPosition()) == true)
        {
            switch (GetCurrentExpressionParameterType().TriggerType)
            {
                case MotionStartType.WAIT_AND_MOVE:
                    
                    DispatchQueue.background(background: {
                        while((self.MotorImageAnimationSemaphore > 0 || self.ImageAnimationSemaphore > 0) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                        {
                            usleep(10000)
                        }
                        if(self.GetCurrentAnimaitonPosition()!.audio == "")
                        {
                             while(self.delChoreogramBinding != nil && self.delChoreogramBinding!.ShouldWaitToTrigger(StartSec: self.GetCurrentAnimaitonPosition()!.StartSec) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                            {
                                usleep(10000)
                            }
                        }
                    }, completion:{
                        self.MotorImageAnimationSemaphore = 0;
                       
                        if(self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                        {
                             self.StartMotorMotion(Position: self.GetCurrentAnimaitonPosition())
                             self.CurrentAnimationEngineState = AnimationEngineStates.START_ANIMATION;
                             super.delegate.notify_NextStep(ID: self.ID);
                        }
                    })
                    
                    
                break
                
                case MotionStartType.INSTANT_MOVE:
                    DispatchQueue.background(background: {
                        if(self.GetCurrentAnimaitonPosition()!.audio == "")
                        {
                             while(self.delChoreogramBinding != nil && self.delChoreogramBinding!.ShouldWaitToTrigger(StartSec: self.GetCurrentAnimaitonPosition()!.StartSec) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                            {
                                usleep(10000)
                            }
                        }
                    }, completion:{
                        
                        self.MotorImageAnimationSemaphore = 0;
                        self.StartMotorMotion(Position: self.GetCurrentAnimaitonPosition())
                        self.CurrentAnimationEngineState = AnimationEngineStates.START_ANIMATION;
                        super.delegate.notify_NextStep(ID: self.ID);
                    })
                   
                break
            }
        }
        else
        {
            DispatchQueue.background(background: {
                while(self.ImageAnimationSemaphore > 0 && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                {
                    usleep(10000)
                }
                
                if(self.GetCurrentAnimaitonPosition()!.audio == "")
                {
                     while(self.delChoreogramBinding != nil && self.delChoreogramBinding!.ShouldWaitToTrigger(StartSec: self.GetCurrentAnimaitonPosition()!.StartSec) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                    {
                        usleep(10000)
                    }
                }
            }, completion:{
                self.ImageAnimationSemaphore = 0;
                
                self.CurrentAnimationEngineState = AnimationEngineStates.START_ANIMATION;
                if(self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                {
                    super.delegate.notify_NextStep(ID: self.ID);
                }
            })
        }
    
    break
        
        
    case AnimationEngineStates.START_ANIMATION:
        
        self.ImageAnimationSemaphore = 0;
    
    

    
    if( notifyAfterAnimationFinished )
    {
    if(delNotifyAnimFinish != nil)
    {
        delNotifyAnimFinish?.AnimationFinished();
    
    delNotifyAnimFinish = nil;
    }
    
    notifyAfterAnimationFinished = false;
    }
    
    AnimateEngine.IsHalfBlink = GetCurrentExpressionParameterType().IsHalfBlink;
    
    StartGraphicMotion(Position: GetCurrentAnimaitonPosition())
    
    if(GetCurrentAnimaitonPosition().sentance != ""){
        ArticulationManager.Instance.PlayWaveData(fileName: GetCurrentAnimaitonPosition().sentance,   Volume: 0.4,  FadeDuration: 1.2);
    }
        if(GetCurrentAnimaitonPosition().audio != ""){
            ArticulationManager.Instance.PlaySound(fileName: GetCurrentAnimaitonPosition().audio, StartSec: GetCurrentAnimaitonPosition().StartSec, EndSec: GetCurrentAnimaitonPosition().EndSec ,Volume: 0.4, FadeDuration: 1.2)
        }
    
    if (GetCurrentExpressionParameterType().delegate != nil) {
    notifyAfterAnimationFinished = true;
    delNotifyAnimFinish = GetCurrentExpressionParameterType().delegate;
    }
    else
    {
    notifyAfterAnimationFinished = false;
    delNotifyAnimFinish = nil;
    }
    
    
        if (AreAllAnimationsFinished()) {
            
            CurrentAnimationEngineState = AnimationEngineStates.FINALIZE;
        } else {
            CurrentAnimationEngineState = AnimationEngineStates.SEND_NEXT_MOTION_COMMAND;
            
            _ = MoveAnimationParameterIndexUp();
        }
    
    
    if (CurrentAnimationEngineState == AnimationEngineStates.SEND_NEXT_MOTION_COMMAND) {
        super.delegate.notify_NextStep(ID: ID);
    }
        else
         if (CurrentAnimationEngineState == AnimationEngineStates.FINALIZE)
    {
        DispatchQueue.background(background: {
            while((self.MotorImageAnimationSemaphore > 0 || self.ImageAnimationSemaphore > 0) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
            {
                usleep(10000)
            }
            
        }, completion:{
            if(self.CurrentAnimationEngineState != AnimationEngineStates.NA)
            {
                super.delegate.notify_NextStep(ID: self.ID);
            }
        })
        
        }
    
    
    break
    case  AnimationEngineStates.SEND_NEXT_MOTION_COMMAND:
        if (IsMotionCommandPresent(position: GetCurrentAnimaitonPosition()) == true)
    {
    
        switch (GetCurrentExpressionParameterType().TriggerType)
        {
        case MotionStartType.WAIT_AND_MOVE:
        
            DispatchQueue.background(background: {
                while((self.MotorImageAnimationSemaphore > 0 || self.ImageAnimationSemaphore > 0) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                {
                    usleep(10000)
                }
                if(self.GetCurrentAnimaitonPosition()!.audio == "")
                {
                    while(self.delChoreogramBinding != nil && self.delChoreogramBinding!.ShouldWaitToTrigger(StartSec: self.GetCurrentAnimaitonPosition()!.StartSec) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                    {
                        usleep(10000)
                    }
                }
            }, completion:{
                
                self.MotorImageAnimationSemaphore = 0;
               
                if(self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                {
                     self.StartMotorMotion(Position: self.GetCurrentAnimaitonPosition())
                    self.CurrentAnimationEngineState = AnimationEngineStates.START_ANIMATION;
                    super.delegate.notify_NextStep(ID: self.ID);
                }
               
            })
            
            
            break
            
        case MotionStartType.INSTANT_MOVE:
            
            DispatchQueue.background(background: {
                if(self.GetCurrentAnimaitonPosition()!.audio == "")
                {
                    while(self.delChoreogramBinding != nil && self.delChoreogramBinding!.ShouldWaitToTrigger(StartSec: self.GetCurrentAnimaitonPosition()!.StartSec) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                    {
                        usleep(10000)
                    }
                }
            }, completion:{
                
                self.MotorImageAnimationSemaphore = 0;
                self.StartMotorMotion(Position: self.GetCurrentAnimaitonPosition())
                self.CurrentAnimationEngineState = AnimationEngineStates.START_ANIMATION;
                super.delegate.notify_NextStep(ID: self.ID);
                
            })
            
            break
        }
        
    }
        else
        {
            DispatchQueue.background(background: {
                while(self.ImageAnimationSemaphore > 0)
                {
                    usleep(10000)
                }
                if(self.GetCurrentAnimaitonPosition()!.audio == "")
                {
                     while(self.delChoreogramBinding != nil && self.delChoreogramBinding!.ShouldWaitToTrigger(StartSec: self.GetCurrentAnimaitonPosition()!.StartSec) && self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                    {
                        usleep(10000)
                    }
                }
            }, completion:{
                self.ImageAnimationSemaphore = 0;
                if(self.CurrentAnimationEngineState != AnimationEngineStates.NA)
                {
                self.CurrentAnimationEngineState = AnimationEngineStates.START_ANIMATION;
                super.delegate.notify_NextStep(ID: self.ID);
                }
            })
        }
        
    
    break

    
    
    case AnimationEngineStates.FINALIZE:
    
    if (AreAllAnimationsFinished()) {
        _ = MoveAnimationParameterIndexUp();
    CurrentAnimationEngineState = AnimationEngineStates.NA;
    if (ShouldAutoTerinateJob) {
        super.delegate.notify_Finish(ID: ID);
    if(delAnimationEngineConvey != nil)
    {
        delAnimationEngineConvey?.AnimationEngineFinalized();
    }
    }
    
    if( notifyAfterAnimationFinished )
    {
    if(delNotifyAnimFinish != nil)
    {
        delNotifyAnimFinish?.AnimationFinished();
    
    delNotifyAnimFinish = nil;
    }
    
    notifyAfterAnimationFinished = false;
    }
    }
    else
    {
        CurrentAnimationEngineState = AnimationEngineStates.SEND_MOTION_COMMAND;
        DoSTEP()
    }
    break;
        
    default:
    break;
    
    }
    }
    }
    
    public func StartMotorMotion(Position:AnimationPositions)
    {
        AnimateMotor(Position: Position,Tag: AnimationObject.Motor_Turn, image: GraphicNodes[AnimationObject.Motor_Turn_Graphic]!, IsNoOverlay: true)
        AnimateMotor(Position: Position,Tag: AnimationObject.Motor_Lean, image: GraphicNodes[AnimationObject.Motor_Lean_Graphic]!, IsNoOverlay: true)
        AnimateMotor(Position: Position,Tag: AnimationObject.Motor_Lift, image: GraphicNodes[AnimationObject.Motor_Lift_Graphic]!, IsNoOverlay: true)
        AnimateMotor(Position: Position,Tag: AnimationObject.Motor_Tilt, image: GraphicNodes[AnimationObject.Motor_Tilt_Graphic]!, IsNoOverlay: true)
    }
    
    public func StartGraphicMotion(Position:AnimationPositions)
    {
        Animate(Position: Position,Tag: AnimationObject.Image_EyeBrowLeft, image: GraphicNodes[AnimationObject.Image_EyeBrowLeft]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyeLidLeft, image: GraphicNodes[AnimationObject.Image_EyeLidLeft]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyeLeft, image: GraphicNodes[AnimationObject.Image_EyeLeft]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyeBallLeft, image: GraphicNodes[AnimationObject.Image_EyeBallLeft]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyePupilLeft, image: GraphicNodes[AnimationObject.Image_EyePupilLeft]!)
        
        Animate(Position: Position,Tag: AnimationObject.Image_EyeBrowRight, image: GraphicNodes[AnimationObject.Image_EyeBrowRight]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyeLidRight, image: GraphicNodes[AnimationObject.Image_EyeLidRight]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyeRight, image: GraphicNodes[AnimationObject.Image_EyeRight]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyeBallRight, image: GraphicNodes[AnimationObject.Image_EyeBallRight]!)
        Animate(Position: Position,Tag: AnimationObject.Image_EyePupilRight, image: GraphicNodes[AnimationObject.Image_EyePupilRight]!)
        
    }
    
    public  func AnimateMotor(Position:AnimationPositions,Tag: AnimationObject, image : SCNNode,IsNoOverlay:Bool)
    {
        
        let MotionEaseTime:Float = 0.15
        let EaseStepTime:Float = 0.05
        
        if((Position.State.StateSet[Tag] as! MotorAnimationState).Angle.values.first == true)
        {
            MotorImageAnimationSemaphore = MotorImageAnimationSemaphore+1
            let Angle = (Position.State.StateSet[Tag] as! MotorAnimationState).Angle.keys.first!
            
            
            
            let Timing =  Float((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Timing) / 1000.0
            
            let Delay =  Float((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Delay) / 1000.0
            
            let Frequency =  Float((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Frequency)
            
            let Damping =  Float((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Damp)
            
            let Velocity =  Float((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).Velocity)
            
            
            let EasingFunction:CommandHelper.EasingFunction = ((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).EasingFunction)
            
            let EasingType:CommandHelper.EasingType = ((Position.Transition.TransitionSet[Tag] as! MotionAnimationTransition).EasingType)
            
            var EasingModule = EasingBase()
            switch(EasingFunction)
            {
            case .SIN:
                EasingModule = SineEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .QAD:
                EasingModule = QuadraticEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .LIN:
                EasingModule = LinearEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .EXP:
                EasingModule = ExponentialEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .ELA:
                EasingModule = ElasticEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .CIR:
                EasingModule = CircularEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .BOU:
                EasingModule = BounceEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .BAK:
                EasingModule = BackEase()
                EasingModule.setDuration(duration_: Double(Timing * 1000))
                break
            case .TRI:
                EasingModule = TriangularEase()
                EasingModule.setDuration(duration_: Double(Frequency))
                break
            case .TRW:
                EasingModule = TriangularWaveEase()
                EasingModule.setDuration(duration_: Double(Frequency))
                break
            case .SNW:
                EasingModule = SineWaveEase()
                EasingModule.setDuration(duration_: Double(Frequency))
                break
            case .SPR:
                EasingModule = SpringWaveEase()
                EasingModule.setDuration(duration_: Double(Frequency))
                EasingModule.setTotalDuration(totalduration_: Double(Timing * 1000))
                EasingModule.setSpringWaveDamping(damping_: Double(Damping))
                EasingModule.setSpringWaveVelocity(velocity_: Double(Velocity))
                break
            }
            
            
        
            
            
            var oldTransform = image.transform
            if(IsNoOverlay)
            {
                oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
            }
            
            
            
            if(Tag == AnimationObject.Motor_Turn)
            {
                let InitialAngle = FMUnitConvertor.RadiasToDegree(radians: image.eulerAngles.y)
                let DeltaAngle = abs(Angle - Int(InitialAngle))
                EasingModule.setTotalChangeInPosition(totalChangeInPosition_: Double(DeltaAngle))
                var FinalAngle = InitialAngle;
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Delay)) {
                    
                    var startTime: Double = 0
                    var time: Double = 0
                    var EasingTimer:Timer!
                    startTime = Date().timeIntervalSinceReferenceDate //seconds in double
                    
                    EasingTimer =  Timer.scheduledTimer(withTimeInterval: TimeInterval(EaseStepTime), repeats: true) {_ in
                        
                        time = Date().timeIntervalSinceReferenceDate - startTime //seconds in double
                        
                        if(time > Double(Timing))
                        {
                            self.MotorAnimationComleted()
                            EasingTimer.invalidate()
                            return
                        }
                        else
                        {
                            time = time * 1000
                            var easeAngle = EasingModule.easeIn(time_: time);
                            switch(EasingType)
                            {
                            case .IN:
                                break
                            case .OU:
                                easeAngle = EasingModule.easeOut(time_: time);
                                break
                            case .IO:
                                easeAngle = EasingModule.easeInOut(time_: time);
                                break
                            }
                            
                            if(Int(FinalAngle) < Angle){
                                FinalAngle = Float((Double(InitialAngle) + easeAngle));
                                let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                let rotation = SCNMatrix4MakeRotation(radAngle,0, 1, 0)
                                
                                oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                
                                
                                oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                
                                SCNTransaction.begin()
                                SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                SCNTransaction.completionBlock =  {
                                }
                                image.transform = oldTransform
                                SCNTransaction.commit()
                                
                            }
                            else
                                if(Int(FinalAngle) > Angle){
                                    FinalAngle = Float(Double(InitialAngle) - easeAngle);
                                    let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                    let rotation = SCNMatrix4MakeRotation(radAngle,0, 1, 0)
                                    
                                    // oldTransform = image.transform
                                    oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                    
                                    oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                    
                                    SCNTransaction.begin()
                                    SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                    SCNTransaction.completionBlock =  {
                                    }
                                    image.transform = oldTransform
                                    SCNTransaction.commit()
                                    
                            }
                            
                            
                        }
                        
                    }
                    
                }
            }
            if(Tag == AnimationObject.Motor_Lift)
            {
                let InitialAngle =  -1 * FMUnitConvertor.RadiasToDegree(radians: image.eulerAngles.z)
                let DeltaAngle = abs(Angle - Int(InitialAngle))
                EasingModule.setTotalChangeInPosition(totalChangeInPosition_: Double(DeltaAngle))
                var FinalAngle = InitialAngle;
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Delay)) {
                    
                    var startTime: Double = 0
                    var time: Double = 0
                    var EasingTimer:Timer!
                    startTime = Date().timeIntervalSinceReferenceDate //seconds in double
                    
                    EasingTimer =  Timer.scheduledTimer(withTimeInterval: TimeInterval(EaseStepTime), repeats: true) {_ in
                        
                        time = Date().timeIntervalSinceReferenceDate - startTime //seconds in double
                        
                        if(time > Double(Timing))
                        {
                            self.MotorAnimationComleted()
                            EasingTimer.invalidate()
                            return
                        }
                        else
                        {
                            time = time * 1000
                            var easeAngle = EasingModule.easeIn(time_: time);
                            
                            switch(EasingType)
                            {
                            case .IN:
                                break
                            case .OU:
                                easeAngle = EasingModule.easeOut(time_: time);
                                break
                            case .IO:
                                easeAngle = EasingModule.easeInOut(time_: time);
                                break
                            }
                            
                            if(Int(FinalAngle) < Angle){
                                FinalAngle = Float((Double(InitialAngle) + easeAngle));
                                
                                let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
                                
                                oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                
                                oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                
                                SCNTransaction.begin()
                                SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                SCNTransaction.completionBlock =  {
                                }
                                image.transform = oldTransform
                                SCNTransaction.commit()
                                
                            }
                            else
                                if(Int(FinalAngle) > Angle){
                                    
                                    FinalAngle = Float(Double(InitialAngle) - easeAngle);
                                    let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                    let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
                                    
                                    // oldTransform = image.transform
                                    oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                    
                                    oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                    
                                    SCNTransaction.begin()
                                    SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                    SCNTransaction.completionBlock =  {
                                    }
                                    image.transform = oldTransform
                                    SCNTransaction.commit()
                                    
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            if(Tag == AnimationObject.Motor_Lean)
            {
                let InitialAngle =  -1 * FMUnitConvertor.RadiasToDegree(radians: image.eulerAngles.z)
                let DeltaAngle = abs(Angle - Int(InitialAngle))
                EasingModule.setTotalChangeInPosition(totalChangeInPosition_: Double(DeltaAngle))
                var FinalAngle = InitialAngle;
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Delay)) {
                    
                    var startTime: Double = 0
                    var time: Double = 0
                    var EasingTimer:Timer!
                    startTime = Date().timeIntervalSinceReferenceDate //seconds in double
                    
                    EasingTimer =  Timer.scheduledTimer(withTimeInterval: TimeInterval(EaseStepTime), repeats: true) {_ in
                        
                        time = Date().timeIntervalSinceReferenceDate - startTime //seconds in double
                        
                        if(time > Double(Timing))
                        {
                            self.MotorAnimationComleted()
                            EasingTimer.invalidate()
                            return
                        }
                        else
                        {
                            time = time * 1000
                            var easeAngle = EasingModule.easeIn(time_: time);
                           
                            switch(EasingType)
                            {
                            case .IN:
                                break
                            case .OU:
                                easeAngle = EasingModule.easeOut(time_: time);
                                break
                            case .IO:
                                easeAngle = EasingModule.easeInOut(time_: time);
                                break
                            }
                            
                            if(Int(FinalAngle) < Angle){
                                FinalAngle = Float((Double(InitialAngle) + easeAngle));
                                let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
                                
                                oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                
                                
                                oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                
                                SCNTransaction.begin()
                                SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                SCNTransaction.completionBlock =  {
                                }
                                image.transform = oldTransform
                                SCNTransaction.commit()
                                
                            }
                            else
                                if(Int(FinalAngle) > Angle){
                                    FinalAngle = Float(Double(InitialAngle) - easeAngle);
                                  
                                       
                                    
                                    let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                    let rotation = SCNMatrix4MakeRotation(-1*radAngle,0, 0, 1)
                                    
                                    // oldTransform = image.transform
                                    oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                    
                                    oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                    
                                    SCNTransaction.begin()
                                    SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                    SCNTransaction.completionBlock =  {
                                    }
                                    image.transform = oldTransform
                                    SCNTransaction.commit()
                                    
                            }
                            
                            
                        }
                        
                    }
                    
                }
            }
                
            
            if(Tag == AnimationObject.Motor_Tilt)
            {
                let InitialAngle =   FMUnitConvertor.RadiasToDegree(radians: image.eulerAngles.x)
                let DeltaAngle = abs(Angle - Int(InitialAngle))
                EasingModule.setTotalChangeInPosition(totalChangeInPosition_: Double(DeltaAngle))
                var FinalAngle = InitialAngle;
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Delay)) {
                    
                    var startTime: Double = 0
                    var time: Double = 0
                    var EasingTimer:Timer!
                    startTime = Date().timeIntervalSinceReferenceDate //seconds in double
                    
                    EasingTimer =  Timer.scheduledTimer(withTimeInterval: TimeInterval(EaseStepTime), repeats: true) {_ in
                        
                        time = Date().timeIntervalSinceReferenceDate - startTime //seconds in double
                        
                        if(time > Double(Timing))
                        {
                            self.MotorAnimationComleted()
                            EasingTimer.invalidate()
                            return
                        }
                        else
                        {
                            time = time * 1000
                            var easeAngle = EasingModule.easeIn(time_: time);
                            switch(EasingType)
                            {
                            case .IN:
                                break
                            case .OU:
                                easeAngle = EasingModule.easeOut(time_: time);
                                break
                            case .IO:
                                easeAngle = EasingModule.easeInOut(time_: time);
                                break
                            }
                            
                            if(Int(FinalAngle) < Angle){
                                FinalAngle = Float((Double(InitialAngle) + easeAngle));
                                let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                let rotation = SCNMatrix4MakeRotation(radAngle,1, 0, 0)
                                
                                oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                
                                
                                oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                
                                SCNTransaction.begin()
                                SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                SCNTransaction.completionBlock =  {
                                }
                                image.transform = oldTransform
                                SCNTransaction.commit()
                                
                            }
                            else
                                if(Int(FinalAngle) > Angle){
                                    FinalAngle = Float(Double(InitialAngle) - easeAngle);
                                    let radAngle = FMUnitConvertor.DegreeToRadians(degree: Int(FinalAngle))
                                    let rotation = SCNMatrix4MakeRotation(radAngle,1, 0, 0)
                                    
                                    // oldTransform = image.transform
                                    oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                                    
                                    oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                                    
                                    SCNTransaction.begin()
                                    SCNTransaction.animationDuration = CFTimeInterval(MotionEaseTime)
                                    SCNTransaction.completionBlock =  {
                                    }
                                    image.transform = oldTransform
                                    SCNTransaction.commit()
                                    
                            }
                            
                            
                        }
                        
                    }
                    
                }
            }
        }

            
        }
            
        
    
    
    public  func Animate(Position:AnimationPositions,Tag: AnimationObject, image : SCNNode) {
      //  let Tag =  AnimationObject(rawValue: image.tag)
        
       
        
        let transition = (Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition)
        
        _ = transition.AnimationCurveType
        
        let Timing =  Float((Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).Duration) / 1000.0
        
        let Delay =  Float((Position.Transition.TransitionSet[Tag] as! ImageAnimationTransition).Delay) / 1000.0
        
        
      
        
//
//        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorX.values.first ?? false && (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorY.values.first ?? false){
//
//            image.pivot = SCNMatrix4MakeTranslation(Float((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorX.keys.first!), Float((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).AnchorY.keys.first!), 0);
//
//
//        }
    
       
        
     
        var IsTransformed = false
        var IsCircularPath = false
        var IsIdentity = false
        var IsTransformOverlay = false
        
     
        if((Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.Tranformation){
            if((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty.values.first!  )
         {
            
            IsTransformed = true
            //AnimationActionCreator.instance.SetDefault(gTag: Tag, image: image)
         }
        }
        if((Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.TransformOverlay){
            if((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx.values.first! && (Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty.values.first!  )
            {
                
                IsTransformOverlay = true
                //AnimationActionCreator.instance.SetDefault(gTag: Tag, image: image)
            }
        }
        if((Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.CircularPath){
                
                IsCircularPath = true
            //AnimationActionCreator.instance.SetDefault(gTag: Tag, image: image)
        }
        
        if((Position.State.StateSet[Tag] as! ImageAnimationState).AnimationKind == AnimationType.Identity){
            
            IsIdentity = true
        }
         //DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
    
        if(IsTransformed || IsIdentity || IsCircularPath || IsTransformOverlay)
        {
            ImageAnimationSemaphore = ImageAnimationSemaphore+1
        }
        
            
        if(IsTransformed || IsIdentity || IsTransformOverlay)
        {
      
                        
                        if(IsTransformed)
                        {
                            var ImageOpacity = image.opacity
                            
                        if((Position.State.StateSet[Tag] as! ImageAnimationState).opacity.values.first)!{
                            
                            
                            ImageOpacity = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).opacity.keys.first!)
                            
                        }
                        
//                        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.values.first)!{
//
//
//                            image.center.x = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.keys.first!)
//
//                        }
//
//
//                        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.values.first)!{
//
//
//                            image.center.y = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.keys.first!)
//
//                        }
                        
                            var transform:CGAffineTransform = CGAffineTransform();
                            
                            transform.a = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a.keys.first!)
                            
                            transform.b = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b.keys.first!)
                            
                            transform.c = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c.keys.first!)
                            
                            transform.d = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d.keys.first!)
                            
                            transform.tx = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx.keys.first!)
                            
                            transform.ty = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty.keys.first!)
                            
                            
                            
                            let transform2D:TransformValues = TransformMatrixToValueConvertor.GetValuesFromMatrix(Transform: transform);
                     
                            var oldTransform = image.transform
                            
                           
                            let rotation = SCNMatrix4MakeRotation(Float(transform2D.RotationInRadians),1, 0, 0)
                            oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                            let scale = SCNMatrix4Scale(oldTransform, 1, Float(transform2D.ScaleY), Float(transform2D.ScaleX))
                            let ty = (Float(transform2D.Ty))/100
                            let tx = (Float(transform2D.Tx))/100
                            let trasnlate = SCNMatrix4Translate(scale, 0, -1*ty, -1*tx)
                            
                            Timer.scheduledTimer(withTimeInterval: TimeInterval(Delay), repeats: false) {_ in
                            
                            SCNTransaction.begin()
                            SCNTransaction.animationDuration = CFTimeInterval(Timing)
                            SCNTransaction.completionBlock =  {
                                self.AnimationComleted()
                            }
                            image.transform = trasnlate
                            image.opacity = ImageOpacity
                            SCNTransaction.commit()
                            
                            }
                            
                            
                        
                        
                        
        }else
        if(IsTransformOverlay)
            {
                var ImageOpacity = image.opacity
                
                if((Position.State.StateSet[Tag] as! ImageAnimationState).opacity.values.first)!{
                    
                    
                    ImageOpacity = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).opacity.keys.first!)
                    
                }
                
                //                        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.values.first)!{
                //
                //
                //                            image.center.x = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreX.keys.first!)
                //
                //                        }
                //
                //
                //                        if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.values.first)!{
                //
                //
                //                            image.center.y = CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag] as! ImageAnimationState).centreY.keys.first!)
                //
                //                        }
                
                
                var transform:CGAffineTransform = CGAffineTransform();
                
                transform.a = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.a.keys.first!)
                
                transform.b = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.b.keys.first!)
                
                transform.c = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.c.keys.first!)
                
                transform.d = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.d.keys.first!)
                
                transform.tx = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.tx.keys.first!)
                
                transform.ty = CGFloat((Position.State.StateSet[Tag] as! ImageAnimationState).Matrix.ty.keys.first!)
                
                
                let transform2D:TransformValues = TransformMatrixToValueConvertor.GetValuesFromMatrix(Transform: transform);
                var oldTransform = image.transform
                oldTransform = AnimationActionCreator.instance.GetDefaultTransform(gTag: Tag, image: image)
                
                
                let rotation = SCNMatrix4MakeRotation(Float(transform2D.RotationInRadians),1, 0, 0)
                oldTransform = SCNMatrix4Mult(rotation, oldTransform)
                let scale = SCNMatrix4Scale(oldTransform, 1, Float(transform2D.ScaleY), Float(transform2D.ScaleX))
                let ty = (Float(transform2D.Ty))/100
                let tx = (Float(transform2D.Tx))/100
                let trasnlate = SCNMatrix4Translate(scale, 0, -1*ty, -1*tx)
                
                
                var TimingFunction:CAMediaTimingFunction = CAMediaTimingFunction(name: .default)
                
                switch(transition.KeyframeAnimation_EasingFunction)
                {
                    case .linear:
                        TimingFunction = CAMediaTimingFunction(name: .linear)
                    break
                case .easeIN:
                    TimingFunction = CAMediaTimingFunction(name: .easeIn)
                    break
                case .easeOut:
                    TimingFunction = CAMediaTimingFunction(name: .easeOut)
                    break
                case .easeInOut:
                    TimingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                    break
                }
                
                
                Timer.scheduledTimer(withTimeInterval: TimeInterval(Delay), repeats: false) {_ in
                    
                    
                    SCNTransaction.begin()
                    SCNTransaction.animationTimingFunction = TimingFunction
                    SCNTransaction.animationDuration = CFTimeInterval(Timing)
                    SCNTransaction.completionBlock =  {
                        self.AnimationComleted()
                    }
                    image.transform = trasnlate
                    image.opacity = ImageOpacity
                    SCNTransaction.commit()
                    
                }
                
            }
        else if(IsIdentity == true)
        {
            AnimationActionCreator.instance.SetDefault(gTag: Tag, image: image, convey: self, Timing: Int(Timing), Delay: Int(Delay))
        }
                        
        
        }
            else if(IsCircularPath)
                       {
//                            var Direction = true
//                            if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.Direction.keys.first! == CircularPathDirection.clockwise)
//                            {
//                                Direction = true
//                            }
//                            else  if((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.Direction.keys.first! == CircularPathDirection.anitiClockwise)
//                            {
//                                Direction = false
//                            }
//
//
//
//
//                            let circlePath = UIBezierPath(arcCenter: CGPoint(x: (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.MidX.keys.first!, y: (AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.MidY.keys.first!), radius: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.Radius.keys.first!), startAngle: CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.StartAngle.keys.first!)*(CGFloat(Double.pi)/180), endAngle:CGFloat((AnimationActionCreator.instance.CurrentAnimation.Position.State.StateSet[Tag!] as! ImageAnimationState).CircularPath.EndAngle.keys.first!)*(CGFloat(Double.pi)/180), clockwise: Direction)
//
//                            let animation = CAKeyframeAnimation(keyPath: "position");
//                            animation.delegate = self
//                        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(Delay)
//                            animation.duration = CFTimeInterval(Timing)
//                            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: AnimationEasingTypesToCAMediaTimingFunction[(AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag!] as! ImageAnimationTransition).KeyframeAnimation_EasingFunction]!))
//                            animation.fillMode = CAMediaTimingFillMode(rawValue: AnimationFillModesToCGPathFillMode[(AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[Tag!] as! ImageAnimationTransition).KeyframeAnimation_FillMode]!)
//                            animation.path = circlePath.cgPath
//
//                             image.layer.add(animation, forKey: nil)
                       }
        
        
    
    }
    
    //AnimationActionCreatorConvey
    public func SetDefaultCompleted(Tag: AnimationObject) {
        AnimationComleted()
    }
    //End of AnimationActionCreatorConvey
    
    public func MotorAnimationComleted()
    {
        MotorImageAnimationSemaphore = MotorImageAnimationSemaphore-1;
        
       // ExecuteNextMotorAnimComplete();
    }
    public func ExecuteNextMotorAnimComplete()
    {
        if(MotorImageAnimationSemaphore == 0){
            if(CurrentAnimationEngineState == AnimationEngineStates.SEND_TRIGGER || CurrentAnimationEngineState == AnimationEngineStates.START_ANIMATION)
            {
                super.delegate.notify_NextStep(ID: ID)
            }
        }
    }
    
   
    
    public func AnimationComleted()
    {
        ImageAnimationSemaphore = ImageAnimationSemaphore-1;
        
       // ExecuteNextAnimComplete();
    }
 
    
    public func ExecuteNextAnimComplete()
    {
    if(ImageAnimationSemaphore == 0){
        super.delegate.notify_NextStep(ID: ID);
    }
    }
    
  
    
    
    func IsMotionCommandPresent( position:AnimationPositions)->Bool {
        if((position.State.StateSet[AnimationObject.Motor_Turn] as! MotorAnimationState).Angle.values.first == true ||
    (position.State.StateSet[AnimationObject.Motor_Lift] as! MotorAnimationState).Angle.values.first == true ||
    (position.State.StateSet[AnimationObject.Motor_Lean] as! MotorAnimationState).Angle.values.first == true ||
    (position.State.StateSet[AnimationObject.Motor_Tilt] as! MotorAnimationState).Angle.values.first == true)
    {
    return true;
    }
    else{
    return false;
    }
    }
    
   
    
    
   
    
}

extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
