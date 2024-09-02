//
//  PickerViewIO.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

import FourierMachines_Ani_Client_Kinetics
import GraphicAnimation

public class PickerViewIO:PickerViewBase, UIPickerViewDataSource, UIPickerViewDelegate
{
     var Value:CommandHelper.EasingType = CommandHelper.EasingTypeArray[0]
    
    public func initialize(Delegate:PickerViewEvents)
    {
        DelegateSink = Delegate
        
        self.dataSource = self
        self.delegate = self
    }
    
    public func SetValue(value:CommandHelper.EasingType)
    {
        self.selectRow(CommandHelper.EasingTypeArray.firstIndex(of: value)!, inComponent: 0, animated: true)
    }
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CommandHelper.EasingTypeArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return CommandHelper.EasingTypeArray[row].rawValue
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        Value = CommandHelper.EasingTypeArray[row]
        
        if(DelegateSink != nil)
        {
            DelegateSink.PickerValueChanged(PickerType: PickerType)
        }
    }
}


