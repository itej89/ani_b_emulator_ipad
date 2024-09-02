//
//  AIAccess.swift
//  FourierMachines.Ani.Client.AI
//
//  Created by Tej Kiran on 12/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol AIAccess
{
    func InitializeAIServer(delegate:AIServerDelegates)
    
    func GetAIQAObject(question: String)
    func GetAIEmoObject()
    
}
