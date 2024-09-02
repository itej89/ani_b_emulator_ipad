//
//  PickerViewBase.swift
//  AniStudio
//
//  Created by Tej Kiran on 29/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class PickerViewBase: UIPickerView
{
   public var DelegateSink:PickerViewEvents!
    
    var PickerType:PickerViewType = PickerViewType.NA
    
    @IBInspectable var TYPE:String = "NA"{
        willSet {
            // Ensure user enters a valid shape while making it lowercase.
            // Ignore input if not valid.
            if let newTYpe = PickerViewType(rawValue: newValue) {
                PickerType = newTYpe
            }
        }
    }
}
