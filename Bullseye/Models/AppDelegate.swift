//
//  AppDelegate.swift
//  Bullseye
//
//  Created by Eric Adamian on 1/12/22.
//

import Foundation
import UIKit
import Branch

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // test Branch SDK (should return data in the console)
        // Branch.getInstance().enableLogging()
        
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
        }
        
        return true
    }
    
    
    
    

    
    
}
