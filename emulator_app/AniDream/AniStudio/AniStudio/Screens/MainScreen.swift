//
//  ViewController.swift
//  AniStudio
//
//  Created by Tej Kiran on 14/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit
import SceneKit

import GraphicAnimation
import FourierMachines_Ani_Client_System
import FourierMachines_Ani_Client_BotConnect

class MainScreen: UIViewController, SCNSceneRendererDelegate, UITextFieldDelegate, DialogReqestProtocol, AniUIRead, DialogDataNotify, AniUIConvey , AirDropDelegate{


  
    
    func showSimpleAlert(Path:URL) {
        let alert = UIAlertController(title: "Audio Imported", message: "Please choose project category",  preferredStyle: UIAlertController.Style.alert)
            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        alert.addAction(UIAlertAction(title: "EmSynth", style: UIAlertAction.Style.default, handler: { _ in
            do{
               
                try FileManager.default.createDirectory(atPath: documentsUrl.appendingPathComponent("EmSynth").path, withIntermediateDirectories: true, attributes: nil)
               
                if FileManager.default.fileExists(atPath: documentsUrl.appendingPathComponent("EmSynth").appendingPathComponent(Path.pathComponents.last!).path)
                {
                    try FileManager.default.removeItem(atPath: documentsUrl.appendingPathComponent("EmSynth").appendingPathComponent(Path.pathComponents.last!).path)
                }
                try FileManager.default.moveItem(at: Path, to: documentsUrl.appendingPathComponent("EmSynth").appendingPathComponent(Path.pathComponents.last!))
            }
            catch
            {
                print(error)
            }
        }))
        
        
        alert.addAction(UIAlertAction(title: "Choreogram", style: UIAlertAction.Style.default, handler: { _ in
            do{
                
                try FileManager.default.createDirectory(atPath: documentsUrl.appendingPathComponent("Choreogram").path, withIntermediateDirectories: true, attributes: nil)
                
                if FileManager.default.fileExists(atPath: documentsUrl.appendingPathComponent("Choreogram").appendingPathComponent(Path.pathComponents.last!).path)
                {
                    try FileManager.default.removeItem(atPath: documentsUrl.appendingPathComponent("Choreogram").appendingPathComponent(Path.pathComponents.last!).path)
                }
                
                try FileManager.default.moveItem(at: Path, to: documentsUrl.appendingPathComponent("Choreogram").appendingPathComponent(Path.pathComponents.last!))
            }
            catch
            {
                print(error)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    //AirDropDelegate
    func FileAddedToDocuments(path Path:URL) {
        showSimpleAlert(Path: Path)
    }
    //End of AirDropDelegate
    
    
    //DialogDataNotify
    func ItemUtilityButtonClicked(index: Int) {
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().DisconnectBot()
    }
    
    
    func ValidateText(text: String) -> (Bool, String) {
        return (true, "")
    }
    
    func TextEntered(text: String) {
        
    }
    
    func ItemSelected(index: Int) {
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().ConnectBot(_ID:BotIDs[index])
    }
    //End of DialogDataNotify
    
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicatorContainer: UIView!
    
    var DialogType:DialogTypes = DialogTypes.NA
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var btnBotConnect: UIButton!
    @IBOutlet weak var ImgServerConnectStatus: UIImageView!
    @IBOutlet weak var DialogBackground: UIView!
    var BotIDs:[String] = []
    var dialogDataImgList:[UIImage] = []
    var dialogUtilityName:[String] = []
    var dialogDataList:[String] = []
    var IsScanning = false
    @IBOutlet weak var vwListDialogTitle: UILabel!
    @IBOutlet weak var vwLstTable: UITableView!
    @IBOutlet weak var vwLstDialog: UIView!
    @IBOutlet weak var vwTxtDialog: UIView!
    @IBOutlet weak var vwPrgDialog: UIView!
    
    @IBOutlet weak var txtDialogError: UILabel!
    @IBOutlet var txtDlgBox: UITextField!
   
    @IBOutlet weak var prgDlgBar: UIProgressView!
    @IBOutlet weak var prgDlgTxt: UILabel!
    @IBOutlet weak var prgDlgTitle: UILabel!
    
    var AutoDismissListDialog:Bool = false
    
    @IBAction func txtEdited(_ sender: Any) {
        txtDialogError.text = ""
    }
  
    var DismissDialogCompletion = { (value:Bool) in
        
    }
    
    @objc  func DismissDialog(_ sender:UITapGestureRecognizer){
    
    switch DialogType {
    case .List:
         self.DialogType = DialogTypes.NA
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn,
                       animations: {
                        self.vwLstDialog.transform = self.vwLstDialog.transform.translatedBy(x: 0, y: UIScreen.main.bounds.height/2 * -1)
                        
                        self.DialogBackground.alpha = 0
        },
                       completion: {(value: Bool) in
                        self.dialogDataImgList = []
                        self.dialogDataList = []
                        self.dialogUtilityName = []
                        self.vwLstTable.reloadData()
                        
                        let Completion = self.DismissDialogCompletion
                        
                        self.DismissDialogCompletion = { (value:Bool) in
                            
                        }
                        
                        Completion(true)
                     
        }
        )
        break
    case .Text:
         self.DialogType = DialogTypes.NA
         self.txtDlgBox.endEditing(true)
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn,
                       animations: {
                        
                        self.vwTxtDialog.transform = self.vwTxtDialog.transform.translatedBy(x: 0, y: -80)
                        self.DialogBackground.alpha = 0;
        },
                       completion: {(value: Bool) in
                        
                        self.txtDlgBox.text = ""
                        let Completion = self.DismissDialogCompletion
                        
                        self.DismissDialogCompletion = { (value:Bool) in
                            
                        }
                        
                        Completion(true)
        }
        )
        break
    default:
        
        let Completion = DismissDialogCompletion
        
        self.DismissDialogCompletion = { (value:Bool) in
            
        }
        
        Completion(true)
        
        break
        
    }
    
   
    }
    
    //TextDialogReqestProtocol
    public func ProgressDialogSetProgress(percent:Float)
    {
        if(DialogType == .Progress)
        {
            DispatchQueue.main.async() {
                self.prgDlgTxt.text = String(Int(percent)) + "%"
                self.prgDlgBar.progress = percent/100
            }
            
        }
    }
    
    public func DismissProgressDialog()
    {
        if(DialogType == .Progress)
        {
        self.DialogType = DialogTypes.NA
             DispatchQueue.main.async() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn,
                       animations: {
                        
                        self.vwPrgDialog.transform = self.vwPrgDialog.transform.translatedBy(x: 0, y: -80)
                        self.DialogBackground.alpha = 0;
        },
                       completion: {(value: Bool) in
                        
                        self.prgDlgTitle.text = ""
                        self.prgDlgTxt.text = ""
                        self.prgDlgBar.progress = 0
                        let Completion = self.DismissDialogCompletion
                        
                        self.DismissDialogCompletion = { (value:Bool) in
                            
                        }
                        
                        Completion(true)
        }
        )
            }
        }
    }
    
    public func ShowProgressDialog(title:String)
    {
        if(DialogType == .Progress)
        {
            prgDlgTitle.text = title
            return
        }
        self.DialogType = DialogTypes.Progress
        prgDlgTitle.text = title
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut,
                       animations: {
                        self.vwPrgDialog.transform = self.vwPrgDialog.transform.translatedBy(x: 0, y: 80)
                        self.DialogBackground.alpha = 0.7;
        },
                       completion: {(value: Bool) in
        }
        )
    }
    
    
    public func ShowTextDialogWithText(Text:String)
    {
        if(DialogType == .Text)
        {
            txtDlgBox.text = Text
            return
        }
        self.DialogType = DialogTypes.Text
        txtDlgBox.text = Text
        self.txtDlgBox.becomeFirstResponder()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut,
                       animations: {
                        self.vwTxtDialog.transform = self.vwTxtDialog.transform.translatedBy(x: 0, y: 80)
                        self.DialogBackground.alpha = 0.7;
        },
                       completion: {(value: Bool) in
                        
                        
        }
        )
    }
    
    
    public func ShowTextDialog(placeholderText:String)
    {
        if(DialogType == .Text)
        {
            txtDlgBox.placeholder = placeholderText
            return
        }
         self.DialogType = DialogTypes.Text
        txtDlgBox.placeholder = placeholderText
         self.txtDlgBox.becomeFirstResponder()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut,
                       animations: {
                self.vwTxtDialog.transform = self.vwTxtDialog.transform.translatedBy(x: 0, y: 80)
                        self.DialogBackground.alpha = 0.7;
        },
                       completion: {(value: Bool) in
                        
                       
        }
        )
    }
    
  
    
    func ShowListDialog(title:String, data:[String], DismissOnSelection:Bool)
    {
        AutoDismissListDialog = DismissOnSelection
        if(DialogType == .List)
        {
            self.dialogDataList = data
            self.vwLstTable.reloadData()
            return
        }
        else
        {
         self.DialogType = DialogTypes.List
        vwListDialogTitle.text = title
        
        self.dialogDataList = data
        self.vwLstTable.reloadData()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut,
                       animations: {
                        self.vwLstDialog.transform = self.vwLstDialog.transform.translatedBy(x: 0, y: UIScreen.main.bounds.height/2)
                        
                         self.DialogBackground.alpha = 0.7;
        },
                       completion: {(value: Bool) in
                        
                       
        }
        )
        }
        
    }
    //End TextDialogReqestProtocol
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        let EnteredText = self.txtDlgBox.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(DialogManager.Instance.delTextDialogNotify != nil)
        {
            let status = DialogManager.Instance.delTextDialogNotify.ValidateText(text: EnteredText ?? "")
            
            if status.0 == false
            {
                txtDialogError.text = status.1
                return false
            }
            
        }
        self.txtDlgBox.endEditing(true)
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn,
                       animations: {
                        
                        self.vwTxtDialog.transform = self.vwTxtDialog.transform.translatedBy(x: 0, y: -80)
                         self.DialogBackground.alpha = 0;
        },
                       completion: {(value: Bool) in
                        
                        if(DialogManager.Instance.delTextDialogNotify != nil)
                        {
                            DialogManager.Instance.delTextDialogNotify.TextEntered(text: EnteredText ?? "")
                        }
                         self.DialogType = DialogTypes.NA
                        self.txtDlgBox.text = ""
                        
        }
        )
        return false
    }
    
    //AniUIRead
    func GetAllUIElements() -> [AnimationObject:SCNNode] {
        return GraphicNodes
    }
    //End of AniUIRead
    
    //AniUIConvey
    func BotsDiscovered(Bots: [BotDetails]) {
        DispatchQueue.main.async() {
        var names:[String] = []
            self.BotIDs.removeAll()
            self.dialogDataImgList.removeAll()
            self.dialogUtilityName.removeAll()
        var IsConnected = false
        for bot in Bots
        {
            if(bot.IsConnected)
            {
                IsConnected = true
                self.dialogDataImgList.append(UIImage(named: "Connected")!)
                self.dialogUtilityName.append("Disconnect")
            }
            else
            {
                self.dialogDataImgList.append(UIImage(named: "Disconnected")!)
                self.dialogUtilityName.append("")
            }
            self.BotIDs.append(bot.Name.IPAddress)
            names.append(String(bytes: bot.Name.VIN, encoding: .utf8)!)
        }
        
        if(IsConnected)
        {
            
                self.ImgServerConnectStatus.image = UIImage(named: "Connected")
            
        }
        else
        {
         
                self.ImgServerConnectStatus.image = UIImage(named: "Disconnected")
            
        }
            if(self.IsScanning)
        {
            DialogManager.Instance.delDialogRequest.ShowListDialog(title: "Scanning for Bots...", data: names, DismissOnSelection:false)
        }
        }
    }
    
    func BotServerStateChanged(state: Bool) {
        if state
        {
        ImgServerConnectStatus.image = UIImage(named: "ServerConnected")
        }
        else
        {
            ImgServerConnectStatus.image = UIImage(named: "ServerDisconnected")
        }
        
    }
    //End of AniUIConvey
    
   
    var GraphicNodes:[AnimationObject:SCNNode] = [:]
    
    @IBOutlet weak var cntnrView: UIView!
    @IBOutlet weak var simuView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        simuView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.airDropDelegate = self
        
        vwTxtDialog.transform = vwTxtDialog.transform.translatedBy(x: 0, y: -80)
          vwLstDialog.transform = vwLstDialog.transform.translatedBy(x: 0, y: UIScreen.main.bounds.height/2 * -1)
          vwPrgDialog.transform = vwPrgDialog.transform.translatedBy(x: 0, y: -80)
        
        SetDialogListViewContext()
        txtDlgBox.delegate = self
        DialogManager.Instance.delDialogRequest = self
        
         let gesture = UITapGestureRecognizer(target: self, action: #selector(self.DismissDialog(_:)))
        
        DialogBackground.addGestureRecognizer(gesture)
        
        // Show statistics such as fps and timing information
        simuView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/AniStudio_Blender_Height_Adjested.dae")!
        
        
        scene.background.contents = UIImage(named: "bkggrey.jpg")
        
        // Set the scene to the view
        simuView.scene = scene
        

        GraphicNodes[AnimationObject.Motor_Turn_Graphic] = simuView.scene?.rootNode.childNodes[2].childNodes[0]
        GraphicNodes[AnimationObject.Motor_Lift_Graphic] = GraphicNodes[AnimationObject.Motor_Turn_Graphic]?.childNodes[0]
        GraphicNodes[AnimationObject.Motor_Lean_Graphic] = GraphicNodes[AnimationObject.Motor_Lift_Graphic]?.childNodes[0]
        GraphicNodes[AnimationObject.Motor_Tilt_Graphic] = GraphicNodes[AnimationObject.Motor_Lean_Graphic]?.childNodes[0]
        
        let Face = GraphicNodes[AnimationObject.Motor_Tilt_Graphic]?.childNodes[0]
        
        GraphicNodes[AnimationObject.Image_EyeBrowLeft] = Face?.childNodes[0]
        GraphicNodes[AnimationObject.Image_EyeLidLeft] = Face?.childNodes[1]
        GraphicNodes[AnimationObject.Image_EyeLeft] = Face?.childNodes[2]
        GraphicNodes[AnimationObject.Image_EyeBallLeft] = Face?.childNodes[3]
        GraphicNodes[AnimationObject.Image_EyePupilLeft] = Face?.childNodes[4]
        GraphicNodes[AnimationObject.Image_EyeBrowRight] = Face?.childNodes[5]
        GraphicNodes[AnimationObject.Image_EyeLidRight] = Face?.childNodes[6]
        GraphicNodes[AnimationObject.Image_EyeRight] = Face?.childNodes[7]
        GraphicNodes[AnimationObject.Image_EyeBallRight] = Face?.childNodes[8]
        GraphicNodes[AnimationObject.Image_EyePupilRight] = Face?.childNodes[9]

        
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Motor_Turn_Graphic, image: GraphicNodes[AnimationObject.Motor_Turn_Graphic]!)

        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Motor_Lift_Graphic, image: GraphicNodes[AnimationObject.Motor_Lift_Graphic]!)

        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Motor_Lean_Graphic, image: GraphicNodes[AnimationObject.Motor_Lean_Graphic]!)

        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Motor_Tilt_Graphic, image: GraphicNodes[AnimationObject.Motor_Tilt_Graphic]!)
        

        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeBrowLeft, image: GraphicNodes[AnimationObject.Image_EyeBrowLeft]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeLidLeft, image: GraphicNodes[AnimationObject.Image_EyeLidLeft]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeLeft, image: GraphicNodes[AnimationObject.Image_EyeLeft]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeBallLeft, image: GraphicNodes[AnimationObject.Image_EyeBallLeft]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyePupilLeft, image: GraphicNodes[AnimationObject.Image_EyePupilLeft]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeBrowRight, image: GraphicNodes[AnimationObject.Image_EyeBrowRight]!)
 
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeLidRight, image: GraphicNodes[AnimationObject.Image_EyeLidRight]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeRight, image: GraphicNodes[AnimationObject.Image_EyeRight]!)

        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyeBallRight, image: GraphicNodes[AnimationObject.Image_EyeBallRight]!)
        
        AnimationActionCreator.instance.updateDefaultState(Tag: AnimationObject.Image_EyePupilRight, image: GraphicNodes[AnimationObject.Image_EyePupilRight]!)
        
        
        UIMAINModuleHandler.Instance.setAniUIHandler(delegate: self)
        UIMAINModuleHandler.Instance.setAniUINotify(delegate: self)
        
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().AppStarted()
        
        simuView.allowsCameraControl = true
        
        simuView.isPlaying = true
        BotConnectionHandler.Instance.ConnectToBroker()
        //let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))
        
        //Add recognizer to sceneview
        //simuView.addGestureRecognizer(tap)
        
    }
    
    @IBAction func btnConnectBot(_ sender: Any) {
        btnBotConnect.isEnabled = false
        if(DialogManager.Instance.delDialogRequest != nil)
        {
                DialogManager.Instance.delTextDialogNotify = self
                DismissDialogCompletion = { (value:Bool) in
                
                self.IsScanning = true

                var bots:[String] = []
                let ConenctedBot:BotDetails! = UIMAINModuleHandler.Instance.GetUIMainConveyListener().GetConnectedBot()
                
                if(ConenctedBot != nil)
                {
                    bots.append(String(bytes: ConenctedBot.Name.VIN, encoding: .utf8)!)
                }
                
                    DialogManager.Instance.delDialogRequest.ShowListDialog(title: "Scanning for Bots...", data: bots, DismissOnSelection:false)
                
                
                UIMAINModuleHandler.Instance.GetUIMainConveyListener().ScanBot()
                self.DismissDialogCompletion = { (value:Bool) in
                    self.IsScanning = false
                    UIMAINModuleHandler.Instance.GetUIMainConveyListener().StopBotScan()
                    self.btnBotConnect.isEnabled = true
                }
            }
            DismissDialog(UITapGestureRecognizer())
        }
    }
    
    
    //Method called when tap
    @objc func handleTap(rec: UITapGestureRecognizer){
        
        if rec.state == .ended {
            let location: CGPoint = rec.location(in: simuView)
            let hits = self.simuView.hitTest(location, options: nil)
            if !hits.isEmpty{
                let tappedNode = hits.first?.node
                
                let Node:MODEL_NODE_TYPE = MODEL_NODE_TYPE(rawValue: tappedNode?.name ?? "NA") ?? MODEL_NODE_TYPE.NA
               
                
                let ctrl = children.first(where: { $0 is MainScreenEventProtocol })
                if(ctrl != nil)
                {
                    (ctrl as! MainScreenEventProtocol).NodeTouched(Node: Node)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func ShowActivityIndicator()
    {
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.style = UIActivityIndicatorView.Style.white
        activityIndicator.color = UIColor(red: 0xBD, green: 0xCA, blue: 0xC7, alpha: 1)
        self.view.addSubview(activityIndicator)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.loadingView.alpha = 1.0
        }, completion: nil)
       
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.startAnimating()
    }
    
    func CloseActivityIndicator()
    {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.loadingView.alpha = 0.0
        },
            completion: nil)
        activityIndicator.stopAnimating()
         UIApplication.shared.endIgnoringInteractionEvents()
    }
}

    
    extension MainScreen: UITableViewDataSource, UITableViewDelegate
    {
        func SetDialogListViewContext()
        {
            vwLstTable.dataSource = self
            vwLstTable.delegate = self
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dialogDataList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Bundle.main.loadNibNamed("DialogListItemView",owner:self,options:nil)?.first as! DialogListItemView
            if(dialogDataImgList.count > indexPath.row)
            {
                cell.imgType.image = dialogDataImgList[indexPath.row]
            }
            
            if(dialogUtilityName.count > indexPath.row)
            {
                if(dialogUtilityName[indexPath.row] != "")
                {
                    cell.btnUtility.setTitle(dialogUtilityName[indexPath.row], for: UIControl.State.normal)
                     cell.btnUtility.isHidden = false
                    cell.btnUtility.tag = indexPath.row
                    cell.btnUtility.addTarget(self, action:  #selector(btnUtilityClicked), for: .touchUpInside)
                }
                else
                {
                    cell.btnUtility.setTitle("", for: UIControl.State.normal)
                    cell.btnUtility.isHidden = true
                }
            }
            else
            {
                cell.btnUtility.setTitle("", for: UIControl.State.normal)
                cell.btnUtility.isHidden = true
            }
            
            cell.lblName.text = dialogDataList[indexPath.row]
            cell.lblName.tag = indexPath.row
       
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if(AutoDismissListDialog)
            {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn,
                           animations: {
                            self.vwLstDialog.transform = self.vwLstDialog.transform.translatedBy(x: 0, y: UIScreen.main.bounds.height/2 * -1)
                            self.DialogBackground.alpha = 0;
            },
                           completion: {(value: Bool) in
                            self.DialogType = DialogTypes.NA
                            if(DialogManager.Instance.delTextDialogNotify != nil)
                            {
                                DialogManager.Instance.delTextDialogNotify.ItemSelected(index: indexPath.row)
                            }
                            self.dialogDataList = []
                            self.vwLstTable.reloadData()
            }
            )
            }
            else
            {
            
                if(DialogManager.Instance.delTextDialogNotify != nil)
               {
                   DialogManager.Instance.delTextDialogNotify.ItemSelected(index: indexPath.row)
               }
            }
//            DialogManager.Instance.delTextDialogNotify.ItemSelected(index: indexPath.row)
            
            
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          
        }
        
        
     @objc  func btnUtilityClicked(sender: AnyObject?)
        {
            DialogManager.Instance.delTextDialogNotify.ItemUtilityButtonClicked(index: sender!.tag)
        }
        

}
