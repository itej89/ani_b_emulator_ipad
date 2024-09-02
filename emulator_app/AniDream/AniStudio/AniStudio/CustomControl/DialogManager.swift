//
//  TextDialogManager.swift
//  AniStudio
//
//  Created by Tej Kiran on 04/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class DialogManager
{
    public static let Instance:DialogManager = DialogManager()
    
    public var delDialogRequest:DialogReqestProtocol!
    
    public var delTextDialogNotify:DialogDataNotify!
   
}
