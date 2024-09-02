//
//  TextDialogReqestProtocol.swift
//  AniStudio
//
//  Created by Tej Kiran on 04/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol DialogReqestProtocol
{
    func ProgressDialogSetProgress(percent:Float)
    func DismissProgressDialog()
    func ShowProgressDialog(title:String)
    func ShowTextDialog(placeholderText:String)
    func ShowTextDialogWithText(Text:String)
    func ShowListDialog(title: String, data:[String], DismissOnSelection:Bool)
    func ShowActivityIndicator()
    func CloseActivityIndicator()
}
