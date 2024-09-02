//
//  PickerViewVelocity.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

public class PickerViewVelocity:PickerViewBase, UIPickerViewDataSource, UIPickerViewDelegate
{
     var Value:Int = 0
    
    public func initialize(Delegate:PickerViewEvents)
    {
        DelegateSink = Delegate
        
        self.dataSource = self
        self.delegate = self
    }
    
    var Velocity:[[Int]] = [[1,2,3,4,5]]
    
    public func SetValue(value:Int)
    {
        if(Velocity[0].contains(value))
        {
         self.selectRow(value-1, inComponent: 0, animated: true)
        }
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Velocity.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Velocity[component].count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(describing: Velocity[component][row])
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        Value = Velocity[component][row]
        
        if(DelegateSink != nil)
        {
            DelegateSink.PickerValueChanged(PickerType: PickerType)
        }
    }
}
