//
//  SnapShot.swift
//  AniStudio
//
//  Created by Tej Kiran on 18/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

import AudioKit
import GraphicAnimation
import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_System

class EmotionScreen: UIViewController,HomeScreenChildProtocol, ChildPanelProtocol, DialogDataNotify, UIBotUploadConvey
{
   
    public static var EM_SYNTH_ID:Int = DB_Table_Columns.DEFAULT_EM_SYNTH_ID
    var homeScreenProtocol:HomeScreenProtocol!
    
    @IBOutlet weak var tblAnimationList: UITableView!
    
    var filePath:URL!
    var mp3files:[URL]!
    
    
    //UIBotUploadConvey
    func SetUploadProgress(progress: Float) {
        DialogManager.Instance.delDialogRequest.ProgressDialogSetProgress(percent: progress)
    }
    
    func DismissUploadProgressDialog() {
        
        DialogManager.Instance.delDialogRequest.DismissProgressDialog()
    }
    //End of UIBotUploadConvey
    
    
    //DialogDataNotify
    func ItemUtilityButtonClicked(index: Int) {
        
    }
    
    public func ValidateText(text: String) -> (Bool, String) {
        let db:DB_Local_Store = DB_Local_Store()
        let Expression = db.readExpression(Em_Synth_id: EmotionScreen.EM_SYNTH_ID, ByName: text)
        if Expression.Name != ""
        {
            return (false, "Name already exists ⃰")
        }
        return (true, "")
    }
    
    public func SaveExpression(Name:String)
    {
        let dbHAndler = DB_Local_Store()
        
        if(filePath != nil && FileManager.default.fileExists(atPath: filePath.path))
        {
            do
            {
                let EmSynthObject = dbHAndler.readEmSynth(ByID: EmotionScreen.EM_SYNTH_ID)
                try FileManager.default.createDirectory(atPath: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+Name+"/audio").path, withIntermediateDirectories: true, attributes: nil)
                
                
                //delete previously mapped audio files if any
                do{
                        let enumerator =  try FileManager.default.contentsOfDirectory(atPath: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+Name+"/audio/").path)

                        for element in enumerator {
                             // checks the extension
                             do{
                               try FileManager.default.removeItem(atPath: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+Name+"/audio/").appendingPathComponent(element).path)
                            }
                            catch
                            {
                                print(error)
                            }
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                
                
                var ConvertOptions = AKConverter.Options()
                ConvertOptions.channels = 1
                ConvertOptions.sampleRate = 16000
                ConvertOptions.bitDepth = 16
                ConvertOptions.eraseFile = true
                ConvertOptions.format = "wav"
                
            let destinatrionURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+Name+"/audio/"+filePath.pathComponents.last!)
                
                let Converter = AKConverter(inputURL: filePath, outputURL: destinatrionURL , options: ConvertOptions)
                
                Converter.start(completionHandler: { error in
                    if let error = error {
                        AKLog("Error during convertion: \(error)")
                    } else {
                        AKLog("Conversion Complete!")
                    }
                })
                
//                try FileManager.default.copyItem(at: filePath, to: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+Name+"/audio/"+filePath.pathComponents.last!))
            }
            catch
            {
                print(error)
            }
            
            AnimationActionCreator.instance.CurrentAnimation.Sound_ID = filePath.lastPathComponent
        }
        
        let Expression = Expressions_Type(id: AnimationActionCreator.instance.CurrentAnimation.AnimationID, name: Name, action_Data: AnimationActionCreator.instance.CurrentAnimation.Position.Json(), joy: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY]!, surprise: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE]!, fear: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR]!, sadness: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS]!, anger: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER]!, disgust: AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST]!, em_synth_id: EmotionScreen.EM_SYNTH_ID, Sound_Library_ID: AnimationActionCreator.instance.CurrentAnimation.Sound_ID)
        
        
        if(AnimationActionCreator.instance.CurrentAnimation.AnimationID == -1)
        {
            _ = dbHAndler.saveExpression(Data: Expression)
            Expression.ID = dbHAndler.GetLastEmotionID()
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.AnimationList.append(Expression)
                DispatchQueue.main.async {
                    self.tblAnimationList.reloadData()
                }
            }
        }
        else
        {
            _ = dbHAndler.updateExpression(Data: Expression)
            for i in 0...AnimationList.count
            {
                if AnimationList[i].ID == Expression.ID
                {
                    AnimationList[i] = Expression
                    break
                }
            }
            Expression.ID = AnimationActionCreator.instance.CurrentAnimation.AnimationID
        }
        
         ClosePanel()
        
      
    }
    
    public func TextEntered(text:String)
    {
        if(text != "")
        {
           
            SaveExpression(Name: text)
            
            
           
        }
    }
    public func ItemSelected(index: Int) {
        filePath = mp3files?[index]
        AnimationActionCreator.instance.CurrentAnimation.Sound_ID = filePath.path
    }
    //End of DialogDataNotify
    
    //ChildPanelProtocol
    public func SaveClicked()
    {
        let db:DB_Local_Store = DB_Local_Store()
        let contextData = db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.EMOTION_NAME.rawValue)
        
        if(AnimationActionCreator.instance.CurrentAnimation.AnimationID == -1)
        {
            if(DialogManager.Instance.delDialogRequest != nil)
            {
                if contextData.count > 0 && contextData[0].VALUE != ""
                {
                DialogManager.Instance.delDialogRequest.ShowTextDialogWithText(Text: contextData[0].VALUE)
                }
                else
                {
                DialogManager.Instance.delDialogRequest.ShowTextDialog(placeholderText: "Enter the Expresion Name")
                }
            }
        }
        else
        {
            SaveExpression(Name: contextData[0].VALUE)
        }
    }
    public func ClosePanel()
    {
        for subUIView in vwExpressionPanel.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        vwExpressionPanel.alpha = 0;
        
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartBrowseAnimationsJob()
        
    }
    public func SelectMusic()
    {
        if(DialogManager.Instance.delDialogRequest != nil)
        {
            // Get the document directory url
            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            do {
                // Get the directory contents urls (including subfolders urls)
                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl.appendingPathComponent("EmSynth"), includingPropertiesForKeys: nil, options: [])
                print(directoryContents)
                
                // if you want to filter the directory contents you can do like this:
                let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" || $0.pathExtension == "wav" }
                
                
                print("mp3 urls:",mp3Files)
                mp3files = mp3Files
                let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
                print("mp3 list:", mp3FileNames)
                DialogManager.Instance.delDialogRequest.ShowListDialog(title: "Chose an audio track", data: mp3FileNames, DismissOnSelection: true)
            } catch {
                print(error)
            }
        }
    }
    //End of ChildPanelProtocol
    
    //HomeScreenChildProtocol
    func SetHomeScreen(HomeScreen : HomeScreenProtocol)
    {
        homeScreenProtocol = HomeScreen
    }
    //End of HomeScreenChildProtocol
    
    
    
    
    @IBOutlet weak var vwExpressionPanel: UIView!
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        if(homeScreenProtocol != nil)
        {
            homeScreenProtocol.GoBack(Screen: HOME_SCREEN_TYPE.EMOTION)
        }
    }
    
    
    var AnimationList:[Expressions_Type] = [Expressions_Type]()
    
    @IBOutlet weak var ContextView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetEmotionListAsViewContext()
        UIBotUploadHandler.Instance.setNotifyOnConvey(_botUploadConvey: self)
        DialogManager.Instance.delTextDialogNotify = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            self.LoadAnimationData()
            DispatchQueue.main.async {
                self.tblAnimationList.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func ShowEditExpressionPanel()
    {
        vwExpressionPanel.alpha = 1
        let expPanel = Bundle.main.loadNibNamed("ExpressionPanel",owner:self,options:nil)?.first as! ExpressionPanel
        
        expPanel.frame = vwExpressionPanel.frame
        expPanel.SetParentScreen(ParentScreen: self)
        vwExpressionPanel.addSubview(expPanel)
        
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartAddEmotionJob()
    }
    
    @IBAction func btnUploadEmotionClicked(_ sender: Any) {
           DialogManager.Instance.delDialogRequest.ShowProgressDialog(title: "Uploading EmSynth . . .")
        
         UIMAINModuleHandler.Instance.GetUIMainConveyListener().UploadEmSynthOnBot()
    }
    
    @IBAction func btnAddEmotionClicked(_ sender: Any) {
       
        filePath = nil
        AnimationActionCreator.instance.CurrentAnimation.AnimationID = -1
        ShowEditExpressionPanel()
    }
    
    
    func LoadAnimationData() {
        
        let db:DB_Local_Store = DB_Local_Store()
       
        AnimationList = db.ReadExpressions(Em_Synth_ID: EmotionScreen.EM_SYNTH_ID, TableName: "EXPRESSIONS")
        
        
//        //Code to delete experimental generated data
//                    let libraryURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first
//                    let EmSynthPath = libraryURL!.appendingPathComponent("Expressions").appendingPathComponent(db.readEmSynth(ByID: EmotionScreen.EM_SYNTH_ID).Name)
//
//                do{
//                    let enumerator =  try FileManager.default.contentsOfDirectory(atPath: EmSynthPath.path)
//
//
//                    for element in enumerator {
//                         // checks the extension
//                         do{
//
//                            var isfound = false
//                            for exp in AnimationList
//                            {
//                                if(element.elementsEqual(exp.Name))
//                                {
//                                    isfound = true
//                                    break
//                                }
//                            }
//
//                            if(isfound == false)
//                            {
//                                try FileManager.default.removeItem(atPath: EmSynthPath.appendingPathComponent(element).path)
//                            }
//                         } catch
//                         {
//                            print(error)
//                        }
//
//                    }
//                } catch
//                {
//                    print(error)
//                }
        
       // AnimationList.
    }
}


extension EmotionScreen: UITableViewDataSource, UITableViewDelegate
{
    func SetEmotionListAsViewContext()
    {

        tblAnimationList.dataSource = self
        tblAnimationList.delegate = self
//
//        ContextView.addSubview(tblAnimationList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnimationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("EmotionListItemView",owner:self,options:nil)?.first as! EmotionListItemView
        
        cell.lblName.text = AnimationList[indexPath.row].Name
        
        cell.JoyColor.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x00FF00, alpha: AnimationList[indexPath.row].JOY)
        
        cell.SadColor.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x000000, alpha: AnimationList[indexPath.row].SADNESS)
        
        cell.AngerColor.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xFF0000, alpha: AnimationList[indexPath.row].ANGER)
        
        cell.DisgustColor.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x00FFFF, alpha: AnimationList[indexPath.row].DISGUST)
        
        cell.FearColor.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0xFFFF00, alpha: AnimationList[indexPath.row].FEAR)
        
        cell.SurpriseColor.backgroundColor = FMUnitConvertor.UIColorFromRGB(rgbValue: 0x0000FF, alpha: AnimationList[indexPath.row].SURPRISE)
        
        
        return cell
    }
    

    func AnimateAtIndexPath(indexPath: IndexPath)
    {
        //  AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json: AnimationList[indexPath.row].Action_Data.parseJSONString ass! NSMutableDictionary)
        
        
        
        let db:DB_Local_Store = DB_Local_Store()
        let EmSynthObject = db.readEmSynth(ByID: EmotionScreen.EM_SYNTH_ID)
        
        var MusicFilePath = ""
        if(AnimationList[indexPath.row].SOUND_LIBRARY_ID.isEmpty == false)
        {
            MusicFilePath =  FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+AnimationList[indexPath.row].Name).appendingPathComponent("audio").appendingPathComponent(AnimationList[indexPath.row].SOUND_LIBRARY_ID).path
        }
        
        
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowBrowsedAnimation(ActionData: AnimationList[indexPath.row].Action_Data, MusicFile: MusicFilePath)
        
        AnimationActionCreator.instance.CurrentAnimation.Sound_ID = MusicFilePath
        
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.JOY] = AnimationList[indexPath.row].JOY
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SURPRISE] = AnimationList[indexPath.row].SURPRISE
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.FEAR] = AnimationList[indexPath.row].FEAR
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.SADNESS] = AnimationList[indexPath.row].SADNESS
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.ANGER] = AnimationList[indexPath.row].ANGER
        AnimationActionCreator.instance.CurrentAnimation.Emotion.EmotionData[EmotionEnums.Emotions.DISGUST] = AnimationList[indexPath.row].DISGUST
        
        
        _ = db.saveInContext(Data: DataContext(key: DB_Table_Columns.DBCONTEXT_KEYS.EMOTION_NAME.rawValue, value:String(AnimationList[indexPath.row].Name)))
        
        AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json:  AnimationList[indexPath.row].Action_Data?.parseJSONString as! NSDictionary)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AnimateAtIndexPath(indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let db:DB_Local_Store = DB_Local_Store()
            
            _ = db.DeleteExpression(ID: self.AnimationList[indexPath.row].ID)
            
            do
            {
                let dbHAndler = DB_Local_Store()
                
                let EmSynthObject = dbHAndler.readEmSynth(ByID: EmotionScreen.EM_SYNTH_ID)
                
                
                try FileManager.default.removeItem(at: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EmSynthObject.Name+"/"+self.AnimationList[indexPath.row].Name))
            }
            catch
            {
                print(error)
            }
            
            
            self.AnimationList.remove(at: indexPath.row)
            self.tblAnimationList.reloadData()
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
            AnimationActionCreator.instance.CurrentAnimation.AnimationID = self.AnimationList[indexPath.row].ID
            self.ShowEditExpressionPanel()
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if(AnimationList[indexPath.row].EM_SYNTH_ID == DB_Table_Columns.DEFAULT_EM_SYNTH_ID)
        {
            if(indexPath.row > 40)
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return true
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //animates the cell as it is being displayed for the first time
        //        cell.transform = CGAffineTransform(translationX: 0, y: tableView.rowHeight/2)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        //        UIView.animate(withDuration: 0.8, delay: 0.0, options: [.curveEaseOut], animations: {
        //            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        //
        //        }, completion: { (finished: Bool) in
        //
        //        })
        
        
    }
    
    
}



