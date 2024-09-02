//
//  EmSynthScreen.swift
//  AniDream
//
//  Created by Tej Kiran on 28/02/20.
//  Copyright © 2020 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_DB

 class EmSynthScreen:UIViewController,HomeScreenChildProtocol, DialogDataNotify
{
    var homeScreenProtocol:HomeScreenProtocol!
    
    @IBOutlet weak var tblAnimationList: UITableView!
    
    
    
    //DialogDataNotify
     func ItemUtilityButtonClicked(index: Int) {
        
    }
    
    public func ValidateText(text: String) -> (Bool, String) {
        let db:DB_Local_Store = DB_Local_Store()
        let EmSynth = db.readEmSynth(ByName: text)
        if EmSynth.Name != ""
        {
            return (false, "Name already exists ⃰")
        }
        return (true, "")
    }
    
    public func TextEntered(text:String)
    {
        if(text != "")
        {
            let dbHAndler = DB_Local_Store()
            let EmSynth = EM_SYNTH(name: text)
            
            _ = dbHAndler.saveEmSynth(Data: EmSynth)
            
            EmSynth.ID = dbHAndler.GetLastEmSynthID()
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.AnimationList.append(EmSynth)
                DispatchQueue.main.async {
                    self.tblAnimationList.reloadData()
                    
                }
            }
            
        }
        
        
    }
    public func ItemSelected(index: Int) {
        
    }
    //End of DialogDataNotify
    

    
    //HomeScreenChildProtocol
    func SetHomeScreen(HomeScreen : HomeScreenProtocol)
    {
        homeScreenProtocol = HomeScreen
    }
    //End of HomeScreenChildProtocol
    
    
    @IBAction func btnAddEmSynthClicked(_ sender: Any) {
        
        if(DialogManager.Instance.delDialogRequest != nil)
        {
            DialogManager.Instance.delDialogRequest.ShowTextDialog(placeholderText: "Enter the Attitude Name")
        }
        
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        if(homeScreenProtocol != nil)
        {
            homeScreenProtocol.GoBack(Screen: HOME_SCREEN_TYPE.EMSYNTH)
        }
    }
    
    
    var AnimationList:[EM_SYNTH] = [EM_SYNTH]()
    
    @IBOutlet weak var ContextView: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetEmSynthListAsViewContext()
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
    

    
    
    func LoadAnimationData() {
        
        let db:DB_Local_Store = DB_Local_Store()
        
        AnimationList = db.ReadAllEM_SYNTH(TableName: "EM_SYNTH")
        
        //Code to delete experimental generated data
//        let libraryURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first
//        let EmSynthPath = libraryURL!.appendingPathComponent("Expressions")
//
//        do{
//            let enumerator =  try FileManager.default.contentsOfDirectory(atPath: EmSynthPath.path)
//
//
//            for element in enumerator {
//                // checks the extension
//                do{
//
//                    var isfound = false
//                    for exp in AnimationList
//                    {
//                        if(element.elementsEqual(exp.Name))
//                        {
//                            isfound = true
//                            break
//                        }
//                    }
//
//                    if(isfound == false)
//                    {
//                        try FileManager.default.removeItem(atPath: EmSynthPath.appendingPathComponent(element).path)
//                    }
//                } catch
//                {
//                    print(error)
//                }
//                
//            }
//        } catch
//        {
//            print(error)
//        }
        // EmSynthList.
    }
}


extension EmSynthScreen: UITableViewDataSource, UITableViewDelegate
{
    func SetEmSynthListAsViewContext()
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
        let cell = Bundle.main.loadNibNamed("EmSynthListItemView",owner:self,options:nil)?.first as! EmSynthListItemView
        
        cell.lblName.text = AnimationList[indexPath.row].Name
        cell.lblName.tag = AnimationList[indexPath.row].ID
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //        AnimationActionCreator.instance.CurrentAnimation.Position.parseJson(json: AnimationList[indexPath.row].Action_Data.parseJSONString ass! NSMutableDictionary)
        
        if(homeScreenProtocol != nil)
        {
            let db:DB_Local_Store = DB_Local_Store()
            _ = db.saveInContext(Data: DataContext(key: DB_Table_Columns.DBCONTEXT_KEYS.EM_SYNTH_ID.rawValue, value:String(AnimationList[indexPath.row].ID)))
            EmotionScreen.EM_SYNTH_ID = AnimationList[indexPath.row].ID
            homeScreenProtocol.LoadScreen(Screen: HOME_SCREEN_TYPE.EMOTION)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(indexPath.row > 0)
        {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let db:DB_Local_Store = DB_Local_Store()
            
            _ = db.DeleteEmSynth(ID: AnimationList[indexPath.row].ID)
            AnimationList.remove(at: indexPath.row)
            tblAnimationList.reloadData()
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
