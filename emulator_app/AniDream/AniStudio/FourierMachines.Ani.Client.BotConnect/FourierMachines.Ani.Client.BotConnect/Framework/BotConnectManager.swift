//
//  BotConnectManager.swift
//  FourierMachines.Ani.Client.BotConnect
//
//  Created by Tej Kiran on 11/08/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_BOIP

public class BotConnectManager: DOIPContextConvey, DOIPContextResultConvey
{
   
    //DOIPContextConvey
    public func FoundDOIPEntity(Entity: DOIPEntity) {
        if(ScanRetryTimer != nil)
        {
            if  Bots.contains(where: { $0.Name.IPAddress == Entity.IPAddress })
            {
                Bots.first(where: {$0.Name.IPAddress == Entity.IPAddress })?.IsResponded = true
            }
            else
            {
                let bot = BotDetails()
                bot.Name = Entity
                bot.IsResponded = true
                Bots.append(bot)
                if(botDelegate != nil)
                {
                    botDelegate.DiscoveredBots(Bots: Bots)
                }
            }
        }
    }
    
    public func UDSResponseRecieved(response:[UInt8]) {
        let strFrame = String(bytes: response, encoding: .utf8)
        
        let rxFrameParser = RxFrameParser()
        if(strFrame != nil && strFrame != "")
        {
            let state = rxFrameParser.GetBaseFrame(Json: strFrame!)
            if(state.0 != ANIMSG.NA)
            {
                FrameRecieved(FrameType:state.1.jANIMSG, Json: strFrame!)
            }
        }
    }
    //DOIPContextConvey
    
    //DOIPContextResultConvey
    public func InitializeResultNotify(result: Int) {
        
    }
    
    public func UDSSendResultNotify(result: Int) {
        
    }
    
    public func LinkDisconnected() {
        if ConnectedBot != nil
        {
            Bots.first(where: { $0.Name.IPAddress == ConnectedBot.Name.IPAddress })?.IsConnected = false
            if(botDelegate != nil)
            {
                botDelegate.DiscoveredBots(Bots: Bots)
            }
            botDelegate.BotDisconnected(_ID: "")
            ConnectedBot = nil
        }
    }
    public func LinkConnected(EndPoint:IPEndPoint) {
        
        if(BotConnectTimeout != nil)
        {
            BotConnectTimeout.invalidate()
        }
        
        if botDelegate != nil
        {
            if(Bots.contains(where: { $0.Name.IPAddress == EndPoint.IPAddress }))
            {
                self.Bots.first(where: {$0.Name.IPAddress == EndPoint.IPAddress })?.IsConnected = true
                ConnectedBot = self.Bots.first(where: {$0.Name.IPAddress == EndPoint.IPAddress })
            }
        }
        
        ResumeScan()
    }
    //End of DOIPContextResultConvey
    
    var botDelegate:BotConnectConvey!
    
    
    public func FrameRecieved(FrameType:ANIMSG, Json:String) {
        let rxFrameParser = RxFrameParser()
        let state = rxFrameParser.GetRxObject(Json: Json)
        switch FrameType {
        case ANIMSG.CATEGORY_ACK:
            if((state.1 as! CATEGORY_ACK).jACK == ACK.OK)
            {
                if(CategoryFrameID == (state.1 as! CATEGORY_ACK ).FRAME_ID)
                {
              
                    
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.CATEGORY_ACK)
                    }
                }
                else
                {
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                    }
                }
            }
            else
            {
                if botDelegate != nil
                {
                    botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                }
            }
            break
        case ANIMSG.COMMAND_ACK:
            if((state.1 as! COMMAND_ACK).jACK == ACK.OK)
            {
                if(CommandAckFrameID == (state.1 as! COMMAND_ACK ).FRAME_ID)
                {
                
                    
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.COMMAND_ACK)
                    }
                }
                else
                {
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                    }
                }
            }
            else
            {
                if botDelegate != nil
                {
                    botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                }
            }
            break
        case ANIMSG.DATA_ACK:
            
           
            if((state.1 as! DATA_ACK).jACK == ACK.OK)
            {
                if(DataFrameID == (state.1 as! DATA_ACK ).FRAME_ID)
                {
               
                    
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.SENDDATA_ACK)
                    }
                }
                else
                {
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                    }
                }
            }
            else
            {
                if botDelegate != nil
                {
                    botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                }
            }
            break
        case ANIMSG.REQEST_UPLOAD_ACK:
            if((state.1 as! REQEST_UPLOAD_ACK).jACK == ACK.OK)
            {
                if(ReqUploadFrameID == (state.1 as! REQEST_UPLOAD_ACK ).FRAME_ID )
                {
            
                    
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.REQUP_ACK)
                    }
                }
                else
                {
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                    }
                }
            }
            else
            {
                if botDelegate != nil
                {
                    botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                }
            }
            break
        case ANIMSG.UPLOAD_END_ACK:
            if((state.1 as! UPLOAD_END_ACK).jACK == ACK.OK)
            {
                if(ExUploadFrameID == (state.1 as! UPLOAD_END_ACK ).FRAME_ID )
                {
            
                    
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.EXREQ_ACK)
                    }
                }
                else
                {
                    if botDelegate != nil
                    {
                        botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                    }
                }
            }
            else
            {
                if botDelegate != nil
                {
                    botDelegate.BotError(Error: BotConnectionInfo.ERROR)
                }
            }
            break
        default:
            break
            
        }
    }
    

    
    
    var Bots:[BotDetails] = []
    var ScanRetryTimer:Timer!
   
    
    
    var ConnectedBot:BotDetails!
    var BotConnectTimeout:Timer!
   
    
    
    var CategoryFrameID = ""
    var CommandAckFrameID = ""
    var DataFrameID = ""
    var ReqUploadFrameID = ""
    var ExUploadFrameID = ""
    
  
    var IsInitialized = false
    
   func Initialize()
   {
    let result = DOIPAccessImplementation.Instance.Initialize(ContextConvey: self, ResultConvey: self)
      IsInitialized = result
    }
    
    
    func UnInitialize()
    {
        IsInitialized = false
        DOIPAccessImplementation.Instance.Uninitialize()
    }
   
    
    @objc func SendScanFrame() {
      
       // var i = 0
 //       while(i < Bots.count)
   //     {
//            if(!Bots[i].IsResponded)
//            {
//                Bots.remove(at: i)
//                i = i - 1
//            }
//            i = i + 1
//        }
//
        
//
//        for bot in Bots
//        {
//            if(!bot.IsConnected)
//            {
//                bot.IsResponded = false
//            }
//        }
            
         _ = DOIPAccessImplementation.Instance.SendScan()
        
    }
    
    public func StartBotScanBroadCastMessage()
    {
        if(ScanRetryTimer != nil)
        {
            ScanRetryTimer.invalidate()
        }
//        for bot in Bots
//        {
//            if(!bot.IsConnected)
//            {
//                bot.IsResponded = false
//            }
//        }
       
       ResumeScan()
    }
    
    public func ResumeScan()
    {
        Bots.removeAll()
        
        if ConnectedBot != nil
        {
            Bots.append(ConnectedBot)
            if(botDelegate != nil)
           {
               botDelegate.DiscoveredBots(Bots: Bots)
           }
        }
        
        SendScanFrame()
       
        DispatchQueue.main.async() {
            self.ScanRetryTimer = Timer.scheduledTimer(timeInterval: 2, target: self,   selector: (#selector(self.SendScanFrame)), userInfo: nil, repeats: true)
        }
        
    }
    
    public func StopBotScanBroadCastMessage()
    {
        if ScanRetryTimer != nil
        {
            ScanRetryTimer.invalidate()
            ScanRetryTimer = nil
        }
    }
    
    @objc func BotConnectFailed()
    {
       StartBotScanBroadCastMessage()
    }
    
    public func BeginConnectToBot(_ID:String)
    {
        StopBotScanBroadCastMessage()
       _ = DOIPAccessImplementation.Instance.Connect(Entity: Bots.first(where: { $0.Name.IPAddress == _ID })!.Name)
   
            BotConnectTimeout = Timer.scheduledTimer(timeInterval: 30, target: self,   selector: (#selector(self.BotConnectFailed)), userInfo: nil, repeats: false)
    }
    
    public func BeginDisconnectBot()
    {
            if ConnectedBot != nil
            {
               DOIPAccessImplementation.Instance.Disconnect()
                
                if(Bots.count > 0 && Bots.first(where: { $0.Name.IPAddress == ConnectedBot.Name.IPAddress }) != nil)
                {
                    Bots.first(where: { $0.Name.IPAddress == ConnectedBot.Name.IPAddress })?.IsConnected = false
                }
                
                if(botDelegate != nil)
                {
                    botDelegate.DiscoveredBots(Bots: Bots)
                }
                ConnectedBot = nil
            }
    }
    

    
    public let ID =  UUID().uuidString
    public let NAME =  "Ani_Studio"+UUID().uuidString
    
    
    //MqttAccess
    public func SetANIActionMode(_CATEGORY: CATEGORY_TYPES) {
        let que = DispatchQueue(label: "", qos: .utility)
        que.async {
            if(self.ConnectedBot != nil)
            {
                let TxFrame = CATEGORY(_ID: self.ID, _TYPE: _CATEGORY)
                _ = DOIPAccessImplementation.Instance.SendData(Data: Array(TxFrame.Json().utf8))
                self.CategoryFrameID = TxFrame.FRAME_ID
            }}
    }
    
    public func RequestUpload( _Count: Int, _MD5: String)
    {
        let que = DispatchQueue(label: "", qos: .utility)
        que.async {
            if(self.ConnectedBot != nil)
            {
                let TxFrame = REQEST_UPLOAD(_ID: self.ID, _CHUNKCount: _Count,_MD5: _MD5)
                _ = DOIPAccessImplementation.Instance.SendData(Data: Array(TxFrame.Json().utf8))
                self.ReqUploadFrameID =  TxFrame.FRAME_ID
            }}
    }
    
    public func SendData( _CATEGORY: CATEGORY_TYPES, _Data: [UInt8], _Block_Count:Int)  {
     
            if(self.ConnectedBot != nil)
            {
                let TxFrame = DATA(_ID: self.ID, _TYPE: _CATEGORY,_DATA: _Data, _BLOCK_COUNT:_Block_Count)
                let data = Array(TxFrame.Json().utf8)
                
                _ = DOIPAccessImplementation.Instance.SendData(Data: data)
                
             self.DataFrameID = TxFrame.FRAME_ID
                
            }
    }
    
    public func ExitUpload()
    { let que = DispatchQueue(label: "", qos: .utility)
        que.async {
            if(self.ConnectedBot != nil)
            {
                let TxFrame = UPLOAD_END(_ID: self.ID)
                _ = DOIPAccessImplementation.Instance.SendData(Data: Array(TxFrame.Json().utf8))
                self.ExUploadFrameID = TxFrame.FRAME_ID
            }}
    }
    
    public func SendCommand( _CATEGORY: CATEGORY_TYPES, _COMMAND: COMMAND_TYPES) {
        let que = DispatchQueue(label: "", qos: .utility)
        que.async {
            if(self.ConnectedBot != nil)
            {
                let TxFrame = COMMAND(_ID: self.ID, _TYPE: _CATEGORY,_COMMAND: _COMMAND)
                _ = DOIPAccessImplementation.Instance.SendData(Data: Array(TxFrame.Json().utf8))
                self.CommandAckFrameID = TxFrame.FRAME_ID
            }}
    }
    //End of MqttAccess
    
}
