//
//  BeatsScreen.swift
//  AniStudio
//
//  Created by Tej Kiran on 30/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.

import Foundation
import UIKit
import AVFoundation

import GraphicAnimation
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_System
import FDWaveformView

class BeatsScreen: UIViewController, HomeScreenChildProtocol,ChildPanelProtocol,UIChoreogramConvey, UIBotUploadConvey, FDWaveformViewDelegate, UIScrollViewDelegate, BeatSelectedProtocol
{
    
    
    //UIBotUploadConvey
    func SetUploadProgress(progress: Float) {
        DialogManager.Instance.delDialogRequest.ProgressDialogSetProgress(percent: progress)
    }
    
    func DismissUploadProgressDialog() {
         
        DialogManager.Instance.delDialogRequest.DismissProgressDialog()
    }
    //End of UIBotUploadConvey
    
    
    @IBAction func btnUploadCgramClicked(_ sender: Any) {
       
        DialogManager.Instance.delDialogRequest.ShowProgressDialog(title: "Uploading Choreogram . . .")
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().UploadChoreogramOnBot()
    }
    
    @IBAction func btnPlayChoreogram(_ sender: Any) {
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().PlayChoreogramOnBot()
    }
    
    
    @IBOutlet weak var btnPlayAudioBit: UIButton!
    @IBAction func btnPlayAudio(_ sender: Any) {
        if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
        {
            puaseAudio()
        }
        else
            if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && !UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
            {
                vwExpressThumbTapped(gesture: UITapGestureRecognizer())
                btnPlayAudioBit.setImage(UIImage(named: "Pause"), for: UIControl.State.normal)
                
                playOnlyAudio()
        }
    }
    
    @IBOutlet weak var vwbeatPaste: UIView!
    
    @IBAction func btnPasteClicked(_ sender: Any) {
        if(CopiedBeatID == -1)
        {
            return
        }
        vwbeatPaste.alpha = 0
         let db:DB_Local_Store = DB_Local_Store()
        let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  CopiedBeatID)
        
        let TimeSpan = Beats[0].EndSec - Beats[0].StartSec
        Beats[0].StartSec = Int(sldrTimeline.maximumValue - sldrTimeline.value[1])
        Beats[0].EndSec = Beats[0].StartSec+TimeSpan
        
        _ = db.saveBeat(Data: Beats[0])
        
        let StartPercent = ((sldrTimeline.maximumValue - sldrTimeline.value[1])/sldrTimeline.maximumValue)*100
        
        let EndTime = (sldrTimeline.maximumValue - sldrTimeline.value[1]) + CGFloat(TimeSpan)
        let EndPercent = (EndTime/sldrTimeline.maximumValue)*100
        
        let thumbView = GetThumbView(maxtime:TimeSpan, Beat_ID: db.GetLastBeatID(), StartPercent: StartPercent, EndPercent: EndPercent)
        
        vwExpThumbPanel.addSubview(thumbView)
        
        sldrTimeline.value[1] =  sldrTimeline.value[1] - CGFloat(TimeSpan)
        
        beatView[db.GetLastBeatID()] = thumbView
    }
    
    @IBAction func btnExtendToNextAnimation(_ sender: Any) {
        let db:DB_Local_Store = DB_Local_Store()
        
        let beatID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0]).VALUE)
        let CurrentBeat =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  beatID!)
        
        let AllBeats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, ACT_ID: CurrentBeat[0].Act_Id!)
        
        let sortedBeats  = AllBeats.sorted{ $0.StartSec < $1.StartSec }
        
        let index = sortedBeats.firstIndex(where: { (item) -> Bool in
            item.Beat_Id == CurrentBeat[0].Beat_Id! // test if this is the item you're looking for
        })
        
        if(sortedBeats.count-1 > index!)
        {
            let StretchDuration = sortedBeats[index!+1].StartSec - sortedBeats[index!].EndSec
            let ExpressionHelper = AnimationExpressionHelper()
            let StretchedAnimation = ExpressionHelper.StretchAnimationBy(ActionData: sortedBeats[index!].Action_Data, StretchTimeBy: StretchDuration)
            
            let maxTime = ExpressionHelper.GetmaxTime(ActionData: StretchedAnimation.Expressions[0].Json.toString()!)
            
              let StretchedAnimationBeat = Beats_Type(act_Id: CurrentBeat[0].Act_Id, beat_ID: -1, action_Data: StretchedAnimation.Expressions[0].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: sortedBeats[index!].StartSec, endSec: sortedBeats[index!].StartSec+maxTime)
            
            _ = db.DeleteBeatByBeatID(BEAT_ID: CurrentBeat[0].Beat_Id)
            _ = db.saveBeat(Data: StretchedAnimationBeat)
            
            beatView[sortedBeats[index!].Beat_Id]?.removeFromSuperview()
            beatView.removeValue(forKey: sortedBeats[index!].Beat_Id)
            
            let StartPercent = (CGFloat(StretchedAnimationBeat.StartSec)/sldrTimeline.maximumValue)*100
            
            let EndPercent = (CGFloat(StretchedAnimationBeat.EndSec)/sldrTimeline.maximumValue)*100
            
            
            let thumbView = GetThumbView(maxtime:maxTime, Beat_ID: db.GetLastBeatID(), StartPercent: StartPercent, EndPercent: EndPercent)
            
            beatView[thumbView.tag] = thumbView
            
            vwExpThumbPanel.addSubview(thumbView)
            
            sldrTimeline.value[1] =  sldrTimeline.value[1] - CGFloat(StretchDuration)
            
            
        }
        
    }
    @IBAction func btnAddNextBlink(_ sender: Any) {
        let db:DB_Local_Store = DB_Local_Store()
        
        let beatID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0]).VALUE)
        let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  beatID!)
        
        let ExpressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
        
        let AnimGroup = ExpressionHelper.GetAnimationEngineParameterTypesWithBlink(json: Beats[0].Action_Data)
        
        
        let BlinkCloseTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[1].Json!.toString()!)
        
        let BlinkCloseBeat = Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: AnimGroup.Expressions[1].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: Beats[0].EndSec, endSec: Beats[0].EndSec + BlinkCloseTime)
        
        _ = db.saveBeat(Data: BlinkCloseBeat)
        
        var StartPercent = (CGFloat(BlinkCloseBeat.StartSec)/sldrTimeline.maximumValue)*100
        
        var EndPercent = (CGFloat(BlinkCloseBeat.EndSec)/sldrTimeline.maximumValue)*100
        
        var thumbView = GetThumbView(maxtime:BlinkCloseTime, Beat_ID: db.GetLastBeatID(), StartPercent: StartPercent, EndPercent: EndPercent)
        
        vwExpThumbPanel.addSubview(thumbView)
        
        beatView[thumbView.tag] = thumbView
        
        
        
        
        let BlinkOpenTimeTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[2].Json!.toString()!)
        
        let BlinkOpenBeat =  Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: AnimGroup.Expressions[2].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: BlinkCloseBeat.EndSec, endSec: BlinkCloseBeat.EndSec + BlinkOpenTimeTime)
        
        _ = db.saveBeat(Data: BlinkOpenBeat)
        
         StartPercent = (CGFloat(BlinkOpenBeat.StartSec)/sldrTimeline.maximumValue)*100
        
         EndPercent = (CGFloat(BlinkOpenBeat.EndSec)/sldrTimeline.maximumValue)*100
        
         thumbView = GetThumbView(maxtime:BlinkOpenTimeTime, Beat_ID: db.GetLastBeatID(), StartPercent: StartPercent, EndPercent: EndPercent)
        
        vwExpThumbPanel.addSubview(thumbView)
        
        beatView[thumbView.tag] = thumbView
        
        sldrTimeline.value[1] =  sldrTimeline.value[1] - CGFloat(BlinkCloseTime + BlinkOpenTimeTime)
        
    }
    
    @IBAction func btnAddBlinkSlowClicked(_ sender: Any) {
        let db:DB_Local_Store = DB_Local_Store()
        
        let beatID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0]).VALUE)
        let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  beatID!)
        
        
        
        let ExpressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
        
        let AnimGroup = ExpressionHelper.GetAnimationEngineParameterTypesWithBlinkSlow(json: Beats[0].Action_Data)
        
        //Original Animation graphic animation time
        let AnimTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[0].Json!.toString()!)
        
        
        let BlinkCloseTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[1].Json!.toString()!)
        
        
        let BlinkOpenTimeTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[2].Json!.toString()!)
        
        let squeezedAnimationTime = AnimTime - (BlinkCloseTime+BlinkOpenTimeTime)
        
        if(squeezedAnimationTime > 1000)
        {
            //Squeezed animation
            let SqeezedAnim = ExpressionHelper.SqueezeGraphicAnimationBy(ActionData: AnimGroup.Expressions[0].Json!.toString()!, SqueezeTimeBy: (BlinkCloseTime+BlinkOpenTimeTime))
            
            
            
            let SqeezedBeat = Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: SqeezedAnim.Expressions[0].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0, startSec: Beats[0].StartSec, endSec: Beats[0].EndSec)
            
            
            let BlinkCloseBeat = Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: AnimGroup.Expressions[1].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: SqeezedBeat.StartSec + squeezedAnimationTime, endSec: SqeezedBeat.StartSec + squeezedAnimationTime + BlinkCloseTime)
            
            
            let BlinkOpenBeat =  Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: AnimGroup.Expressions[2].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: BlinkCloseBeat.EndSec, endSec: BlinkCloseBeat.EndSec + BlinkOpenTimeTime)
            
            _ = db.DeleteBeatByBeatID(BEAT_ID: Beats[0].Beat_Id)
            _ = db.saveBeat(Data: SqeezedBeat)
            _ = db.saveBeat(Data: BlinkCloseBeat)
            _ = db.saveBeat(Data: BlinkOpenBeat)
            
            for view in vwExpThumbPanel.subviews
            {
                view.removeFromSuperview()
                beatView.removeAll()
            }
            
            LoadBeats()
        }
        else
        {
            
        }
    }
    
    @IBAction func btnAddBlinkClicked(_ sender: Any) {
        let db:DB_Local_Store = DB_Local_Store()
        
        let beatID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0]).VALUE)
        let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  beatID!)
        
       
        
        let ExpressionHelper:AnimationExpressionHelper = AnimationExpressionHelper()
        
        let AnimGroup = ExpressionHelper.GetAnimationEngineParameterTypesWithBlink(json: Beats[0].Action_Data)
        
        //Original Animation graphic animation time
        let AnimTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[0].Json!.toString()!)
        
    
        let BlinkCloseTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[1].Json!.toString()!)
        
      
         let BlinkOpenTimeTime =  ExpressionHelper.GetmaxGraphicAnimTime(ActionData: AnimGroup.Expressions[2].Json!.toString()!)
        
        let squeezedAnimationTime = AnimTime - (BlinkCloseTime+BlinkOpenTimeTime)
        
        if(squeezedAnimationTime > 1000)
        {
            //Squeezed animation
            let SqeezedAnim = ExpressionHelper.SqueezeGraphicAnimationBy(ActionData: AnimGroup.Expressions[0].Json!.toString()!, SqueezeTimeBy: (BlinkCloseTime+BlinkOpenTimeTime))
            

            
            let SqeezedBeat = Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: SqeezedAnim.Expressions[0].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0, startSec: Beats[0].StartSec, endSec: Beats[0].EndSec)
            
            
            let BlinkCloseBeat = Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: AnimGroup.Expressions[1].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: SqeezedBeat.StartSec + squeezedAnimationTime, endSec: SqeezedBeat.StartSec + squeezedAnimationTime + BlinkCloseTime)
            
            
            let BlinkOpenBeat =  Beats_Type(act_Id: Beats[0].Act_Id, beat_ID: -1, action_Data: AnimGroup.Expressions[2].Json!.toString()!, joy: 0, surprise: 0, fear: 0, sadness: 0, anger: 0, disgust: 0 , startSec: BlinkCloseBeat.EndSec, endSec: BlinkCloseBeat.EndSec + BlinkOpenTimeTime)
            
            _ = db.DeleteBeatByBeatID(BEAT_ID: Beats[0].Beat_Id)
            _ = db.saveBeat(Data: SqeezedBeat)
            _ = db.saveBeat(Data: BlinkCloseBeat)
            _ = db.saveBeat(Data: BlinkOpenBeat)
            
            for view in vwExpThumbPanel.subviews
            {
                view.removeFromSuperview()
                beatView.removeAll()
            }
            
            LoadBeats()
        }
        else
        {
            
        }
    }
    
    @IBAction func btnBeatEditWithTimeClicked(_ sender: Any) {
        
        let db:DB_Local_Store = DB_Local_Store()
        
        let beatID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0]).VALUE)
        
        
        let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  beatID!)
        
        if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
        {
            puaseAudio()
        }
        
        
        
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY] = Beats[0].JOY
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE] = Beats[0].SURPRISE
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR] = Beats[0].FEAR
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS] = Beats[0].SADNESS
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER] = Beats[0].ANGER
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST] = Beats[0].DISGUST
        
        
        AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json:  Beats[0].Action_Data?.parseJSONString as! NSDictionary)
        
        SetSliderTimeSpan()
        
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartAddEmotionJob(InitAnimation: AnimationActionCreator.instance.CurrentAnimation.Position.Json())
        
        vwExpressPanel.alpha = 1
        let expPanel = Bundle.main.loadNibNamed("ExpressionPanel",owner:self,options:nil)?.first as! ExpressionPanel
        
        expPanel.frame = vwExpressPanel.frame
        expPanel.SetParentScreen(ParentScreen: self)
        vwExpressPanel.addSubview(expPanel)
        
        
        
    }
    
    @IBAction func btnBeatEditClicked(_ sender: Any) {
        
        let db:DB_Local_Store = DB_Local_Store()
   
            let beatID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0]).VALUE)
            
            
            let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID:  beatID!)
            
            if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
            {
                puaseAudio()
            }
          
            
            
            AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY] = Beats[0].JOY
            AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE] = Beats[0].SURPRISE
            AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR] = Beats[0].FEAR
            AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS] = Beats[0].SADNESS
            AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER] = Beats[0].ANGER
            AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST] = Beats[0].DISGUST
            
            
            AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json:  Beats[0].Action_Data?.parseJSONString as! NSDictionary)
        
       
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartAddEmotionJob(InitAnimation: AnimationActionCreator.instance.CurrentAnimation.Position.Json())
            
            vwExpressPanel.alpha = 1
            let expPanel = Bundle.main.loadNibNamed("ExpressionPanel",owner:self,options:nil)?.first as! ExpressionPanel
            
            expPanel.frame = vwExpressPanel.frame
            expPanel.SetParentScreen(ParentScreen: self)
            vwExpressPanel.addSubview(expPanel)
            
         
        
    }
    
    @IBOutlet weak var btnBeatPlay: UIButton!
    @IBOutlet weak var beatControlPanel: UIView!
    
    @IBOutlet weak var vwExpThumbPanel: UIView!
    @IBOutlet weak var vwExpressPanel: UIView!
    @IBOutlet weak var btnAddExpression: UIButton!
    public static var ACTID:Int!
    
    @IBOutlet weak var btnPalyPause: UIButton!
    @IBOutlet weak var scrlVWSlider: UIScrollView!
    @IBOutlet weak var sldrTimeline: MultiSlider!
    @IBOutlet weak var scrlVWTimeline: UIScrollView!
    
    @IBOutlet weak var fdWaveform: FDWaveformView!
    @IBOutlet weak var vwScrParent: UIView!
    var homeScreenProtocol:HomeScreenProtocol!
    
    var beatView:[Int:BeatThumbView] = [:]
    
    //HomeScreenChildProtocol
    func SetHomeScreen(HomeScreen: HomeScreenProtocol) {
        homeScreenProtocol = HomeScreen
    }
    
    @IBAction func btnDeleteBeat(_ sender: Any) {
        
        vwExpressThumbTapped(gesture: UITapGestureRecognizer())
        
        let db:DB_Local_Store = DB_Local_Store()
        let BeatID = Int(db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0].VALUE)
        _ = db.DeleteBeatByBeatID(BEAT_ID: BeatID!)
        _ = db.DeleteFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)
        
        if(BeatID == CopiedBeatID)
        {
            CopiedBeatID = -1
            vwbeatPaste.alpha = 0
        }
        
        beatView[BeatID!]?.removeFromSuperview()
        beatView.removeValue(forKey: BeatID!)
        
        self.beatControlPanel.alpha = 0
       
    }
    
    @IBAction func btnPlaybeat(_ sender: Any) {
        
      
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)
        btnBeatPlay.setImage(UIImage(named: "Pause"), for: UIControl.State.normal)
        
        if contextData.count > 0
        {
            let ACTID = Int(contextData[0].VALUE)
            
            let BeatID = Int(db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0].VALUE)
            
            let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID: BeatID!)
            
            
            let ACTS = db.ReadActWithID(ID: ACTID!)
            
            let audioURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+ACTS[0].Name+"/audio/"+ACTS[0].Audio)
            
            PlayAnimation(audio: audioURL, beats: Beats, StartSec: Beats[0].StartSec, EndSec: Beats[0].EndSec)
            
        }
    }
    
    //BeatSelectedProtocol
    func BeatSelected(view: UIView) {
        
        vwExpressThumbTapped(gesture: UITapGestureRecognizer())
        
         let db:DB_Local_Store = DB_Local_Store()
        let beat:[Beats_Type] = db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID: view.tag)
        
        _ = db.saveInContext(Data: DataContext(key: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue, value:String(view.tag)))
        
        self.beatControlPanel.alpha = 1
        sldrTimeline.value[1] = sldrTimeline.maximumValue - CGFloat(beat[0].EndSec)
    }
    //End of BeatSelectedProtocol
    
    func GetThumbView(maxtime:Int, Beat_ID:Int, StartPercent:CGFloat, EndPercent:CGFloat) -> BeatThumbView
    {
        let thumbView = BeatThumbView()
        if(maxtime > 0)
        {
            let Totalheight = vwExpThumbPanel.frame.height
            
           
            
            //Top space to top of vwExpThumbPanel
            let TopSpace = StartPercent*Totalheight/100
            //Bottom space to top of vwExpThumbPanel
            let BottomSpace = EndPercent*Totalheight/100
            
            thumbView.Initialize(_beatSelectedProtocol: self, TopSpace: TopSpace, height: (BottomSpace - TopSpace), Tag:Beat_ID)
        }
        return thumbView
    }
    
  
    
    //ChildPanelProtocol
    func SelectMusic() {
        
    }
    public func SaveClicked()
    {
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)
        
        if contextData.count > 0
        {
            let ACTID = Int(contextData[0].VALUE)
            
            let ExpressionHelper = AnimationExpressionHelper()
            
            let maxtime = ExpressionHelper.GetmaxTime(ActionData: AnimationActionCreator.instance.CurrentAnimation.Position.Json())
            
                    let beat = Beats_Type(act_Id: ACTID!, beat_ID: -1, action_Data: AnimationActionCreator.instance.CurrentAnimation.Position.Json(), joy: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY]!, surprise: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE]!, fear: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR]!, sadness: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS]!, anger: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER]!, disgust: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST]!, startSec: Int(sldrTimeline.maximumValue - sldrTimeline.value[1]), endSec: Int((sldrTimeline.maximumValue - sldrTimeline.value[1]) + CGFloat(maxtime)))
            
            
            var StartPercent = ((sldrTimeline.maximumValue - sldrTimeline.value[1])/sldrTimeline.maximumValue)*100
            
            let EndTime = (sldrTimeline.maximumValue - sldrTimeline.value[1]) + CGFloat(maxtime)
            var EndPercent = (EndTime/sldrTimeline.maximumValue)*100
            
                    
                     let db:DB_Local_Store = DB_Local_Store()
                    let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)
                    
                    if(contextData.count > 0)
                    {
                        let beat_ID = Int(contextData[0].VALUE)
                        if(beat_ID != -1)
                        {
                            let beats = db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, BEAT_ID: beat_ID!)
                            
                            _ = db.DeleteBeatByBeatID(BEAT_ID: beat_ID!)
                            btnDeleteBeat(self)
                            
                            
                            
                            beat.StartSec = beats[0].StartSec
                            beat.EndSec = beats[0].StartSec+maxtime
                            
                            StartPercent = (CGFloat(beat.StartSec)/sldrTimeline.maximumValue)*100
                            
                            EndPercent = (CGFloat(beat.EndSec)/sldrTimeline.maximumValue)*100
                            
                            beatView[beat_ID!]?.removeFromSuperview()
                            beatView.removeValue(forKey: beat_ID!)
                          
                        }
                        else
                        {
                               sldrTimeline.value[1] =  sldrTimeline.value[1] - CGFloat(maxtime)
                        }
                    }
                    
                    _ = db.saveBeat(Data: beat)
            
            
            
            let thumbView = GetThumbView(maxtime:maxtime, Beat_ID: db.GetLastBeatID(), StartPercent: StartPercent, EndPercent: EndPercent)
                    
                    vwExpThumbPanel.addSubview(thumbView)
                    
            
                  
                    beatView[thumbView.tag] = thumbView
                    
                    ClosePanel()
                
            
        }
       
    }
  
    
    
    public func ClosePanel()
    {
       
        for subUIView in vwExpressPanel.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        vwExpressPanel.alpha = 0;
        
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartChoreogramJob()
        
    }
    //End of ChildPanelProtocol
    
    func  SetSliderTimeSpan()
    { (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeBallLeft] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeBallRight] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeLeft] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeRight] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeLidLeft] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeLidRight] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyePupilLeft] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyePupilRight] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeBrowLeft] as! ImageAnimationTransition).Duration = sliderTimspan
        (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Image_EyeBrowRight] as! ImageAnimationTransition).Duration = sliderTimspan
        
     (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Motor_Tilt] as! MotionAnimationTransition).Timing = sliderTimspan
    (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Motor_Lift] as! MotionAnimationTransition).Timing = sliderTimspan
    (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Motor_Lean] as! MotionAnimationTransition).Timing = sliderTimspan
    (AnimationActionCreator.instance.CurrentAnimation.Position.Transition.TransitionSet[AnimationObject.Motor_Turn] as! MotionAnimationTransition).Timing = sliderTimspan
    }
    
    @IBAction func btnAddExpClicked(_ sender: Any) {
        if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
        {
            puaseAudio()
        }
        vwExpressPanel.alpha = 1
        let expPanel = Bundle.main.loadNibNamed("ExpressionPanel",owner:self,options:nil)?.first as! ExpressionPanel
        
        vwExpressThumbTapped(gesture: UITapGestureRecognizer())
        
        let db:DB_Local_Store = DB_Local_Store()
        _ = db.saveInContext(Data: DataContext(key: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue, value:String(-1)))
        
        expPanel.frame = vwExpressPanel.frame
        expPanel.SetParentScreen(ParentScreen: self)
        vwExpressPanel.addSubview(expPanel)
        
        SetSliderTimeSpan()
        
         UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartAddEmotionJob()
        
    }
    @IBAction func btnCloseClicked(_ sender: Any) {
        if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && !UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
        {
            puaseAudio()
        }
        if(homeScreenProtocol != nil)
        { homeScreenProtocol.GoBack(Screen: HOME_SCREEN_TYPE.BEAT)
        }
    }
    
    @IBAction func btnPlayPauseClicked(_ sender: Any) {
        
       if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
       {
         puaseAudio()
       
       }
        else
        if(UIChoreogramHandler.Instance.getChoreogramRead() != nil && !UIChoreogramHandler.Instance.getChoreogramRead().IsPlaying())
        {
            vwExpressThumbTapped(gesture: UITapGestureRecognizer())
            
         playAudio()
        }
    }
    
    func LoadBeats()
    {
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)
        
        if contextData.count > 0
        {
            let ACTID = Int(contextData[0].VALUE)
            
            let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, ACT_ID: ACTID!)
            
            
            let sortedBeats  = Beats.sorted{ $0.StartSec < $1.StartSec }
            
            
            let ExpressionHelper = AnimationExpressionHelper()
            
            for beat in sortedBeats
            {
                let maxtime = ExpressionHelper.GetmaxTime(ActionData: beat.Action_Data)
             
                let StartPercent = (CGFloat(beat.StartSec)/sldrTimeline.maximumValue)*100
                
                let EndPercent = (CGFloat(beat.EndSec)/sldrTimeline.maximumValue)*100
                
               
                
                let thumbView = GetThumbView(maxtime:maxtime, Beat_ID: beat.Beat_Id, StartPercent: StartPercent , EndPercent: EndPercent)
                
                vwExpThumbPanel.addSubview(thumbView)
                
                sldrTimeline.value[1] =  sldrTimeline.value[1] - CGFloat(maxtime)
                
                beatView[beat.Beat_Id] = thumbView
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fdWaveform.transform = fdWaveform.transform.rotated(by: CGFloat.pi/2)
        UIChoreogramHandler.Instance.setNotifyOnConvey(_choreogramConvey: self)
        UIBotUploadHandler.Instance.setNotifyOnConvey(_botUploadConvey: self)
        scrlVWTimeline.delegate = self
        
        beatView = [:]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(vwExpressThumbTapped(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        vwExpThumbPanel.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func vwExpressThumbTapped(gesture: UITapGestureRecognizer) {
     
         self.beatControlPanel.alpha = 0
       for view in beatView.values
       {
            view.UnselectThumb()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DialogManager.Instance.delDialogRequest.ShowActivityIndicator()
        
        LoadTimeline()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrlVWTimeline {
            self.synchronizeScrollView(scrlVWSlider, toScrollView: scrlVWTimeline)
        }
    }
    
    func synchronizeScrollView(_ scrollViewToScroll: UIScrollView, toScrollView scrolledView: UIScrollView) {
        var offset = scrollViewToScroll.contentOffset
        offset.y = scrolledView.contentOffset.y
        
        scrollViewToScroll.setContentOffset(offset, animated: false)
    }
    
    
    
    
   func LoadAudio(url :URL) {
    
    var player: AVAudioPlayer!
        do {
            player = try AVAudioPlayer(contentsOf: url)
        }
        catch _ {
        }
    
        if player == nil {
            print("Unable to load player")
        }
        player.prepareToPlay()
    
   
        sldrTimeline.minimumValue = 0.0
            sldrTimeline.maximumValue = CGFloat(player.duration)*1000
    
        if(player.duration < 3.0)
        {
            sldrTimeline.value = [0, CGFloat(player.duration)*1000/2, CGFloat(player.duration)*1000]
        }
        else
        {
            let val2 = CGFloat(player.duration)*1000
            let val1 = CGFloat(player.duration)*1000 - 1.5*1000
            let val0 = CGFloat(0)
            sldrTimeline.value = [val0, val1, val2]
        }
    }
    
   
    func playOnlyAudio()
    {
        
        
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)
        
        if contextData.count > 0
        {
            let ACTID = Int(contextData[0].VALUE)
            
            let Beats:[Beats_Type] = []
            
            let ACTS = db.ReadActWithID(ID: ACTID!)
            
            let audioURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+ACTS[0].Name+"/audio/"+ACTS[0].Audio)
            
            PlayAnimation(audio: audioURL, beats: Beats, StartSec: Int(sldrTimeline.maximumValue - sldrTimeline.value[2]), EndSec: Int(sldrTimeline.maximumValue - sldrTimeline.value[0]))
            
        }
    }
    
    func playAudio()
    {
        
        btnPalyPause.setImage(UIImage(named: "stopanimate"), for: UIControl.State.normal)
        
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)
        
        if contextData.count > 0
        {
            let ACTID = Int(contextData[0].VALUE)
            
            let Beats =  db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, ACT_ID: ACTID!)
            
           
           let sortedBeats  = Beats.sorted{ $0.StartSec < $1.StartSec }
            
            
            let ACTS = db.ReadActWithID(ID: ACTID!)
            
            let audioURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+ACTS[0].Name+"/audio/"+ACTS[0].Audio)
            
            PlayAnimation(audio: audioURL, beats: sortedBeats, StartSec: Int(sldrTimeline.maximumValue - sldrTimeline.value[2]), EndSec: Int(sldrTimeline.maximumValue - sldrTimeline.value[0]))
           
        }
    }
    
    func PlayAnimation(audio:URL, beats:[Beats_Type], StartSec:Int, EndSec:Int)
    {
        fdWaveform.highlightedSamples = 0 ..< 0
        
        vwScrParent.isUserInteractionEnabled = false

        UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowChoreogram(audio: audio.path, StartSec:StartSec, StopSec:EndSec, beats: beats)
        
    }
    
    func puaseAudio()
    {
         UIMAINModuleHandler.Instance.GetUIMainConveyListener().PauseChoreogram()
         btnBeatPlay.setImage(UIImage(named: "Play"), for: UIControl.State.normal)
         btnPalyPause.setImage(UIImage(named: "startanimate"), for: UIControl.State.normal)
         btnPlayAudioBit.setImage(UIImage(named: "Play"), for: UIControl.State.normal)
        
         vwScrParent.isUserInteractionEnabled = true
         fdWaveform.highlightedSamples =   Int((sldrTimeline.maximumValue - sldrTimeline.value[sldrTimeline.thumbCount-1])*44.100) ..< Int((sldrTimeline.maximumValue -  sldrTimeline.value[0])*44.100)
    }
    
    public func ChoreogramFinished() {
        puaseAudio()
    }
    
    func ProgressUpdated(progress:Double) {
        
        let currentTime = progress
        
        if(Int(currentTime * 1000) > Int(sldrTimeline.maximumValue - sldrTimeline.value[0]))
        {
           
            puaseAudio()
            if(sldrTimeline.thumbCount == 3)
            {
                sldrTimeline.value[1] = sldrTimeline.value[0] + (sldrTimeline.value[2] - sldrTimeline.value[0]) / 2
            }
        }
        else
        {
            if Int((sldrTimeline.maximumValue - sldrTimeline.value[sldrTimeline.thumbCount-1])*44.100) < Int(currentTime * 44100)
            {
                if(sldrTimeline.thumbCount == 3)
                {
                    sldrTimeline.value[1] = sldrTimeline.maximumValue - CGFloat(currentTime*1000)
                }
                
              fdWaveform.highlightedSamples =   Int((sldrTimeline.maximumValue - sldrTimeline.value[sldrTimeline.thumbCount-1])*44.100) ..< Int(currentTime * 44100)
            }
        }
    }
    
    var sliderTimspan = 0
    @IBAction func sldrTimelineValueChanged(_ sender: Any) {
       
        
        fdWaveform.highlightedSamples = Int((sldrTimeline.maximumValue - sldrTimeline.value[sldrTimeline.thumbCount-1])*44.100) ..< Int((sldrTimeline.maximumValue -  sldrTimeline.value[0])*44.100)
        
        sliderTimspan = Int(sldrTimeline.value[sldrTimeline.thumbCount-1] - sldrTimeline.value[0])
        
        if(sliderTimspan > 9999)
        {
            sliderTimspan = 9999
        }
        
    }
    
    
    func LoadTimeline()
    {
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)
        
        if contextData.count > 0
        {
            let ACTID = Int(contextData[0].VALUE)
            
            let ACTS = db.ReadActWithID(ID: ACTID!)
            
            let audioURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+ACTS[0].Name+"/audio/"+ACTS[0].Audio)
           
            LoadAudio(url: audioURL)
         
            fdWaveform.delegate = self
            fdWaveform.audioURL = audioURL
            fdWaveform.wavesColor = UIColor.gray
            fdWaveform.progressColor = UIColor.orange
           
        }
        
    }
    
    var transformWaveform = false
    
    /// Rendering will begin
    @objc  func waveformViewWillRender(_ waveformView: FDWaveformView)
    {}
    
    /// Rendering did complete
    @objc  func waveformViewDidRender(_ waveformView: FDWaveformView)
    {
       DialogManager.Instance.delDialogRequest.CloseActivityIndicator()
     
        if transformWaveform == false
        {
            transformWaveform = true
             fdWaveform.highlightedSamples =   Int((sldrTimeline.maximumValue - sldrTimeline.value[sldrTimeline.thumbCount-1])*44.100) ..< Int((sldrTimeline.maximumValue -  sldrTimeline.value[0])*44.100)

            LoadBeats()
        }
        
    }
    
    /// An audio file will be loaded
    @objc  func waveformViewWillLoad(_ waveformView: FDWaveformView)
    {
        
    }
    
    /// An audio file was loaded
    @objc func waveformViewDidLoad(_ waveformView: FDWaveformView)
    {
    }
    
    /// The panning gesture did begin
    @objc  func waveformDidBeginPanning(_ waveformView: FDWaveformView)
    {}
    
    /// The panning gesture did end
    @objc  func waveformDidEndPanning(_ waveformView: FDWaveformView)
    {}
    
    /// The scrubbing gesture did end
    @objc  func waveformDidEndScrubbing(_ waveformView: FDWaveformView)
    {
        let percent = (100 - fdWaveform.TapPercent)
        
        if(sldrTimeline.value[0] > percent*sldrTimeline.maximumValue/100)
        {
            sldrTimeline.value[0] = percent*sldrTimeline.maximumValue/100
        }
        else
            if(sldrTimeline.value[sldrTimeline.thumbCount-1] < percent*sldrTimeline.maximumValue/100)
            {
                sldrTimeline.value[sldrTimeline.thumbCount-1] = percent*sldrTimeline.maximumValue/100
            }
        else
            {

           

                let slider1Distance = sldrTimeline.value[sldrTimeline.thumbCount-1] - (percent*sldrTimeline.maximumValue/100)

                let slider0Distance = (percent*sldrTimeline.maximumValue/100) - sldrTimeline.value[0]

                if(slider0Distance > slider1Distance)
                {
                    sldrTimeline.value[0] = percent*sldrTimeline.maximumValue/100
                }
                else
                    if(slider1Distance > slider0Distance)
                    {
                         sldrTimeline.value[sldrTimeline.thumbCount-1] = percent*sldrTimeline.maximumValue/100
                    }
        }
        
        
        fdWaveform.highlightedSamples =   Int((sldrTimeline.maximumValue - sldrTimeline.value[sldrTimeline.thumbCount-1])*44.100) ..< Int((sldrTimeline.maximumValue -  sldrTimeline.value[0])*44.100)
        
    }
    
    var CopiedBeatID = -1
    @IBAction func btnCopyBeat(_ sender: Any) {
        let db:DB_Local_Store = DB_Local_Store()
        CopiedBeatID = Int(db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.BEAT_ID.rawValue)[0].VALUE) ?? -1
        
        vwbeatPaste.alpha = 1
    }
    
  
    
}
