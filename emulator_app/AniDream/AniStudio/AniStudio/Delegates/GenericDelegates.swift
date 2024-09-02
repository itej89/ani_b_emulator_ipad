//
//  GenericDelegates.swift
//  BoltBot
//
//  Created by Uday on 13/05/17.
//  Copyright © 2017 itej89. All rights reserved.
//

import Foundation
import UIKit


protocol TranslationViewDelegates {
    func InitTranslate(sender:UIView)
    func Translated(sender:UIView,x:CGFloat, y:CGFloat)
    func EndTranslate(sender:UIView)
}

protocol AniStudioServiceDelegates {
    func RecievedResponseParameters(data:NSDictionary)
}



