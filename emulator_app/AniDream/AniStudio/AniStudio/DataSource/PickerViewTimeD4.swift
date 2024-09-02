//
//  PickerViewD4.swift
//  AniStudio
//
//  Created by Tej Kiran on 20/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

public class PickerViewTimeD4:PickerViewBase, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var Value:Int = 0
    
    public func initialize(Delegate:PickerViewEvents)
    {
        DelegateSink = Delegate
        
        self.dataSource = self
        self.delegate = self
    }
    
    var TimeD:[[Int]] = [ 
                   [0,1,2,3,4,5,6,7,8,9],
                   [0,1,2,3,4,5,6,7,8,9],
                   [0,1,2,3,4,5,6,7,8,9],
                   [0,1,2,3,4,5,6,7,8,9] ]
    
    var SelctionIndex:[Int] = [0,0,0,0]
    
    public func SetValue(value:Int)
    {
       Value  = value
        var remainder:Int = value
        
        for i in (0..<TimeD.count).reversed()
        {
            let divident:Int = remainder/Int(pow(Double(10), Double(i)))
            remainder = Int(remainder % Int(pow(Double(10), Double(i))))
            
            self.selectRow(divident, inComponent: TimeD.count-1-i, animated: true)
            SelctionIndex[TimeD.count-1-i] = divident
        }
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return TimeD.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return TimeD[component].count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(describing: TimeD[component][row])
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        SelctionIndex[component] = row
        
        Value = TimeD[0][SelctionIndex[0]] * Int(pow(10.0,3)) + TimeD[1][SelctionIndex[1]] * Int(pow(10.0,2)) + TimeD[2][SelctionIndex[2]] * Int(pow(10.0,1)) + TimeD[3][SelctionIndex[3]] * Int(pow(10.0,0))
        
        if(DelegateSink != nil)
        {
            DelegateSink.PickerValueChanged(PickerType: PickerType)
        }
    }
    
}
