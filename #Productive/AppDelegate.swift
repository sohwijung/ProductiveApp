//
//  AppDelegate.swift
//  #Productive
//
//  Created by Sohwi Jung on 11/19/19.
//  Copyright © 2019 Sohwi Jung. All rights reserved.
//

import UIKit
let userDefaults = UserDefaults.standard

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        userDefaults.register(defaults: [
            "username" : "default-blank-username"
 //           "username" : "kj228"
        ])
        window = UIWindow(frame: UIScreen.main.bounds)
        print(userDefaults.string(forKey: "username"))
        if (userDefaults.string(forKey: "username") != "default-blank-username"){
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
            print("path1")
        }else{
             window?.rootViewController = UINavigationController(rootViewController: SetUsernameViewController())
            print("path2")
         }
        window?.makeKeyAndVisible()

        return true
    }




}


