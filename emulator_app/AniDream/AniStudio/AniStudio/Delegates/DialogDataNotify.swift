//
//  TextDialogDataNotify.swift
//  AniStudio
//
//  Created by Tej Kiran on 04/05/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public protocol DialogDataNotify
{
    
    func ValidateText(text:String) -> (Bool, String)
    func TextEntered(text:String)
    func ItemSelected(index:Int)
    func ItemUtilityButtonClicked(index:Int)
}
