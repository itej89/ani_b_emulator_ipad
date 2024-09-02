//
//  AIServerDelegates.swift
//  FourierMachines.Ani.Client.AI
//
//  Created by Tej Kiran on 13/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public protocol AIServerDelegates
{
    func RecievedAnswerWithEmotion(response:String, data: String)
}
