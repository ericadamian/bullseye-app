//
//  ContentView.swift
//  Bullseye
//
//  Created by Eric Adamian on 12/28/21.
//

import SwiftUI
import AppTrackingTransparency


struct ContentView: View {
    
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var game = Game()
    @State var name: String = "Tim"
    
    @EnvironmentObject var appData: AppDataModel
    
    
    // App Tracking Transparency: must delete and restart the app to work
    var body: some View {
        
        VStack {
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in })
        }
        
        Home()
            .environmentObject(appData)
      }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
