//
//  MQTTStateHandler.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 21/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import FourierMachines_Ani_Client_BotConnect
import FourierMachines_Ani_Client_Common
import FourierMachines_Ani_Client_DB
import Zip


public class BotConnectionHandler:BotConnectConvey
{
    //BotConnectConvey
    public func DiscoveredBots(Bots: [BotDetails]) {
        if(UIMAINModuleHandler.Instance.AniUINotify != nil)
        {
            UIMAINModuleHandler.Instance.AniUINotify.BotsDiscovered(Bots: Bots)
        }
    }
    
    public func BotConnected(_ID: String) {
        
    }
    
    public func BotDisconnected(_ID: String) {
        UIBotUploadHandler.Instance.getBotUploadConvey()?.DismissUploadProgressDialog()
    }
    
    public func BotLowStorage() {
        
    }
    
    public func BotError(Error: BotConnectionInfo) {
        BotUploadSeq(StepInfo: Error)
    }
    
    public func BrokerConenctionChanged(Status: Bool) {
        UIMAINModuleHandler.Instance.AniUINotify.BotServerStateChanged(state: Status)
    }
    //BotConnectConvey
   

    public static let Instance:BotConnectionHandler  = BotConnectionHandler()

   

    private init()
    {
       // BotConnectImplementation.Instance.ConnectToServer(delegate: self)
    }
    
    public func ConnectToBroker()
    {
        BotConnectImplementation.Instance.ConnectToServer(delegate: self)
    }
    
    public func GetConnectedBot() -> BotDetails!
    {
       return BotConnectImplementation.Instance.GetConnectedBot()
    }
    
    public func StartBotScan()
    {
        BotConnectImplementation.Instance.StartScan()
    }
    
    public func StopBotScan()
    {
        BotConnectImplementation.Instance.StopScan()
    }

    public func ConnectToBot(_ID:String)
    {
        BotConnectImplementation.Instance.ConnectToBot(_ID: _ID)
    }
    
    public func DisconnectBot()
    {
        BotConnectImplementation.Instance.DisconnectBot();
    }
    
    public func RunChoreogram()
    {
        BotConnectImplementation.Instance.SendCommand(_CATEGORY: CATEGORY_TYPES.CHOREOGRAM, _COMMAND: COMMAND_TYPES.PLAY_CHOREOGRAM)
    }
    
    public func UploadEmSynth()
    {
        let db:DB_Local_Store = DB_Local_Store()
        
        let EmSynthID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.EM_SYNTH_ID.rawValue)[0]).VALUE)
        
        let EMSYNTH = db.readEmSynth(ByID: EmSynthID!)
        
        let audioURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Expressions/"+EMSYNTH.Name)
        
        //        var audiobytes = [UInt8]()
        //         let audiodata = NSData(contentsOf: audioURL)
        //        {
        //            var buffer = [UInt8](repeating: 0, count: audiodata.length)
        //            audiodata.getBytes(&buffer, length: audiodata.length)
        //            audiobytes = buffer
        //        }
        
        let Expressions:[Expressions_Type] = db.ReadExpressions(Em_Synth_ID: EmSynthID!, TableName: DB_Table_Columns.DBTables.EXPRESSIONS.rawValue)
        
       
        let fileManger =  FileManager.default
        
        let tmpDirectoryPath = fileManger.createTemporaryDirectory()
        
        
        let destinationPath = tmpDirectoryPath?.appendingPathComponent("EmSynth.db")
        
        
        let bundle = Bundle(for: type(of: self))
        if let files = try? FileManager.default.contentsOfDirectory(atPath: bundle.bundlePath ){
            for file in files {
                print(file)
            }
        }
        
        let sourcePath = bundle.url(forResource: "EmSynth", withExtension: "B")
        
        do{
            if fileManger.fileExists(atPath: destinationPath!.absoluteString )
            {
                try fileManger.removeItem(atPath: destinationPath!.absoluteString)
            }
        }
        catch
        {}
        
        do{
            try fileManger.copyItem(at: sourcePath!, to: destinationPath!)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
        let dbHelper = DB_Local_Store(dbPath: destinationPath!.absoluteString)
        
            _ = dbHelper.saveEmSynth(Data: EMSYNTH)
        
        for expression in Expressions
        {
            _ = dbHelper.saveExpression(Data: expression)
        }
        
        do{
            let zipFilePath = try Zip.quickZipFiles([audioURL, destinationPath!], fileName: "EmSynth.B") // Zip
            let data = NSData(contentsOf: zipFilePath)
            if data != nil{
                var buffer = [UInt8](repeating: 0, count: data!.length)
                data!.getBytes(&buffer, length: data!.length)
                Data = buffer
            }
            
            try! fileManger.removeItem(at: zipFilePath)
            
            if(Data.count % ChunkSize == 0)
            {
                TotalChunks = Data.count / ChunkSize
            }
            else
            {
                TotalChunks = (Data.count / ChunkSize) + 1
            }
            
            ChunkCounter = 0;
            ChunkOffset = 0;
            BotConnectImplementation.Instance.SetANIActionMode(_CATEGORY: CATEGORY_TYPES.EMSYNTH)
            
        }
        catch let error as NSError {
            print(error.localizedDescription);
        }
        
        //        let trType:Track_Type = Track_Type( data: audiodata!)
        //        _ = dbHelper.saveTrack(Track: trType)
        
        fileManger.clearTmpDirectory()
    }
    
    public func UploadChoreogram()
    {
        
        let db:DB_Local_Store = DB_Local_Store()
        
        let ActID = Int((db.ReadFromContext(KEY: DB_Table_Columns.DBCONTEXT_KEYS.ACT_ID.rawValue)[0]).VALUE)
        let ACT:[ACTS] = db.ReadActWithID(ID: ActID!)
        
         let audioURL = FileManager.default.urls(for: .libraryDirectory,in: .userDomainMask).first!.appendingPathComponent("Acts/"+ACT[0].Name+"/audio/"+ACT[0].Audio)
        
//        var audiobytes = [UInt8]()
//         let audiodata = NSData(contentsOf: audioURL)
//        {
//            var buffer = [UInt8](repeating: 0, count: audiodata.length)
//            audiodata.getBytes(&buffer, length: audiodata.length)
//            audiobytes = buffer
//        }
       
        let Beats:[Beats_Type] = db.ReadBeats(TableName: DB_Table_Columns.DBTables.BEATS.rawValue, ACT_ID: ActID!)
        
        let sortedBeats  = Beats.sorted{ $0.StartSec < $1.StartSec }
        
        let fileManger =  FileManager.default
        
        let tmpDirectoryPath = fileManger.createTemporaryDirectory()
        
        
        let destinationPath = tmpDirectoryPath?.appendingPathComponent("Choreogram.db")
        
        
        let bundle = Bundle(for: type(of: self))
        if let files = try? FileManager.default.contentsOfDirectory(atPath: bundle.bundlePath ){
            for file in files {
                print(file)
            }
        }
        
        let sourcePath = bundle.url(forResource: "Choreogram", withExtension: "B")
        
        do{
            if fileManger.fileExists(atPath: destinationPath!.absoluteString )
            {
                try fileManger.removeItem(atPath: destinationPath!.absoluteString)
            }
        }
        catch
        {}
        do{
            try fileManger.copyItem(at: sourcePath!, to: destinationPath!)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
        let dbHelper = DB_Local_Store(dbPath: destinationPath!.absoluteString)
        ACT[0].ID = ActID
        _ = dbHelper.saveActWithID(Data: ACT[0])
        
        for beat in sortedBeats
        {
            _ = dbHelper.saveBeat(Data: beat)
        }
        
        do{
        let zipFilePath = try Zip.quickZipFiles([audioURL, destinationPath!], fileName: "Choeragram.B") // Zip
            let data = NSData(contentsOf: zipFilePath)
            if data != nil{
                var buffer = [UInt8](repeating: 0, count: data!.length)
                data!.getBytes(&buffer, length: data!.length)
                Data = buffer
            }
            
            try! fileManger.removeItem(at: zipFilePath)
            
            if(Data.count % ChunkSize == 0)
            {
                TotalChunks = Data.count / ChunkSize
            }
            else
            {
                TotalChunks = (Data.count / ChunkSize) + 1
            }
            
            ChunkCounter = 0;
            ChunkOffset = 0;
            BotConnectImplementation.Instance.SetANIActionMode(_CATEGORY: CATEGORY_TYPES.CHOREOGRAM)
            
        }
        catch let error as NSError {
            print(error.localizedDescription);
        }
        
//        let trType:Track_Type = Track_Type( data: audiodata!)
//        _ = dbHelper.saveTrack(Track: trType)

        fileManger.clearTmpDirectory()
    }
    
    var TotalChunks = 0
    var ChunkCounter = 0;
    var ChunkOffset = 0;
    var ChunkSize = 512000;
    var Data = [UInt8]()
    var FILEMD5 = ""
    var Category = CATEGORY_TYPES.NA
    
    public func BotUploadSeq(StepInfo:BotConnectionInfo)
    {
        switch StepInfo
        {
            case .CATEGORY_ACK:
                 BotConnectImplementation.Instance.RequestUpload(_Count: TotalChunks, _MD5: FILEMD5)
                break
            case .REQUP_ACK:
                let StartIndex = ChunkOffset
                let thisChunkSize = ((Data.count - ChunkOffset) > ChunkSize) ? ChunkSize : (Data.count - ChunkOffset)
                
                if(thisChunkSize > 0)
                {
                  ChunkCounter = ChunkCounter + 1
                    
                    let range  = Data[StartIndex..<StartIndex + thisChunkSize]
                    var _data = [UInt8]()
                    _data.append(contentsOf: range)
                    
                    BotConnectImplementation.Instance.SendData(_CATEGORY: Category, _Data: _data, _Block_Count: ChunkCounter)
                
                ChunkOffset += thisChunkSize;
                }
                break
            case .SENDDATA_ACK:
                
                UIBotUploadHandler.Instance.getBotUploadConvey()?.SetUploadProgress(progress: (Float(ChunkCounter)/Float(TotalChunks) * 100.0))
                let StartIndex = ChunkOffset
                let thisChunkSize = ((Data.count - ChunkOffset) > ChunkSize) ? ChunkSize : (Data.count - ChunkOffset)
                let EndIndex = ChunkOffset + thisChunkSize
                print(StartIndex)
                if(thisChunkSize > 0)
                {
                    ChunkCounter = ChunkCounter + 1
     
                    let range  = Data[StartIndex..<EndIndex]
                    var _data = [UInt8]()
                    _data.append(contentsOf: range)
                   
                    BotConnectImplementation.Instance.SendData(_CATEGORY: Category, _Data: _data, _Block_Count: ChunkCounter)
                    
                    ChunkOffset += thisChunkSize;
                    
                 }
                else
                {
                    BotConnectImplementation.Instance.ExitUpload()
                }
                
                
                break
            case .EXREQ_ACK:
                Category = CATEGORY_TYPES.NA
                TotalChunks = 0;
                ChunkOffset = 0;
                FILEMD5 = ""
                 UIBotUploadHandler.Instance.getBotUploadConvey()?.DismissUploadProgressDialog()
                
                
                break
            case .COMMAND_ACK:
                
                break
            default:
                break
        }
    }
}
