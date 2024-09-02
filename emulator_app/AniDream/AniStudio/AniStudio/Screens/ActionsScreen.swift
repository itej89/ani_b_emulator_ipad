//
//  ActionsScreen.swift
//  AniStudio
//
//  Created by Tej Kiran on 27/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit
import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_DB
import FourierMachines_Ani_Client_System

class ActionsScreen: UIViewController, HomeScreenChildProtocol, DialogDataNotify
{
    var NewActName:String!
    var filePath:URL!
    
    var mp3files:[URL]!
    
     var homeScreenProtocol:HomeScreenProtocol!
    //HomeScreenChildProtocol
    func SetHomeScreen(HomeScreen: HomeScreenProtocol) {
         homeScreenProtocol = HomeScreen
    }
    
    @IBAction func AddAct(_ sender: Any) {
        
        if(DialogManager.Instance.delDialogRequest != nil)
        {
            // Get the document directory url
            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            do {
                // Get the directory contents urls (including subfolders urls)
                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl.appendingPathComponent("Choreogram"), includingPropertiesForKeys: nil, options: [])
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
    
    var ActsList:[ACTS] = [ACTS]()
    
    @IBOutlet weak var tblActList: UITableView!
    
    //End of HomeScreenChildProtocol
    @IBAction func btnClose_Click(_ sender: Any) {
        if(homeScreenProtocol != nil)
        {
            homeScreenProtocol.GoBack(Screen: HOME_SCREEN_TYPE.ACT)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DialogManager.Instance.delTextDialogNotify = self
        SetActsListAsViewContext()
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.LoadActionData()
            DispatchQueue.main.async {
                self.tblActList.reloadData()
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
  
    func LoadActionData() {
        
        let db:DB_Local_Store = DB_Local_Store()
     
        ActsList = db.ReadActs(TableName: "ACTS")
        
        //Code to delete experimental generated data
//            let libraryURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first
//            let ActPath = libraryURL!.appendingPathComponent("Acts")
//        do{
//            let enumerator =  try FileManager.default.contentsOfDirectory(atPath: ActPath.path)
//
//
//            for element in enumerator {
//                 // checks the extension
//                 do{
//
//                    var isfound = false
//                    for act in ActsList
//                    {
//                        if(element.elementsEqual(act.Name))
//                        {
//                            isfound = true
//                            break
//                        }
//                    }
//
//                    if(isfound == false)
//                    {
//                        try FileManager.default.removeItem(atPath: ActPath.appendingPathComponent(element).path)
//                    }
//                 } catch
//                 {
//                    print(error)
//                }
//
//            }
//        } catch
//        {
//            print(error)
//        }
        
        // AnimationList.
    }
    
    //DialogDataNotify
    func ItemUtilityButtonClicked(index: Int) {
        
    }
    
    public func ValidateText(text: String) -> (Bool, String) {
        
        if ActsList.first(where: { $0.Name == text }) != nil
        {
            return (false, "Name already exists ⃰")
        }
        
        return (true, "")
    }
    
    public func TextEntered(text:String)
    {
        if(text != "")
        {
            NewActName = text
            let dbHAndler = DB_Local_Store()
            
            do
            {
                try FileManager.default.createDirectory(atPath: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+NewActName+"/audio").path, withIntermediateDirectories: true, attributes: nil)
               
                try FileManager.default.copyItem(at: filePath, to: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+NewActName+"/audio/"+filePath.pathComponents.last!))
            }
            catch
            {
                print(error)
            }
            
            let act = ACTS(name: NewActName, audio: filePath.pathComponents.last!)
            _ = dbHAndler.saveAct(Data: act)
            act.ID = dbHAndler.GetLastActID()
            ActsList.append(act)
            DispatchQueue.main.async {
                self.tblActList.reloadData()
            }
        }
    }
    
    func bytesFromFile(filePath: String) -> String? {
        
        guard let data = NSData(contentsOfFile: filePath) else { return nil }
        
       return  data.base64EncodedString()
        
    }
    
    public func ItemSelected(index: Int) {
        
        filePath = mp3files?[index]
        
        if(DialogManager.Instance.delDialogRequest != nil)
        {
            DialogManager.Instance.delDialogRequest.ShowTextDialog(placeholderText: "Enter the Act Name")
        }
    }
    //End of DialogDataNotify
}


extension ActionsScreen: UITableViewDataSource, UITableViewDelegate
{
    func SetActsListAsViewContext()
    {
        
        tblActList.dataSource = self
        tblActList.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ActsListItemView",owner:self,options:nil)?.first as! ActsListItemView
        
        cell.lblName.text = ActsList[indexPath.row].Name
        cell.lblName.tag = ActsList[indexPath.row].ID
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let db:DB_Local_Store = DB_Local_Store()
            _ = db.DeleteBeatByActID(ACT_ID: ActsList[indexPath.row].ID)
            _ = db.DeleteAct(ID: ActsList[indexPath.row].ID)
            do
            {
                try FileManager.default.removeItem(at: FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts").appendingPathComponent(ActsList[indexPath.row].Name))
            }
            catch
            {
                print(error)
            }
            ActsList.remove(at: indexPath.row)
            tblActList.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(homeScreenProtocol != nil)
        {
            let db:DB_Local_Store = DB_Local_Store()
            _ = db.saveInContext(Data: DataContext(key: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue, value:String(ActsList[indexPath.row].ID)))
            BeatsScreen.ACTID = ActsList[indexPath.row].ID
            homeScreenProtocol.LoadScreen(Screen: HOME_SCREEN_TYPE.BEAT)
        }
//         UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowBrowsedAnimation(ActionData: ActsList[indexPath.row].Act_Id)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    
}

