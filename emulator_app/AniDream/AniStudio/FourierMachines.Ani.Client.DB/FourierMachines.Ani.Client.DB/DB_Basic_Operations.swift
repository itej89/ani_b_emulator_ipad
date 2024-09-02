//
//  DB_Basic_Operations.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation
import FMDB

public class DB_Basic_Operations{

var CommandStoreDB:FMDatabase!
var databasePath: String!

init() {
    databasePath = GetDBPath()
    
    CommandStoreDB = FMDatabase(path: databasePath as String)
}
    
    init(dbPath:String) {
        databasePath = dbPath
        
        CommandStoreDB = FMDatabase(path: databasePath as String)
    }

func GetDBPath() -> String {
    let filemgr = FileManager.default
    let dirPaths = filemgr.urls(for: .libraryDirectory,
                                in: .userDomainMask)
    
    return dirPaths[0].appendingPathComponent("Database/CommandStore.db").path
}



public  var ErrorMessage:String!

func CreateTable(TableName:String, Columns:[Column_Definition]) -> Bool {
    
    
    if CommandStoreDB == nil {
        ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))")
        return false
    }
    
    if (CommandStoreDB?.open())! {
        
        var  sql_stmt = "CREATE TABLE IF NOT EXISTS "+TableName+" (ID INTEGER PRIMARY KEY AUTOINCREMENT"
        
        for column in Columns
        {
            sql_stmt += ", "+column.ColumnName+" "+column.ColumnType
        }
        
        sql_stmt += ")"
        
        if !(CommandStoreDB?.executeStatements(sql_stmt))! {
            ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))") }
        
        CommandStoreDB?.close()
    }
    else {
        
        ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))")
        return false
    }
    
    return true
    
}

func EmptyTable(TableName:String) -> Bool {
    
    
    if (CommandStoreDB?.open())! {
        
        let insertSQL = "DELETE FROM "+TableName
        
        let result = CommandStoreDB?.executeUpdate(insertSQL,
                                                   withArgumentsIn: [])
        CommandStoreDB?.close()
        
        if !result! {
            ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))") 
            return false
        } else {
        }
        
        
    } else {
        ErrorMessage =  ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))") 
        return false
    }
    
    
    return true
    
}

func ReadDataFromTable(SqlQuery:String) -> FMResultSet {
    
    
    
    if (CommandStoreDB?.open())! {
        
        
        
        if let rs = CommandStoreDB?.executeQuery(SqlQuery, withArgumentsIn:[]) {
           
            return rs
        } else {
            
            ErrorMessage = ("select failure: \(String(describing: CommandStoreDB?.lastErrorMessage()))")
        }
        
        
       
        
    }
    CommandStoreDB?.close()
    return FMResultSet()
}

func CloseDBConnection() {
    CommandStoreDB?.close()
}

    func ExecuteSqlCommand(SqlQuery:String, withArgumentsIn: [NSData]) -> Bool {
        
        if (CommandStoreDB?.open())! {
            
            
            let result = CommandStoreDB?.executeUpdate(SqlQuery,
                                                       withArgumentsIn: withArgumentsIn)
            
            CommandStoreDB?.close()
            if !result! {
                ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))")
                return false
            } else {
                CommandStoreDB?.close()
            }
        } else {
            ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))")
            return false
        }
        return true
    }
    
    
func ExecuteSqlCommand(SqlQuery:String) -> Bool {
    
    if (CommandStoreDB?.open())! {
        
        
        let result = CommandStoreDB?.executeUpdate(SqlQuery,
                                                   withArgumentsIn: [])
        
        CommandStoreDB?.close()
        if !result! {
            ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))") 
            return false
        } else {
            CommandStoreDB?.close()
        }
    } else {
        ErrorMessage = ("Error: \(String(describing: CommandStoreDB?.lastErrorMessage()))") 
        return false
    }
    return true
}


}
