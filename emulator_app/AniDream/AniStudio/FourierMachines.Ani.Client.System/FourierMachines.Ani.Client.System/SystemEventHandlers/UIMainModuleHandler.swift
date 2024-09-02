//
//  UIMainModuleHandler.swift
//  FourierMachines.Ai.Client.System
//
//  Created by Tej Kiran on 01/05/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation

public class UIMAINModuleHandler
{
    public static let Instance:UIMAINModuleHandler  = UIMAINModuleHandler()
    
    public var AniUIHandler:AniUIRead!
    public var AniUINotify:AniUIConvey!
    
    private init()
    {
        
    }
    
    public func GetUIMainConveyListener()->SystemFlowManager
    {
        return SystemFlowManager.Instance
    }
    
    public func setAniUIHandler(delegate: AniUIRead)
    {
        AniUIHandler = delegate
    }
    public func setAniUINotify(delegate: AniUIConvey)
    {
        AniUINotify = delegate
    }
    
    public func GetApplicationStateDelegate()->ApplicationStateDelegate
    {
        return ApplicationsTateHandler.Instance
    }
    
  
}
