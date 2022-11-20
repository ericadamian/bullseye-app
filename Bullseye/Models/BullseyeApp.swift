//
//  BullseyeApp.swift
//  Bullseye
//
//  Created by Eric Adamian on 12/28/21.
//

import SwiftUI
import Branch

@main
struct BullseyeApp: App {

    
    @StateObject var appData: AppDataModel = AppDataModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(appData)
                
                // this will check if our main deep link is used, or if it relies on fallback (within the console)
                .onOpenURL { url in
                    // used to fetch deep link url
                    if appData.checkDeepLink(url: url){
                        print("Deep link successful!")
                    }
                    else {
                        print("Fallback deep link successful!")
                    }
                    
                }
                
                // Branch SDK: pass the url to handle deep link call
                .onOpenURL(perform: { url in
                    Branch.getInstance().handleDeepLink(url)
                    
                    print("Incoming url: \(url)")
                    print(url.relativeString)
                    
                    // splitting the string
                    let route = url.relativeString.components(separatedBy: "://")
                    print( "Here's our route: \(route)")
                    
                    print("Route 0: \(route[0])")
                    print("Route 1: \(route[1])")
                    
                    if(route[0] == "bullseyeapp"){
                        print("Routed to: Bullseye App")
                    }
                    
                    if(route[1] == "branch"){
                        print("Routed to: Branch")
                    }
                    
                    
                    
                })
            
            
            
            
            
//                 test for opening url
//                .onOpenURL(perform: { url in
//                    print("Incoming url: \(url)")
//                    print(url.relativeString)
//
//                    // url as a variable (parsed url)
//
//                    // splitting the string
//                    let route = url.relativeString.components(separatedBy: "://")
//                    print( "Here's our route: \(route)")
//
//                    print("Route 0: \(route[0])")
//
                    
//
//                    let firstPath = route[0]
//                    let secondPath = route[1]
                    
//                    print(firstPath)
                    
//                    if firstPath == "bullseyeApp" {
//                        print("success!")
//                    }
//
//                    if secondPath == "branch" {
//                        print("success!")
//                    }
                    
//                    let route = url.relativeString.components(separatedBy: "://")
//                          if route.count <= 1 { return }
//
//                          let routePath = route[1]
//                          if routePath == "storyprompt" {
//                              self.window?.rootViewController!.performSegue(withIdentifier: "StoryPrompt", sender: nil)
//                          }
                    
//                })
            
            
        }
        
        
    }
}

