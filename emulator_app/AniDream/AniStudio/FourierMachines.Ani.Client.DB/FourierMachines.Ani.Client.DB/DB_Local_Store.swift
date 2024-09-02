//
//  DB_Local_Store.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation
import FMDB
public class DB_Local_Store:DB_Basic_Operations
{
    public override init()
    {
        super.init()
    }
    
    public override init(dbPath:String)
    {
        super.init(dbPath: dbPath)
    }

public func RemoveDB() -> String
{
    let filemgr = FileManager.default
    
    let databasePath = GetDBPath()
    
    do{
        if filemgr.fileExists(atPath: databasePath as String)
        {
            try filemgr.removeItem(atPath: databasePath as String)
        }
    }
    catch
    {}
     return "Database Removed Successfully!"
}
    
    
public func  PlaceDB() -> String
{
    let filemgr = FileManager.default
   
    let databasePath = GetDBPath()
    
    
    do{
        if !filemgr.fileExists(atPath: databasePath as String)
        {
            //Code to push DB
                let fileManger =  FileManager.default
                
                let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] as NSString
                let destinationPath = doumentDirectoryPath.appendingPathComponent("Database/CommandStore.db")
            
            do {
                try FileManager.default.createDirectory(atPath: doumentDirectoryPath.appendingPathComponent("Database"), withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
            
            let bundle = Bundle(identifier: "FourierMachines-Ani-Client-DB")
            let sourcePath = bundle?.path(forResource: "CommandStore", ofType: "sqlite")
                try fileManger.copyItem(atPath: sourcePath!, toPath: destinationPath)
                
          
//            
//                    
//                    var Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.SERVO_DATA.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_DATA_COLUMNS.NAME.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.TEXT.rawValue),
//                        
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_DATA_COLUMNS.ADDRESS.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_DATA_COLUMNS.MIN_ANGLE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_DATA_COLUMNS.MAX_ANGLE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue) ])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
//                    
//                    Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.SERVO_TURN.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.DEGREE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.ADC.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue)])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
//                    
//                    Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.SERVO_LIFT.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.DEGREE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.ADC.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue)])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
//                    
//                    Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.SERVO_LEAN.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.DEGREE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.ADC.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue)])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
//                    
//                    Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.SERVO_TILT.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.DEGREE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.ADC.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.NUMBER.rawValue)])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
//                    
//                    
//                    Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.CAPTURED_COMMANDS.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.TEXT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.COMMAND.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.TEXT.rawValue) ])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
//                    
//                    
//                    Status = dbHelper.CreateTable(TableName: DB_Table_Columns.DBTables.EXPRESSIONS.rawValue, Columns: [
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.TEXT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.TEXT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.FLOAT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.FLOAT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.FLOAT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.FLOAT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.FLOAT.rawValue),
//                        Column_Definition(columnName: DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue ,columnType: DB_Table_Columns.COLUMN_TYPES.FLOAT.rawValue),])
//                    
//                    if(!Status) {return dbHelper.ErrorMessage }
                    
            
        }
    }
    catch
    {}

    
    return "Database Created Successfully!"
}

  public  func GetServoDegreeFromADC(TableName:DB_Table_Columns.DBTables, ADC: UInt16)->Int
    {
    var DegreeData:Servo_Calibration_Type!
    
    let CalibratedData =  ReadServoCalibrationData(TableName: TableName.rawValue)
    
   if(CalibratedData .count > 0){
    if(CalibratedData[0].ADC > ADC){
        DegreeData = CalibratedData[0]
    }
    else  if(CalibratedData[CalibratedData.count - 1].ADC < ADC){
        DegreeData = CalibratedData[CalibratedData.count - 1]
    }
    else
    {
        for Calibration in CalibratedData
        {
            if(Calibration.ADC >= ADC){
                DegreeData = Calibration
                break
            }
        }
    }
        }
        else
   {
    return -1
        }
            
            
        return Int(DegreeData.Degree)
}
    
    
    public func ReadMachinePositionByName(name: String)-> Machine_Position_Type
    {
        var machine_Position_Type:Machine_Position_Type! = Machine_Position_Type(name: "")
       
        let Result:FMResultSet? = ReadDataFromTable(SqlQuery: "SELECT "+DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.NAME.rawValue+", "+DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.TURN.rawValue+", "+DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.LIFT.rawValue+", "+DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.LEAN.rawValue+", "+DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.TILT.rawValue+" from "+DB_Table_Columns.DBTables.MACHINE_POSITIONS.rawValue+" WHERE "+DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.NAME.rawValue+" = '\(name)'"
        )
        if Result?.next() == true{
            let NAME = Result?.string(forColumn: DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.NAME.rawValue)
            let TURN = Result?.int(forColumn: DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.TURN.rawValue)
            let LIFT = Result?.int(forColumn: DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.LIFT.rawValue)
            let LEAN = Result?.int(forColumn: DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.LEAN.rawValue)
            let TILT = Result?.int(forColumn: DB_Table_Columns.MACHINE_POSITIONS_COLUMNS.TILT.rawValue)
            machine_Position_Type = Machine_Position_Type(name: NAME!, turn: TURN!, lift: LIFT!, lean: LEAN!, tilt: TILT!)
            }
        
        CloseDBConnection()
        return machine_Position_Type
    }

    
    public func ReadCommandByName(name: String)-> String
    {
        var Captured_Command_Data = Captured_Command_Type(name: "", command: "")
        
        let Result:FMResultSet? = ReadDataFromTable(SqlQuery: "SELECT "+DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue+", "+DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.COMMAND.rawValue+" from "+DB_Table_Columns.DBTables.CAPTURED_COMMANDS.rawValue+" WHERE "+DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue+" = '\(name)'"
        )
        if Result?.next() == true{
            let CommandName = Result?.string(forColumn: DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue)
            let Command = Result?.string(forColumn: DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.COMMAND.rawValue)
            Captured_Command_Data = (Captured_Command_Type(name: CommandName! , command: Command! )
            )}
        
        CloseDBConnection()
        return Captured_Command_Data.Command
    }
    

func ReadServoCalibrationData(TableName:String) -> [Servo_Calibration_Type] {
    
    var CalibrationData = Array<Servo_Calibration_Type>()
    
    let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select * from "+TableName)
    while Result.next() {
        CalibrationData.append(Servo_Calibration_Type(degree: UInt8(Result.resultDictionary![DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.DEGREE.rawValue] as! Int), adc: UInt16(Result.resultDictionary![DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.ADC.rawValue] as! Int)))
    }
    
    CloseDBConnection()
    return CalibrationData
}

func ReadCapturedCommands(TableName:String) -> [Captured_Command_Type] {
    
    var CommandData = Array<Captured_Command_Type>()
    
    let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select * from "+TableName)
    while Result.next() {
        CommandData.append(Captured_Command_Type(name: Result.resultDictionary![DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue] as! String, command: Result.resultDictionary![DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.COMMAND.rawValue] as! String)
        )         }
    CloseDBConnection()
    return CommandData
}

func LoadServoDataIntoDB(Data: Servo_Data_Type) -> String {
    
    
    let insertSQL = "INSERT INTO "+DB_Table_Columns.DBTables.SERVO_DATA.rawValue + " (" +
        DB_Table_Columns.SERVO_DATA_COLUMNS.NAME.rawValue + ", " +
        DB_Table_Columns.SERVO_DATA_COLUMNS.ADDRESS.rawValue + ", " +
        DB_Table_Columns.SERVO_DATA_COLUMNS.MIN_ANGLE.rawValue + ", " +
        DB_Table_Columns.SERVO_DATA_COLUMNS.MAX_ANGLE.rawValue +
    ") VALUES ('\(String(describing: Data.Name))', '\(String(describing: Data.Address))', '\(String(describing: Data.Min_Angle))', '\(String(describing: Data.Max_Angle))')"
    
    let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
    
    
    if(!Status) {return ErrorMessage }
    
    
    return "Servo Data Loaded Successfully."
}

func ClearTable(TableName:String) -> String {
    
    
    let Status = EmptyTable(TableName: TableName)
    
    if(!Status) {return ErrorMessage }
    
    
    return "Data deleted from Table."
}

 

func DeleteCommandByName(name: String) -> String {
    
    let deleteQuery = "DELETE FROM "+DB_Table_Columns.DBTables.CAPTURED_COMMANDS.rawValue+" WHERE "+DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue + " = '" + name + "'"
    
    let  Status = ExecuteSqlCommand(SqlQuery: deleteQuery)
    
    
    if(!Status) {return ErrorMessage }
    
    
    return "Command Deleted Successfully!"
}

func  saveCommand(Data: Captured_Command_Type)->String {
    
    let Found_Command_Data = ReadCommandByName(name: Data.Name)
    if(Found_Command_Data != "")
    {
        _ =  DeleteCommandByName(name: Data.Name)
    }
    
    let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.CAPTURED_COMMANDS.rawValue) + " (" +
        DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.NAME.rawValue + ", " +
        DB_Table_Columns.CAPTURED_COMMAND_COLUMNS.COMMAND.rawValue +
        ") VALUES ('"+Data.Name+"', '"+Data.Command+"')"
    
    let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
    
    
    if(!Status) {return ErrorMessage }
    
    
    return "Command Data Saved Successfully!"
    
}


func  saveCalibrationData(Data: Servo_Calibration_Type)->String {
    
    let insertSQL = "INSERT INTO "+(String(Data.Name)) + " (" +
        DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.DEGREE.rawValue + ", " +
        DB_Table_Columns.SERVO_CALIBRATION_COLUMNS.ADC.rawValue +
    ") VALUES ('\(Data.Degree)', '\(Data.ADC)')"
    
    let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
    
    
    if(!Status) {return ErrorMessage }
    
    
    return "Calibration Data Saved Successfully!"
}


    
    public func  saveInContext(Data: DataContext)->String {
       
        
        let ContextData = ReadFromContext(KEY: Data.KEY)
        
        if ContextData.count > 0
        {
            _ = DeleteFromContext(KEY: Data.KEY)
        }
        
        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.CONTEXT.rawValue) + " (" +
            DB_Table_Columns.CONTEXT_COLUMNS.KEY.rawValue + ", " +
            DB_Table_Columns.CONTEXT_COLUMNS.VALUE.rawValue +
        ") VALUES ('\(Data.KEY!)', '\(Data.VALUE!)')"
        
        let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
        
        if(!Status) {return ErrorMessage }
        
        return "Data Context Saved Successfully!"
    }
    
    public  func DeleteFromContext(KEY:String) -> String {
        
       
        
        let  Status = ExecuteSqlCommand(SqlQuery: "delete from "+DB_Table_Columns.DBTables.CONTEXT.rawValue+" WHERE "+DB_Table_Columns.CONTEXT_COLUMNS.KEY.rawValue+" = '\(KEY)'")
        
        if(!Status) {return ErrorMessage }
        
        return "Data Context delete Successful!"
        
    }
    
    public  func ReadFromContext(KEY:String) -> [DataContext] {
        
        var ContextData = Array<DataContext>()
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select "+DB_Table_Columns.CONTEXT_COLUMNS.VALUE.rawValue+" from "+DB_Table_Columns.DBTables.CONTEXT.rawValue+" WHERE "+DB_Table_Columns.CONTEXT_COLUMNS.KEY.rawValue+" = '\(KEY)'")
        while Result.next()
        {
            ContextData.append(
                DataContext(
                    key: KEY, value: Result.string(forColumn:DB_Table_Columns.CONTEXT_COLUMNS.VALUE.rawValue)!)
            )
            
        }
        CloseDBConnection()
        return ContextData
    }
    
    public func  saveActWithID(Data: ACTS)->String {
        
        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.ACTS.rawValue) + " (" +
            DB_Table_Columns.ACTS_COLUMNS.ACT_NAME.rawValue + ", " +
            DB_Table_Columns.ACTS_COLUMNS.ACT_AUDIO.rawValue + ", "  +
            DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue +
        ") VALUES ('\(Data.Name!)', '\(Data.Audio!)', '\(Data.ID!)')"
        
        let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
        
        if(!Status) {return ErrorMessage }
        
        return "Animation Act Saved Successfully!"
    }
    
    public func  saveAct(Data: ACTS)->String {
        
        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.ACTS.rawValue) + " (" +
            DB_Table_Columns.ACTS_COLUMNS.ACT_NAME.rawValue + ", " +
            DB_Table_Columns.ACTS_COLUMNS.ACT_AUDIO.rawValue +
        ") VALUES ('\(Data.Name!)', '\(Data.Audio!)')"
        
        let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
        
        if(!Status) {return ErrorMessage }
        
        return "Animation Act Saved Successfully!"
    }
    
    public  func ReadActWithID(ID:Int) -> [ACTS] {
        
        var ActsData = Array<ACTS>()
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select "+DB_Table_Columns.ACTS_COLUMNS.ACT_AUDIO.rawValue+", "+DB_Table_Columns.ACTS_COLUMNS.ACT_NAME.rawValue+" from "+DB_Table_Columns.DBTables.ACTS.rawValue+" WHERE "+DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue+" = '\(ID)'")
        while Result.next()
        {
            ActsData.append(
                ACTS(
                    name: Result.string(forColumn: DB_Table_Columns.ACTS_COLUMNS.ACT_NAME.rawValue)!, audio: Result.string(forColumn:DB_Table_Columns.ACTS_COLUMNS.ACT_AUDIO.rawValue)!)
            )
            
        }
        CloseDBConnection()
        return ActsData
    }
    
    public func GetLastActID()->Int
    {
        var ID = -1;
        
        let selectSQL =  "SELECT "+DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue+" FROM "+DB_Table_Columns.DBTables.ACTS.rawValue+" ORDER BY "+DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue+" DESC LIMIT 1"
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: selectSQL)
        while Result.next()
        {
            
            ID =  Int(Result.int(forColumn: DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue))
            break
        }
        
         CloseDBConnection()
        return ID;
    }
    
    public func DeleteAct(ID:Int)->String
    {
        
        let Status = ExecuteSqlCommand(SqlQuery: "DELETE from "+DB_Table_Columns.DBTables.ACTS.rawValue+" WHERE "+DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue+" = '\(ID)'"
        )
        
        if(!Status) {return ErrorMessage }
        
        
        return "Deleted Expression Successfully."
    }
    
    public  func ReadActs(TableName:String) -> [ACTS] {
        
        var ActsData = Array<ACTS>()
       
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select "+DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue+", "+DB_Table_Columns.ACTS_COLUMNS.ACT_NAME.rawValue+" from "+TableName)
        while Result.next()
        {
            ActsData.append(
                ACTS(
                    name: Result.string(forColumn: DB_Table_Columns.ACTS_COLUMNS.ACT_NAME.rawValue)!, id: Int(Result.int(forColumn:DB_Table_Columns.ACTS_COLUMNS.ACT_ID.rawValue)))
            )
            
        }
        CloseDBConnection()
        return ActsData
    }
    
    public func GetLastBeatID()->Int
    {
         var ID = -1;
        
         let selectSQL =  "SELECT "+DB_Table_Columns.BEATS_COLUMNS.BEAT_ID.rawValue+" FROM "+DB_Table_Columns.DBTables.BEATS.rawValue+" ORDER BY "+DB_Table_Columns.BEATS_COLUMNS.BEAT_ID.rawValue+" DESC LIMIT 1"
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: selectSQL)
        while Result.next()
        {
            ID =  Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.BEAT_ID.rawValue))
            break
        }
        
         CloseDBConnection()
        return ID;
    }
    
    public func DeleteBeatByActID(ACT_ID:Int)->String
    {
        
        let Status = ExecuteSqlCommand(SqlQuery: "DELETE from "+DB_Table_Columns.DBTables.BEATS.rawValue+" WHERE "+DB_Table_Columns.BEATS_COLUMNS.ACT_ID.rawValue+" = '\(ACT_ID)'"
        )
        
        if(!Status) {return ErrorMessage }
        
        
        return "Deleted Expression Successfully."
    }
    
    public func DeleteBeatByBeatID(BEAT_ID:Int)->String
    {
        
        let Status = ExecuteSqlCommand(SqlQuery: "DELETE from "+DB_Table_Columns.DBTables.BEATS.rawValue+" WHERE "+DB_Table_Columns.BEATS_COLUMNS.BEAT_ID.rawValue+" = '\(BEAT_ID)'"
        )
        
        if(!Status) {return ErrorMessage }
        
        
        return "Deleted Expression Successfully."
    }
    
    
    
    public func  saveBeat(Data: Beats_Type)->String {
        
        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.BEATS.rawValue) + " (" +
            DB_Table_Columns.BEATS_COLUMNS.ACT_ID.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.ACTION_DATA.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.JOY.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.SURPRISE.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.FEAR.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.SADNESS.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.ANGER.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.DISGUST.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.StartSec.rawValue + ", " +
            DB_Table_Columns.BEATS_COLUMNS.EndSec.rawValue +
        ") VALUES ('\(Data.Act_Id!)', '\(Data.Action_Data!)', '\(Data.JOY!)', '\(Data.SURPRISE!)', '\(Data.FEAR!)', '\(Data.SADNESS!)', '\(Data.ANGER!)', '\(Data.DISGUST!)', '\(Data.StartSec!)', '\(Data.EndSec!)')"
        
        let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
        
        if(!Status) {return ErrorMessage }
        
        return "Animation Act Saved Successfully!"
    }
    
    public  func ReadBeats(TableName:String, BEAT_ID:Int) -> [Beats_Type] {
        
        var Beats = Array<Beats_Type>()
       
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select * from "+TableName+" WHERE "+DB_Table_Columns.BEATS_COLUMNS.BEAT_ID.rawValue+" = '\(BEAT_ID)'")
        while Result.next()
        {
            Beats.append(
                Beats_Type(
                    act_Id: Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.ACT_ID.rawValue)),
                    beat_ID: BEAT_ID,
                    action_Data: Result.string(forColumn: DB_Table_Columns.BEATS_COLUMNS.ACTION_DATA.rawValue)!,
                    joy: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.JOY.rawValue)),
                    surprise: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.SURPRISE.rawValue)),
                    fear: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.FEAR.rawValue)),
                    sadness: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.SADNESS.rawValue)),
                    anger: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.ANGER.rawValue)),
                    disgust: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.DISGUST.rawValue)),
                    startSec: Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.StartSec.rawValue)),
                    endSec: Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.EndSec.rawValue))))
            
        }
        CloseDBConnection()
        return Beats
    }
    
    public  func ReadBeats(TableName:String, ACT_ID:Int) -> [Beats_Type] {
        
        var Beats = Array<Beats_Type>()
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select * from "+TableName+" WHERE "+DB_Table_Columns.BEATS_COLUMNS.ACT_ID.rawValue+" = '\(ACT_ID)'")
        while Result.next()
        {
            Beats.append(
                Beats_Type(
                    act_Id:ACT_ID,
                    beat_ID: Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.BEAT_ID.rawValue)),
                    action_Data: Result.string(forColumn: DB_Table_Columns.BEATS_COLUMNS.ACTION_DATA.rawValue)!,
                    joy: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.JOY.rawValue)),
                    surprise: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.SURPRISE.rawValue)),
                    fear: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.FEAR.rawValue)),
                    sadness: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.SADNESS.rawValue)),
                    anger: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.ANGER.rawValue)),
                    disgust: Float(Result.double(forColumn: DB_Table_Columns.BEATS_COLUMNS.DISGUST.rawValue)),
                    startSec: Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.StartSec.rawValue)),
                    endSec: Int(Result.int(forColumn: DB_Table_Columns.BEATS_COLUMNS.EndSec.rawValue))))
            
        }
        CloseDBConnection()
        return Beats
    }
    
    public func  saveTrack(Track: Track_Type)->Bool
    {
//        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.TRACK.rawValue) + " (" +
//            DB_Table_Columns.TRACK_COLUMNS.DATA.rawValue +
//            ") VALUES ('\(Track.Data!)')"
        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.TRACK.rawValue) + " (" +
            DB_Table_Columns.TRACK_COLUMNS.DATA.rawValue +
        ") VALUES (?);"
        
        let  Status = ExecuteSqlCommand(SqlQuery: insertSQL, withArgumentsIn: [Track.Data!])
        
        //dbHelper.ErrorMessage
        if(!Status) {return  false }
        
        
        return true
    }
    
    public func  saveEmSynth(Data: EM_SYNTH)->Bool {
        
        let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.EM_SYNTH.rawValue) + " (" +
            DB_Table_Columns.EM_SYNTH.NAME.rawValue +
            
            ") VALUES ('" + Data.Name! + "')"
        
        let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
        
        //dbHelper.ErrorMessage
        
        if(!Status) {return  false }
        
        return true
    }
    
    
    public func GetLastEmSynthID()->Int
    {
        var ID = -1;
        
        let selectSQL =  "SELECT "+DB_Table_Columns.EM_SYNTH.ID.rawValue+" FROM "+DB_Table_Columns.DBTables.EM_SYNTH.rawValue+" ORDER BY "+DB_Table_Columns.EM_SYNTH.ID.rawValue+" DESC LIMIT 1"
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: selectSQL)
        while Result.next()
        {
            ID =  Int(Result.int(forColumn: DB_Table_Columns.EM_SYNTH.ID.rawValue))
        }
        
        CloseDBConnection()
        return ID;
    }
    
    public func DeleteEmSynth(ID:Int)->String
    {
        
        let Status = ExecuteSqlCommand(SqlQuery: "DELETE from "+DB_Table_Columns.DBTables.EM_SYNTH.rawValue+" WHERE "+DB_Table_Columns.EM_SYNTH.ID.rawValue+" = '\(ID)'"
        )
        
        if(!Status) {return ErrorMessage }
        
        
        return "Deleted Expression Successfully."
    }
    
    public  func ReadAllEM_SYNTH(TableName:String) -> [EM_SYNTH] {
        
        var EmSynthData = Array<EM_SYNTH>()
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select * from "+TableName)
        while Result.next()
        {
            EmSynthData.append(
                EM_SYNTH(
                    id:Int(Result.int(forColumn: DB_Table_Columns.EM_SYNTH.ID.rawValue)),
                    name: Result.string(forColumn: DB_Table_Columns.EM_SYNTH.NAME.rawValue)!)
            )
            
        }
        CloseDBConnection()
        return EmSynthData
    }
    
    public func  readEmSynth(ByID: Int)->EM_SYNTH {
        
        var Saved_EM_SYNTH_Data = EM_SYNTH(name: "")
        
        let Result:FMResultSet? = ReadDataFromTable(SqlQuery: "SELECT "+DB_Table_Columns.EM_SYNTH.NAME.rawValue+" FROM "+DB_Table_Columns.DBTables.EM_SYNTH.rawValue+" WHERE "+DB_Table_Columns.EM_SYNTH.ID.rawValue+" = '\(ByID)'"
            
        )
        if Result?.next() == true
        {
            let SynthName = Result?.string(forColumn: DB_Table_Columns.EM_SYNTH.NAME.rawValue)
            
            Saved_EM_SYNTH_Data = EM_SYNTH(name: SynthName!)
        }
        
        CloseDBConnection()
        return Saved_EM_SYNTH_Data
    }
    
    public func  readEmSynth(ByName: String)->EM_SYNTH {
        
        var Saved_EM_SYNTH_Data = EM_SYNTH(name: "")
        
        let Result:FMResultSet? = ReadDataFromTable(SqlQuery: "SELECT "+DB_Table_Columns.EM_SYNTH.NAME.rawValue+" FROM "+DB_Table_Columns.DBTables.EM_SYNTH.rawValue+" WHERE "+DB_Table_Columns.EM_SYNTH.NAME.rawValue+" = '\(ByName)'"
            
        )
        if Result?.next() == true{
            let SynthName = Result?.string(forColumn: DB_Table_Columns.EM_SYNTH.NAME.rawValue)
            
            Saved_EM_SYNTH_Data = EM_SYNTH(name: SynthName!)
        }
        
        CloseDBConnection()
        return Saved_EM_SYNTH_Data
    }
    
public func updateExpression(Data: Expressions_Type) -> Bool
{
    var updateSQL = "UPDATE "+(DB_Table_Columns.DBTables.EXPRESSIONS.rawValue)
    
    updateSQL = updateSQL+" SET "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue+" = '"+Data.Action_Data!+"' ,"
    
    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue+" = "+"\(Data.JOY!)"+", "

    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue+" = "+"\(Data.SURPRISE!)"+", "

    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue+" = "+"\(Data.FEAR!)"+", "

    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue+" = "+"\(Data.SADNESS!)"+", "

    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue+" = "+"\(Data.ANGER!)"+", "

    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue+" = "+"\(Data.DISGUST!)"+", "

    updateSQL = updateSQL+" "+DB_Table_Columns.EXPRESSIONS_COLUMNS.SOUND_ID.rawValue+" = '"+Data.SOUND_LIBRARY_ID!+"'"
    
    updateSQL = updateSQL+" WHERE "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ID.rawValue+" = "+"\(Data.ID!)"
    
    let  Status = ExecuteSqlCommand(SqlQuery: updateSQL)
    
    //dbHelper.ErrorMessage
    
    if(!Status) {return  false }
    
    return true
}
    
public func  saveExpression(Data: Expressions_Type)->Bool {
    
    let insertSQL = "INSERT INTO "+(DB_Table_Columns.DBTables.EXPRESSIONS.rawValue) + " (" +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.EM_SYNTH_ID.rawValue + ", " +
        DB_Table_Columns.EXPRESSIONS_COLUMNS.SOUND_ID.rawValue +
        
        ") VALUES ('" + Data.Name! + "', '" + Data.Action_Data! + "', '\(Data.JOY!)', '\(Data.SURPRISE!)', '\(Data.FEAR!)', '\(Data.SADNESS!)', '\(Data.ANGER!)','\(Data.DISGUST!)','\(Data.EM_SYNTH_ID!)','\(Data.SOUND_LIBRARY_ID!)')"
    
    let  Status = ExecuteSqlCommand(SqlQuery: insertSQL)
    
    //dbHelper.ErrorMessage
    
    if(!Status) {return  false }
    
    
    return true
}

    public func  readExpression(Em_Synth_id:Int, ByName: String)->Expressions_Type {
    
        var Saved_Action_Data = Expressions_Type(name: "", action_Data: "", joy: 0.0, surprise: 0.0, fear: 0.0, sadness: 0.0, anger: 0.0, disgust: 0.0, em_synth_id: Em_Synth_id, Sound_Library_ID: "")
    
    let Result:FMResultSet? = ReadDataFromTable(SqlQuery: "SELECT "+DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue+", "+DB_Table_Columns.EXPRESSIONS_COLUMNS.SOUND_ID.rawValue+" from "+DB_Table_Columns.DBTables.EXPRESSIONS.rawValue+" WHERE "+DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue+" = '\(ByName)'"+" AND "+DB_Table_Columns.EXPRESSIONS_COLUMNS.EM_SYNTH_ID.rawValue+" = '\(Em_Synth_id)'"
        
    )
    if Result?.next() == true{
        let ActionName = Result?.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue)
        let ActionData = Result?.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue)
        let Joy = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue)
        let Surprise = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue)
        let Fear = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue)
        let Anger = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue)
        let Sadness = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue)
        let Disguest = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue)
        let Sound_ID = Result!.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SOUND_ID.rawValue)
        Saved_Action_Data = Expressions_Type(name: ActionName!, action_Data: ActionData!, joy: Float(Joy!), surprise: Float(Surprise!), fear: Float(Fear!), sadness: Float(Sadness!), anger: Float(Anger!), disgust: Float(Disguest!), em_synth_id: Em_Synth_id, Sound_Library_ID: Sound_ID!)
    }
    
    CloseDBConnection()
    return Saved_Action_Data
}

    public func readExpressionByEmotion(EM_SYNTH_ID : Int, Joy : Float, SURPRISE : Float, FEAR : Float, ANGER : Float, SADNESS : Float, DISGUST : Float) -> Expressions_Type
{
    
    var Saved_Action_Data = Expressions_Type(name: "", action_Data: "", joy: 0.0, surprise: 0.0, fear: 0.0, sadness: 0.0, anger: 0.0, disgust: 0.0, em_synth_id: EM_SYNTH_ID, Sound_Library_ID: "")
    
    
    
    let Result:FMResultSet? = ReadDataFromTable(
        SqlQuery: "SELECT * from "+DB_Table_Columns.DBTables.EXPRESSIONS.rawValue+" order by ABS(JOY-'\(Joy)') + ABS(ANGER-'\(ANGER)') + ABS(DISGUST-'\(DISGUST)') + ABS(SURPRISE-'\(SURPRISE)') + ABS(SADNESS-'\(SADNESS)') + ABS(FEAR-'\(FEAR)') LIMIT 1" + " WHERE "+DB_Table_Columns.EXPRESSIONS_COLUMNS.EM_SYNTH_ID.rawValue+" = '\(EM_SYNTH_ID)'"
    )
    if Result?.next() == true{
        let ActionName = Result?.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue)
        let ActionData = Result?.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue)
        let Joy = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue)
        let Surprise = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue)
        let Fear = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue)
        let Anger = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue)
        let Sadness = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue)
        let Disguest = Result?.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue)
        let Sound_ID = (Result?.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SOUND_ID.rawValue))!
        Saved_Action_Data = Expressions_Type(name: ActionName!, action_Data: ActionData!, joy: Float(Joy!), surprise: Float(Surprise!), fear: Float(Fear!), sadness: Float(Sadness!), anger: Float(Anger!), disgust: Float(Disguest!), em_synth_id : EM_SYNTH_ID, Sound_Library_ID: Sound_ID)
    }
    
    CloseDBConnection()
    return Saved_Action_Data
}
    
    public func GetLastEmotionID()->Int
    {
        var ID = -1;
        
        let selectSQL =  "SELECT "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ID.rawValue+" FROM "+DB_Table_Columns.DBTables.EXPRESSIONS.rawValue+" ORDER BY "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ID.rawValue+" DESC LIMIT 1"
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: selectSQL)
        while Result.next()
        {
            ID =  Int(Result.int(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ID.rawValue))
        }
        
        CloseDBConnection()
        return ID;
    }
    
    public func DeleteExpression(ID:Int)->String
    {
        
        let Status = ExecuteSqlCommand(SqlQuery: "DELETE from "+DB_Table_Columns.DBTables.EXPRESSIONS.rawValue+" WHERE "+DB_Table_Columns.EXPRESSIONS_COLUMNS.ID.rawValue+" = '\(ID)'"
        )
    
        if(!Status) {return ErrorMessage }
        
        
        return "Deleted Expression Successfully."
    }

    public  func ReadExpressions(Em_Synth_ID:Int, TableName:String) -> [Expressions_Type] {
        
        var ExpressionsData = Array<Expressions_Type>()
        
        let Result:FMResultSet = ReadDataFromTable(SqlQuery: "select * from "+TableName+" WHERE "+DB_Table_Columns.EXPRESSIONS_COLUMNS.EM_SYNTH_ID.rawValue+" = '\(Em_Synth_ID)'")
        while Result.next()
        {
            ExpressionsData.append(
                Expressions_Type(
                    id:Int(Result.int(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ID.rawValue)),
                    name: Result.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.NAME.rawValue)!,
                    action_Data: Result.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ACTION_DATA.rawValue)!,
                    joy: Float(Result.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.JOY.rawValue)),
                    surprise: Float(Result.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SURPRISE.rawValue)),
                    fear: Float(Result.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.FEAR.rawValue)),
                    sadness: Float(Result.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SADNESS.rawValue)),
                    anger: Float(Result.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.ANGER.rawValue)),
                    disgust: Float(Result.double(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.DISGUST.rawValue)),
                    em_synth_id: Int(Result.int(forColumn:DB_Table_Columns.EXPRESSIONS_COLUMNS.EM_SYNTH_ID.rawValue)),
                    Sound_Library_ID: (Result.string(forColumn: DB_Table_Columns.EXPRESSIONS_COLUMNS.SOUND_ID.rawValue)!))
            )
            
        }
        CloseDBConnection()
        return ExpressionsData
    }
    
    
    
}
