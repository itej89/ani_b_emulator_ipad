//
//  AIManager.swift
//  FourierMachines.Ani.Client.AI
//
//  Created by Tej Kiran on 12/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public class AIManager:fmServiceInterface, AIAccess
{
  
    public static let Instance:AIAccess = AIManager()
    
   
    //AIAccess
    public func InitializeAIServer(delegate:AIServerDelegates) {
         ServerManagerDelegate = delegate
    }
    
   
    public func GetAIQAObject(question: String) {
        ConversationQuery(Question: question)
    }
    
    public func GetAIEmoObject() {
        
    }
    //End of AIAccess
    
}
