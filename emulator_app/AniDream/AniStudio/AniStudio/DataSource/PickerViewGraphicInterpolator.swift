//
//  PickerViewGraphicInterpolator.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

import GraphicAnimation

public class PickerViewGraphicInterpolator:PickerViewBase, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var Value:AnimationEasingTypes = AnimationEasingTypes.init(rawValue: 0) ?? AnimationEasingTypes.linear
    
    public func initialize(Delegate:PickerViewEvents)
    {
        DelegateSink = Delegate
        
        self.dataSource = self
        self.delegate = self
    }
    
    public func SetValue(value:AnimationEasingTypes)
    {
        self.selectRow(value.rawValue, inComponent: 0, animated: true)
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return AnimationEasingTypes.init(rawValue: row)?.description
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        Value = AnimationEasingTypes.init(rawValue: row) ?? AnimationEasingTypes.linear
        
        if(DelegateSink != nil)
        {
            DelegateSink.PickerValueChanged(PickerType: PickerType)
        }
    }
}


