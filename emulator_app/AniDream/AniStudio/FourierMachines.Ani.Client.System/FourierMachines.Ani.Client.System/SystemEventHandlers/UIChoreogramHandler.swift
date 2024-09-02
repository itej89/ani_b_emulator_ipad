//
//  UIChoreogramHandler.swift
//  FourierMachines.Ani.Client.System
//
//  Created by Tej Kiran on 11/06/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation

public class UIChoreogramHandler: ChoreogramRead, UIChoreogramConvey
{
    public func SetUploadProgress(progress: Float) {
        
    }
    
    public func DismissUploadProgressDialog() {
        
    }
    
   
    
    
    //ChoreogramRead
    public func ChoreogramFinished() {
        
    }
    public func IsPlaying() -> Bool {
        return false
    }
    //End of ChoreogramRead
    
    //UIChoreogramConvey
    public func ProgressUpdated(progress: Double) {
        
    }
    //End of UIChoreogramConvey
    
    public static let Instance:UIChoreogramHandler  = UIChoreogramHandler()
    
    public var choreogramRead:ChoreogramRead!
    public var choreogramConvey:UIChoreogramConvey!
    
    public func getChoreogramRead()->ChoreogramRead!
    {
        return choreogramRead
    }
    
    public func getChoreogramConvey()->UIChoreogramConvey!
    {
        return choreogramConvey
    }
    
    public func RevokeChoreogramRead()
    {
        choreogramRead = self
    }
    
    public func setNotifyOnRead(_choreogramRead:ChoreogramRead!)
    {
        choreogramRead = _choreogramRead
    }
    
    public func setNotifyOnConvey(_choreogramConvey:UIChoreogramConvey!)
    {
        choreogramConvey = _choreogramConvey
    }
    
}
