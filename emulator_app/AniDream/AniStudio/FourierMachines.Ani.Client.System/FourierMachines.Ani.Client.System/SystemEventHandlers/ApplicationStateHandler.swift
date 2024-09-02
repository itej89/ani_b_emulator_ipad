//
//  ApplicationStateHandler.swift
//  FourierMachines.Ani.Client.Main
//
//  Created by Tej Kiran on 09/04/18.
//  Copyright © 2018 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

public class ApplicationsTateHandler:ApplicationStateDelegate
{
    
    public func AudioAirdropped() {
        
    }
    
    var CURRENT_SATE:APP_STATE = APP_STATE.ACTIVE
    
    
    //ApplicationStateDelegate
    public func AppInterrupted() {
         if(CURRENT_SATE == APP_STATE.ACTIVE){
        CURRENT_SATE = APP_STATE.INACTIVE
        SystemFlowManager.Instance.WentBackground()
        }
    }
    
    public func AppInterruptOver() {
        if(CURRENT_SATE == APP_STATE.INACTIVE)
        {
            CURRENT_SATE = APP_STATE.ACTIVE
            SystemFlowManager.Instance.CameForeground()
        }
    }
    
    public func AppInactive() {
       CURRENT_SATE = APP_STATE.BACKGROUND
    }
    
    public func AppIsActive() {
       CURRENT_SATE = APP_STATE.INACTIVE
    }
    //End of ApplicationStateDelegate
    
    
    
    
    
    
    private init()
    {
        
    }
    
    public static let Instance:ApplicationsTateHandler = ApplicationsTateHandler()
    
  
}
