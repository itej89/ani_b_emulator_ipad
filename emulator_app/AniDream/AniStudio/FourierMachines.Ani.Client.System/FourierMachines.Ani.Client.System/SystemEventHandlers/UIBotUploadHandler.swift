//
//  UIBotUploadHandler.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 01/03/20.
//  Copyright © 2020 FourierMachines. All rights reserved.
//

import Foundation

public class UIBotUploadHandler:  UIBotUploadConvey
{
    public func SetUploadProgress(progress: Float) {
        
    }
    
    public func DismissUploadProgressDialog() {
        
    }
    
    
    //UIBotUploadConvey
    public func ProgressUpdated(progress: Double) {
        
    }
    //End of UIBotUploadConvey
    
    public static let Instance:UIBotUploadHandler  = UIBotUploadHandler()
    
    public var botUploadConvey:UIBotUploadConvey!
    
  
    
    public func getBotUploadConvey()->UIBotUploadConvey!
    {
        return botUploadConvey
    }
    
  
    
    public func setNotifyOnConvey(_botUploadConvey:UIBotUploadConvey!)
    {
        botUploadConvey = _botUploadConvey
    }
    
}
