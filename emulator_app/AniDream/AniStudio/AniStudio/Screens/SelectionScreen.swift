//
//  SelectionScreen.swift
//  AniStudio
//
//  Created by Tej Kiran on 18/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import Foundation
import UIKit

class SelectionScreen: UIViewController,HomeScreenChildProtocol
{
    var homeScreenProtocol:HomeScreenProtocol!
    
    //HomeScreenChildProtocol
     func SetHomeScreen(HomeScreen : HomeScreenProtocol)
     {
        homeScreenProtocol = HomeScreen
     }
    //End of HomeScreenChildProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    @IBAction func btnShowEmotionScreen(_ sender: Any) {
        if(homeScreenProtocol != nil)
        {
            homeScreenProtocol.LoadScreen(Screen: HOME_SCREEN_TYPE.EMSYNTH)
        }
    }
    
    @IBAction func btnShowDanceScreen(_ sender: Any) {
        if(homeScreenProtocol != nil)
        {
            homeScreenProtocol.LoadScreen(Screen: HOME_SCREEN_TYPE.ACT)
        }
    }
    @IBAction func btnShowStoryScreen(_ sender: Any) {
        if(homeScreenProtocol != nil)
        {
            homeScreenProtocol.LoadScreen(Screen: HOME_SCREEN_TYPE.STORY)
        }
    }
}
