//
//  AnimationExpressionHelper.swift
//  GraphicAnimation
//
//  Created by Tej Kiran on 28/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Kinetics

public class AnimationExpressionHelper
{
    public var EM_SYNTH_ID:Int
    public init(Em_Synth_ID:Int = DB_Table_Columns.DEFAULT_EM_SYNTH_ID){
        EM_SYNTH_ID = Em_Synth_ID
    }
    
    
    
    
    public func GetNapGraphicOnlyAnimation(delegate: AnimationParameterTypeDelegates) -> AnimationEngineParameterGroup
    {
        let dbHAndler = DB_Local_Store()
        
        let napExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"nap")
        
        let napJsonMsgObject:NSMutableDictionary! =    (napExpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        let napAnimation = AnimationEngineParameterType()
        napAnimation.Json = napJsonMsgObject
        
        //Diable Motor Commands
        ((((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        
        //Set Graphic Animation Duration
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((napAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        animationEngineParameterGroup.Expressions = [napAnimation]
        
        return animationEngineParameterGroup
    }
    
    public func GetPlaneAnimationSetFromBeat(beats:[Beats_Type])->AnimationEngineParameterGroup
    {
        
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
         animationEngineParameterGroup.Expressions = []
        
        for beat in beats
        {
            let json = beat.Action_Data!
            
            
            let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
            
            let responseAnimationParameter = AnimationEngineParameterType()
            
            responseAnimationParameter.Json = jsonDictionary
            
            
            var TransformKind:String =   (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            
            TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind =       (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            
            TransformKind =    (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]   as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
            
            if(TransformKind == AnimationType.Tranformation.description)
            {
                (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
            }
            
            responseAnimationParameter.StartSec = beat.StartSec
            responseAnimationParameter.EndSec = beat.EndSec
            
            animationEngineParameterGroup.Expressions.append(responseAnimationParameter)
        }
        
        return animationEngineParameterGroup
    }
    
    public func GetPlaneAnimation(json:String,response:String="")->AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        responseAnimationParameter.Json = jsonDictionary
        
       
        var TransformKind:String =   (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =       (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
         TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
         TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
         TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        
        TransformKind =    (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]   as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
        (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        responseAnimationParameter.sentance = response
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter]
        return animationEngineParameterGroup
    }
    
    public func GetPlaneAnimationWithMusic(json:String,MusicFile:String="")->AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        responseAnimationParameter.Json = jsonDictionary
        
        
        var TransformKind:String =   (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"] as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =       (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind =     (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        
        TransformKind =    (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]   as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        TransformKind = (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  as! String
        
        if(TransformKind == AnimationType.Tranformation.description)
        {
            (((((responseAnimationParameter.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = AnimationType.TransformOverlay.description
        }
        
        responseAnimationParameter.audio = MusicFile
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter]
        return animationEngineParameterGroup
    }
    
    public func GetNapAnimation(delegate: AnimationParameterTypeDelegates) -> AnimationEngineParameterGroup
    {
        let dbHAndler = DB_Local_Store()
        
        let napExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"nap")
        
        let napJsonMsgObject:NSMutableDictionary! =    (napExpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        let napAnimation = AnimationEngineParameterType()
        napAnimation.Json = napJsonMsgObject
        napAnimation.delegate = delegate
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        animationEngineParameterGroup.Expressions = [napAnimation]
        
        return animationEngineParameterGroup
    }
    
    public func GetBlinkCorrectionStraight() -> AnimationEngineParameterGroup
    {
        let dbHAndler = DB_Local_Store()
        
        let straightxpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID,ByName :"Stand_Straight")
        
        let straightJsonMsgObject:NSMutableDictionary! =    (straightxpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        
       //Diable Motor Commands
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        
        //Set Graphic Animation Duration
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "50"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "50"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "100"
        
        let straightAnimation = AnimationEngineParameterType()
        straightAnimation.Json = straightJsonMsgObject
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        animationEngineParameterGroup.Expressions = [straightAnimation]
        
        return animationEngineParameterGroup
    }
    
    public func GetStraightAnimation(responseText:String = "") -> AnimationEngineParameterGroup
    {
        let dbHAndler = DB_Local_Store()
        
        let straightxpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID,ByName :"Stand_Straight")
        
        let straightJsonMsgObject:NSMutableDictionary! =    (straightxpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  "700"
        
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] = "700"
        
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] = "700"
        
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] = "700"
        
        
        //Set Graphic Animation Duration
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] = "700"
        
        let straightAnimation = AnimationEngineParameterType()
        straightAnimation.Json = straightJsonMsgObject
        straightAnimation.sentance = responseText
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        animationEngineParameterGroup.Expressions = [straightAnimation]
        
        return animationEngineParameterGroup
    }
    
    public func GetStraightBlink() -> AnimationEngineParameterGroup
    {
        let dbHAndler = DB_Local_Store()
        
        
        let blinkCloseExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"blink_close")
        
        let blinkClosejsonMsgObject:NSMutableDictionary = blinkCloseExpression.Action_Data.parseJSONString as! NSMutableDictionary
        
        let blinkCloseAnimation = AnimationEngineParameterType()
        blinkCloseAnimation.Json = blinkClosejsonMsgObject
        blinkCloseAnimation.IsHalfBlink = true
        
        
        
        let straightxpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"Stand_Straight")
        
        let straightJsonMsgObject:NSMutableDictionary! =    (straightxpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        //Diable Motor Commands
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        
        //Set Graphic Animation Duration
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        
        
        let straightAnimation = AnimationEngineParameterType()
        straightAnimation.Json = straightJsonMsgObject
        
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        animationEngineParameterGroup.Expressions = [ blinkCloseAnimation, straightAnimation]
        
        return animationEngineParameterGroup
        
    }
    
    public func GetAnimationEngineParameterTypes(json:String, response:String="", OnPauseAction:AnimationOnPauseRestartAction=AnimationOnPauseRestartAction.DESTROY) -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        responseAnimationParameter.Json = jsonDictionary
        
        responseAnimationParameter.sentance = response
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter]
        
        return animationEngineParameterGroup
    }
    
    public func GetAnimationEngineParameterTypesWithBlinkSlow(json:String) -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        
        let dbHAndler = DB_Local_Store()
        
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        responseAnimationParameter.Json = jsonDictionary
        
        
        let blinkCloseExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"blink_close")
        
        let blinkClosejsonMsgObject:NSMutableDictionary =    blinkCloseExpression.Action_Data.parseJSONString as! NSMutableDictionary
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        
        
        //Set Graphic Animation Duration
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "300"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "300"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        
        let blinkCloseAnimation = AnimationEngineParameterType()
        blinkCloseAnimation.Json = blinkClosejsonMsgObject
        blinkCloseAnimation.IsHalfBlink = true
        
        
        let responseAnimationParameterNoMotion = AnimationEngineParameterType()
        responseAnimationParameterNoMotion.Json = json.parseJSONString as! NSMutableDictionary
        
        //Diable Motor Commands
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        //Set Graphic Animation Duration
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "300"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "300"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        
        responseAnimationParameterNoMotion.animationPosition = AnimationPositions()
        responseAnimationParameterNoMotion.animationPosition.parseJson(json: responseAnimationParameterNoMotion.Json)
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationState).opacity = [1:true]
        }
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationState).opacity = [1:true]
        }
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationState).opacity = [1:true]
        }
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationState).opacity = [1:true]
        }
        
        responseAnimationParameterNoMotion.Json = responseAnimationParameterNoMotion.animationPosition.Json().parseJSONString as! NSMutableDictionary
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter, blinkCloseAnimation,responseAnimationParameterNoMotion]
        
        return animationEngineParameterGroup
    }
    
    public func GetAnimationEngineParameterTypesWithBlink(json:String) -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        
        let dbHAndler = DB_Local_Store()
        
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        responseAnimationParameter.Json = jsonDictionary
        
     
        let blinkCloseExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"blink_close")
        
        let blinkClosejsonMsgObject:NSMutableDictionary =    blinkCloseExpression.Action_Data.parseJSONString as! NSMutableDictionary
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        
        
        //Set Graphic Animation Duration
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "150"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "150"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "50"
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "50"
        
        
        let blinkCloseAnimation = AnimationEngineParameterType()
        blinkCloseAnimation.Json = blinkClosejsonMsgObject
        blinkCloseAnimation.IsHalfBlink = true
        
        
        let responseAnimationParameterNoMotion = AnimationEngineParameterType()
        responseAnimationParameterNoMotion.Json = json.parseJSONString as! NSMutableDictionary
        
        //Diable Motor Commands
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        //Set Graphic Animation Duration
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "150"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "150"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "50"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "50"
        
        
        responseAnimationParameterNoMotion.animationPosition = AnimationPositions()
        responseAnimationParameterNoMotion.animationPosition.parseJson(json: responseAnimationParameterNoMotion.Json)
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationState).opacity = [1:true]
        }
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationState).opacity = [1:true]
        }
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationState).opacity = [1:true]
        }
        
        if(!(responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationState).opacity.values.first!)
        {
            (responseAnimationParameterNoMotion.animationPosition.State.StateSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationState).opacity = [1:true]
        }
        
        responseAnimationParameterNoMotion.Json = responseAnimationParameterNoMotion.animationPosition.Json().parseJSONString as! NSMutableDictionary
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter, blinkCloseAnimation,responseAnimationParameterNoMotion]
        
        return animationEngineParameterGroup
    }
    
    
    
    public func GetAnimationEngineParameterTypesWithBlinkAndStraight(json:String, response:String="", OnPauseAction:AnimationOnPauseRestartAction=AnimationOnPauseRestartAction.DESTROY) -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        
        let dbHAndler = DB_Local_Store()
        
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        responseAnimationParameter.Json = jsonDictionary
        
        responseAnimationParameter.sentance = response
        
        
        let blinkCloseExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"blink_close")
        
        let blinkClosejsonMsgObject:NSMutableDictionary =    blinkCloseExpression.Action_Data.parseJSONString as! NSMutableDictionary
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        let blinkCloseAnimation = AnimationEngineParameterType()
        blinkCloseAnimation.Json = blinkClosejsonMsgObject
        blinkCloseAnimation.IsHalfBlink = true
        
        
        let responseAnimationParameterNoMotion = AnimationEngineParameterType()
        responseAnimationParameterNoMotion.Json = json.parseJSONString as! NSMutableDictionary
        
        //Diable Motor Commands
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        //Set Graphic Animation Duration
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        
        
        
        
        let straightxpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"Stand_Straight")
        
        let straightJsonMsgObject:NSMutableDictionary! =    (straightxpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"]
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"]
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"]
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"]
        
        let straightAnimation = AnimationEngineParameterType()
        straightAnimation.Json = straightJsonMsgObject
        
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter, blinkCloseAnimation,responseAnimationParameterNoMotion, straightAnimation]
        
        return animationEngineParameterGroup
        
    }
    
    
    public func GetAnimationEngineParameterTypesTimeStretchedWithBlinkAndStraight(json:String, response:String="") -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        
        let dbHAndler = DB_Local_Store()
        
        let StrtchedTime = String(arc4random_uniform(3000 - 2500) + 2500)
        
        let jsonDictionary:NSMutableDictionary = json.parseJSONString as! NSMutableDictionary
        
        let responseAnimationParameter = AnimationEngineParameterType()
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  StrtchedTime
        
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  StrtchedTime
        
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  StrtchedTime
        
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  StrtchedTime
        
        
        
        
        //Set Graphic Animation Duration
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  StrtchedTime
        
        responseAnimationParameter.Json = jsonDictionary
        
        responseAnimationParameter.sentance = response
        
        
        
        let blinkCloseExpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"blink_close")
        
        let blinkClosejsonMsgObject:NSMutableDictionary =    blinkCloseExpression.Action_Data.parseJSONString as! NSMutableDictionary
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((blinkClosejsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        let blinkCloseAnimation = AnimationEngineParameterType()
        blinkCloseAnimation.Json = blinkClosejsonMsgObject
        
        blinkCloseAnimation.IsHalfBlink = true
        
        
        
        let responseAnimationParameterNoMotion = AnimationEngineParameterType()
        responseAnimationParameterNoMotion.Json = json.parseJSONString as! NSMutableDictionary
        
        //Diable Motor Commands
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        ((((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["Angle"] as! NSMutableDictionary)["value"] = "false"
        
        
        
        //Set Graphic Animation Duration
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["State"] as! NSMutableDictionary)["AnimationStateSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["AnimationState"] as! NSMutableDictionary)["AnimationKind"]  = "TransformOverlay"
        
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "100"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        (((((responseAnimationParameterNoMotion.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  "200"
        
        
        let straightxpression =  dbHAndler.readExpression(Em_Synth_id: EM_SYNTH_ID, ByName :"Stand_Straight")
        
        let straightJsonMsgObject:NSMutableDictionary! =    (straightxpression.Action_Data.parseJSONString as! NSMutableDictionary)
        
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"]
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"]
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"]
        
        
        (((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"] =  (((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"]
        
        
        //Set Graphic Animation Duration
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        (((((straightJsonMsgObject["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  (((((jsonDictionary["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"]
        
        let straightAnimation = AnimationEngineParameterType()
        straightAnimation.Json = straightJsonMsgObject
        
        
        animationEngineParameterGroup.Expressions = [responseAnimationParameter, blinkCloseAnimation,responseAnimationParameterNoMotion, straightAnimation]
        
        return animationEngineParameterGroup
    }
    
    
    public func MakeDeltaAnglesForStudioExpression(data:NSDictionary)->Bool
    {
        let animationAction = AnimationAction()
        
        animationAction.ParseJson(json: data)
        
        let Turn_MotorState:MotorAnimationState! = (animationAction.Position.State.StateSet[AnimationObject.Motor_Turn] as! MotorAnimationState)
        if(Turn_MotorState != nil && Turn_MotorState.Angle.values.first!)
        {
            Turn_MotorState.IsDeltaAngle = true
            Turn_MotorState.Angle = [Turn_MotorState.Angle.keys.first! : true]
        }
        
        let Lift_MotorState:MotorAnimationState! = (animationAction.Position.State.StateSet[AnimationObject.Motor_Lift] as! MotorAnimationState)
        if(Lift_MotorState != nil && Lift_MotorState.Angle.values.first!)
        {
            Lift_MotorState.IsDeltaAngle = true
            Lift_MotorState.Angle = [Lift_MotorState.Angle.keys.first! : true]
        }
        
        let Lean_MotorState:MotorAnimationState! = (animationAction.Position.State.StateSet[AnimationObject.Motor_Lean] as! MotorAnimationState)
        if(Lean_MotorState != nil && Lean_MotorState.Angle.values.first!)
        {
            Lean_MotorState.IsDeltaAngle = true
            Lean_MotorState.Angle = [Lean_MotorState.Angle.keys.first!: true]
        }
        
        let Tilt_MotorState:MotorAnimationState! = (animationAction.Position.State.StateSet[AnimationObject.Motor_Tilt] as! MotorAnimationState)
        if(Tilt_MotorState != nil && Tilt_MotorState.Angle.values.first!)
        {
            Tilt_MotorState.IsDeltaAngle = true
            Tilt_MotorState.Angle = [Tilt_MotorState.Angle.keys.first!: true]
        }
        
        
        
        let expressions_Type =  Expressions_Type(name: animationAction.Name,action_Data: animationAction.Position.Json(), joy: animationAction.Emotion.EmotionData[EmotionEnums.Emotions.JOY]!, surprise: animationAction.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE]!, fear: animationAction.Emotion.EmotionData[EmotionEnums.Emotions.FEAR]!, sadness: animationAction.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS]!, anger: animationAction.Emotion.EmotionData[EmotionEnums.Emotions.ANGER]!, disgust: animationAction.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST]!, em_synth_id: EM_SYNTH_ID, Sound_Library_ID: animationAction.Sound_ID)
        
        let dbHandler:DB_Local_Store = DB_Local_Store()
        
        
        return   dbHandler.saveExpression(Data: expressions_Type)
    }
    
    public func StretchAnimationBy(ActionData:String, StretchTimeBy:Int) -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        let stetchedAnimation = AnimationEngineParameterType()
        stetchedAnimation.Json = ActionData.parseJSONString as! NSMutableDictionary
        
        
        
        let Duration_Image_EyeLeft:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeRight:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBrowRight:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBrowLeft:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBallLeft:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBallRight:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyePupilRight:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyePupilLeft:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeLidRight:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeLidLeft:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Motor_Turn:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] as! String)!
        
        let Duration_Motor_Lift:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] as! String)!
        
        let Duration_Motor_Lean:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] as! String)!
        
        let Duration_Motor_Tilt:Int = Int((((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] as! String)!
        
        
        if(Duration_Motor_Turn > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Turn"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  String(Duration_Motor_Turn + StretchTimeBy > 9999 ? 9999 : Duration_Motor_Turn + StretchTimeBy)
        }
        
        
        
        if(Duration_Motor_Lift > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lift"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  String(Duration_Motor_Lift + StretchTimeBy > 9999 ? 9999 : Duration_Motor_Lift + StretchTimeBy)
        }
        
        
        if(Duration_Motor_Lean > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Lean"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  String(Duration_Motor_Lean + StretchTimeBy > 9999 ? 9999 : Duration_Motor_Lean + StretchTimeBy)
        }
        
        if(Duration_Motor_Tilt > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Motor_Tilt"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Timing"] =  String(Duration_Motor_Tilt + StretchTimeBy > 9999 ? 9999 : Duration_Motor_Tilt + StretchTimeBy)
        }
        
        
        
        if(Duration_Image_EyeLeft > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeLeft + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeLeft + StretchTimeBy)
        }
        
        if(Duration_Image_EyeRight > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeRight + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeRight + StretchTimeBy)
        }
        
        if(Duration_Image_EyeBrowRight > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBrowRight + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeBrowRight + StretchTimeBy)
        }
        
        if(Duration_Image_EyeBrowLeft > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBrowLeft + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeBrowLeft + StretchTimeBy)
        }
        
        if(Duration_Image_EyeBallLeft > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBallLeft + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeBallLeft + StretchTimeBy)
        }
        
        if(Duration_Image_EyeBallRight > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBallRight + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeBallRight + StretchTimeBy)
        }
        
        if(Duration_Image_EyePupilRight > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyePupilRight + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyePupilRight + StretchTimeBy)
        }
        
        if(Duration_Image_EyePupilLeft > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyePupilLeft + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyePupilLeft + StretchTimeBy)
        }
        
        if(Duration_Image_EyeLidRight > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeLidRight + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeLidRight + StretchTimeBy)
        }
        
        if(Duration_Image_EyeLidLeft > 0)
        {
            (((((stetchedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeLidLeft + StretchTimeBy > 9999 ? 9999 : Duration_Image_EyeLidLeft + StretchTimeBy)
        }
        
        
        animationEngineParameterGroup.Expressions = [stetchedAnimation]
        
        
        
        return animationEngineParameterGroup
    }
    
    public func SqueezeGraphicAnimationBy(ActionData:String, SqueezeTimeBy:Int) -> AnimationEngineParameterGroup
    {
        let animationEngineParameterGroup:AnimationEngineParameterGroup = AnimationEngineParameterGroup()
        
        let squeezedAnimation = AnimationEngineParameterType()
        squeezedAnimation.Json = ActionData.parseJSONString as! NSMutableDictionary
        
        
        
        let Duration_Image_EyeLeft:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeRight:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBrowRight:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBrowLeft:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBallLeft:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeBallRight:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyePupilRight:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyePupilLeft:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeLidRight:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        let Duration_Image_EyeLidLeft:Int = Int((((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] as! String)!
        
        
        
        
        
        if(Duration_Image_EyeLeft > SqueezeTimeBy)
        {
        (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeLeft - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeRight > SqueezeTimeBy)
        {
        (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeRight - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeBrowRight > SqueezeTimeBy)
        {
        (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBrowRight - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeBrowLeft > SqueezeTimeBy)
        {
        (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBrowLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBrowLeft - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeBallLeft > SqueezeTimeBy)
        {
        (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBallLeft - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeBallRight > SqueezeTimeBy)
        {
            (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeBallRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeBallRight - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyePupilRight > SqueezeTimeBy)
        {
            (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyePupilRight - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyePupilLeft > SqueezeTimeBy)
        {
            (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyePupilLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyePupilLeft - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeLidRight > SqueezeTimeBy)
        {
            (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidRight"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeLidRight - SqueezeTimeBy)
        }
        
        if(Duration_Image_EyeLidLeft > SqueezeTimeBy)
        {
            (((((squeezedAnimation.Json["AnimationPositions"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["AnimationTransitionSet"] as! NSMutableDictionary)["Image_EyeLidLeft"] as! NSMutableDictionary)["Transition"] as! NSMutableDictionary)["Duration"] =  String(Duration_Image_EyeLidLeft - SqueezeTimeBy)
        }
        
        
        animationEngineParameterGroup.Expressions = [squeezedAnimation]
        
        return animationEngineParameterGroup
    }
    
    public func GetmaxGraphicAnimTime(ActionData:String) -> Int
    {
        
        var maxtime = 0
        var GraphicTimings:[Int] = []
        
        let position = AnimationPositions()
        
        position.parseJson(json: ActionData.parseJSONString as! NSMutableDictionary)
        if((position.State.StateSet[AnimationObject.Image_EyeLidLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeLidLeft] as! ImageAnimationTransition).Duration)
        }
        if((position.State.StateSet[AnimationObject.Image_EyeLidRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeLidRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBrowLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBrowLeft] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBrowRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBrowRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeLeft] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationTransition).Duration)
        }
       
        if(GraphicTimings.count > 0)
        {
            maxtime = GraphicTimings.max()!
        }
        
        return maxtime
    }
    
   public func GetmaxTime(ActionData:String) -> Int
    {
        
        var maxtime = 0
        var MotionTimings:[Int] = []
        var GraphicTimings:[Int] = []
        
        let position = AnimationPositions()
        
        position.parseJson(json: ActionData.parseJSONString as! NSMutableDictionary)
        if((position.State.StateSet[AnimationObject.Image_EyeLidLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeLidLeft] as! ImageAnimationTransition).Duration)
        }
        if((position.State.StateSet[AnimationObject.Image_EyeLidRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeLidRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBrowLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBrowLeft] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBrowRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBrowRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeLeft] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyeRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyeRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationTransition).Duration)
        }
        
        if((position.State.StateSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationState).AnimationKind != AnimationType.NA )
        {
            GraphicTimings.append((position.Transition.TransitionSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationTransition).Duration)
        }
        if((position.State.StateSet[AnimationObject.Motor_Tilt] as! MotorAnimationState).Angle.values.first == true)
        {
            MotionTimings.append((position.Transition.TransitionSet[AnimationObject.Motor_Tilt] as! MotionAnimationTransition).Timing + (position.Transition.TransitionSet[AnimationObject.Motor_Tilt] as! MotionAnimationTransition).Delay)
        }
        if((position.State.StateSet[AnimationObject.Motor_Lean] as! MotorAnimationState).Angle.values.first == true)
        {
            MotionTimings.append((position.Transition.TransitionSet[AnimationObject.Motor_Lean] as! MotionAnimationTransition).Timing + (position.Transition.TransitionSet[AnimationObject.Motor_Lean] as! MotionAnimationTransition).Delay)
        }
        if((position.State.StateSet[AnimationObject.Motor_Lift] as! MotorAnimationState).Angle.values.first == true)
        {
            MotionTimings.append((position.Transition.TransitionSet[AnimationObject.Motor_Lift] as! MotionAnimationTransition).Timing + (position.Transition.TransitionSet[AnimationObject.Motor_Lift] as! MotionAnimationTransition).Delay)
        }
        if((position.State.StateSet[AnimationObject.Motor_Turn] as! MotorAnimationState).Angle.values.first == true)
        {
            MotionTimings.append((position.Transition.TransitionSet[AnimationObject.Motor_Turn] as! MotionAnimationTransition).Timing + (position.Transition.TransitionSet[AnimationObject.Motor_Turn] as! MotionAnimationTransition).Delay)
        }
        
        if(MotionTimings.count > 0 || GraphicTimings.count > 0)
        {
            
            if(MotionTimings.count > 0 && GraphicTimings.count > 0)
            {
                maxtime = MotionTimings.max()! > GraphicTimings.max()! ? MotionTimings.max()! : GraphicTimings.max()!
            }
            else
                if(MotionTimings.count > 0)
                {
                    maxtime = MotionTimings.max()!
                }
                else
                    if(GraphicTimings.count > 0)
                    {
                        maxtime = GraphicTimings.max()!
            }
        }
        
        
        
        
        return maxtime
    }
}
