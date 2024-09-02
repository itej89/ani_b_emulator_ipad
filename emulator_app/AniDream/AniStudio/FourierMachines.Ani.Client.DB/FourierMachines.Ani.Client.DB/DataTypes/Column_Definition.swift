//
//  Column_Definition.swift
//  FourierMachines.Ani.Client.DB
//
//  Created by Tej Kiran on 01/02/18.
//  Copyright © 2018 Tej Kiran. All rights reserved.
//

import Foundation

public class Column_Definition {
    var ColumnName:String!
    var ColumnType:String!
    
    init(columnName:String, columnType:String)
    {
        ColumnName = columnName
        ColumnType = columnType
    }
}
