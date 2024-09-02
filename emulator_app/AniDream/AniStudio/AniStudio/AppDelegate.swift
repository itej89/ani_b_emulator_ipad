//
//  AppDelegate.swift
//  AniStudio
//
//  Created by Tej Kiran on 14/04/19.
//  Copyright © 2019 FourierMachines. All rights reserved.
//

import UIKit
import FourierMachines_Ani_Client_System

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    public var airDropDelegate:AirDropDelegate!
    

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
       
         let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do{
            if FileManager.default.fileExists(atPath: documentsUrl.appendingPathComponent(url.pathComponents.last ?? "NewAudio.mp3").path)
            {
                try FileManager.default.removeItem(at: documentsUrl.appendingPathComponent(url.pathComponents.last ?? "NewAudio.mp3"))
            }
        }
        catch
        {
            print(error)
        }
        
         do {
            let AudioFileUrl = documentsUrl.appendingPathComponent(url.pathComponents.last ?? "NewAudio.mp3")
            try FileManager.default.copyItem(at: url, to: AudioFileUrl)
            print(url)
            if(airDropDelegate != nil)
            {
                airDropDelegate.FileAddedToDocuments(path: AudioFileUrl)
            }
        }
        catch
        {
            print(error)
        }
        
       
        let InboxUrl = documentsUrl.appendingPathComponent("Inbox")
        let enumerator = FileManager.default.enumerator(atPath: InboxUrl.path)
        
        
        while let element = enumerator?.nextObject() as? String {
            if element.hasSuffix("mp3") {
                do{
                    try FileManager.default.removeItem(atPath: InboxUrl.appendingPathComponent(element).path )
                }
                catch
                {
                    print(error)
                }
            }
        }
        
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

