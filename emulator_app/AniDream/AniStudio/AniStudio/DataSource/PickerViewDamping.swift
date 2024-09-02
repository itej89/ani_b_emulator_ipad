//
//  PickerViewDamping.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

public class PickerViewDamping:PickerViewBase, UIPickerViewDataSource, UIPickerViewDelegate
{
    
     var Value:Int = 0
    
    public func initialize(Delegate:PickerViewEvents)
    {
        DelegateSink = Delegate
        
    self.dataSource = self
    self.delegate = self
}

var Damping:[[Int]] = [[1,2,3,4,5,6,7,8,9,10]]

    public func SetValue(value:Int)
    {
        if(Damping[0].contains(value))
        {
            self.selectRow(value-1, inComponent: 0, animated: true)
        }
    }
    
public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return Damping.count
}

public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Damping[component].count
}

public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
{
    return String(describing: Damping[component][row])
}
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        Value = Damping[component][row]
        
        if(DelegateSink != nil)
        {
            DelegateSink.PickerValueChanged(PickerType: PickerType)
        }
    }
}
