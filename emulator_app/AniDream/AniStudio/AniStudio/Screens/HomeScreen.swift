//  HomeScreen.swift
//  AniStudio
//
//  Created by Tej Kiran on 17/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.

import Foundation
import UIKit
import FourierMachines_Ani_Client_System

extension HomeScreen:  HomeScreenProtocol, MainScreenEventProtocol
{
    
    //MainScreenEventProtocol
    func NodeTouched(Node : MODEL_NODE_TYPE)
    {
        if(mainScreenEventProtocol != nil)
        {
            mainScreenEventProtocol.NodeTouched(Node: Node)
        }
    }
    //End of MainScreenEventProtocol
    
    //HomeScreenProtocol
    
    func LoadScreen(Screen: HOME_SCREEN_TYPE) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
     
        switch Screen {
        case HOME_SCREEN_TYPE.EMSYNTH:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "EMSYNTHSCREEN") as! EmSynthScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            
           UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartBrowseAnimationsJob()
            
            
        case HOME_SCREEN_TYPE.EMOTION:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "EMOTIONSCREEN") as! EmotionScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            
            
            
  
        case HOME_SCREEN_TYPE.ACT:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "ACTSCREEN") as! ActionsScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartBrowseAnimationsJob()
            
            
        case HOME_SCREEN_TYPE.BEAT:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "BEATSCREEN") as! BeatsScreen
            
           
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartChoreogramJob()
            

        case HOME_SCREEN_TYPE.STORY:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "STORYSCREEN") as! EmotionScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
        }
    }
    
    func GoBack(Screen: HOME_SCREEN_TYPE)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        switch Screen {
        case HOME_SCREEN_TYPE.EMSYNTH:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "SELECTSCREEN") as! SelectionScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowIdle()
            
        case HOME_SCREEN_TYPE.EMOTION:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "EMSYNTHSCREEN") as! EmSynthScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            
   
        case HOME_SCREEN_TYPE.ACT:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "SELECTSCREEN") as! SelectionScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowIdle()
            
        case HOME_SCREEN_TYPE.BEAT:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "ACTSCREEN") as! ActionsScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
            UIMAINModuleHandler.Instance.GetUIMainConveyListener().StartBrowseAnimationsJob()
            
        case HOME_SCREEN_TYPE.STORY:
            // Instantiate View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "SELECTSCREEN") as! SelectionScreen
            
            (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
            
            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)
        }
    }
    
    //End of HomeScreenProtocol
}



 class HomeScreen: UIViewController
{
    
   var PresentedViewController : UIViewController!
   var mainScreenEventProtocol:MainScreenEventProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "SELECTSCREEN") as! SelectionScreen
        
        (viewController as HomeScreenChildProtocol).SetHomeScreen(HomeScreen: self as HomeScreenProtocol)
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        UIMAINModuleHandler.Instance.GetUIMainConveyListener().ShowIdle()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
  
    
    private func add(asChildViewController viewController: UIViewController) {
        
        mainScreenEventProtocol =  nil
        
        if(PresentedViewController != nil)
        {
            remove(asChildViewController: PresentedViewController)
        }
        
        // Add Child View Controller
        addChild(viewController)
        
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
        PresentedViewController = viewController;
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
        
        
    }
}
