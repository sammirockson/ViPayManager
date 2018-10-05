//
//  AppDelegate.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/25.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import CoreData
import Parse
import GoogleMaps
import GooglePlaces

let defaultAppColor = RGB.sharedInstance.requiredColor(r: 51, g: 34, b: 211, alpha: 1.0)
let screenFrame = UIScreen.main.bounds


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().tintColor = defaultAppColor
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: FontNames.OpenSansBold, size: 14)!]
//        UINavigationBar.appearance().isTranslucent = false
        
        UITabBar.appearance().tintColor = RGB.sharedInstance.requiredColor(r: 51, g: 34, b: 211, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontNames.OpenSansSemiBold, size: 8)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontNames.OpenSansSemiBold, size: 8)!], for: .selected)
        
        Network.sharedInstance.initParse()
        
        if PFUser.current() == nil {
            window?.rootViewController = UINavigationController(rootViewController: LandingPageViewController())
        }else{
            window?.rootViewController = UINavigationController(rootViewController: CustomTabBarController())
        }
        GMSServices.provideAPIKey("AIzaSyBx2V7El0JtLsi3Gw7bl2KDaOAlyKSs78s")
        GMSPlacesClient.provideAPIKey("AIzaSyDKP_9FVscIh0eg02c1DRRCWWLJ6vQRKn8")
        GMSServices.provideAPIKey("AIzaSyDKP_9FVscIh0eg02c1DRRCWWLJ6vQRKn8")
        
    

        
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ViPayManager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

