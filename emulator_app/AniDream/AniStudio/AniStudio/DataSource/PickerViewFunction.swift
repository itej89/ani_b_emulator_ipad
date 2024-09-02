//
//  PickerViewFunction.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

import FourierMachines_Ani_Client_Kinetics
import GraphicAnimation

public class PickerViewFucntion:PickerViewBase, UIPickerViewDataSource, UIPickerViewDelegate
{

    
    var Value:CommandHelper.EasingFunction = CommandHelper.EasingFunctionArray[0]

    public func initialize(Delegate:PickerViewEvents)
    {
        DelegateSink = Delegate
        
        self.dataSource = self
        self.delegate = self
    }

    public func SetValue(value:CommandHelper.EasingFunction)
    {
        self.selectRow(CommandHelper.EasingFunctionArray.firstIndex(of: value)!, inComponent: 0, animated: true)
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CommandHelper.EasingFunctionArray.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return CommandHelper.EasingFunctionArray[row].rawValue
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        Value = CommandHelper.EasingFunctionArray[row]
        if(DelegateSink != nil)
        {
            DelegateSink.PickerValueChanged(PickerType: PickerType)
        }
    }
}

