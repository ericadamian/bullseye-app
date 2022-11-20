//
//  AppDataModel.swift
//  Bullseye
//
//  Created by Eric Adamian on 1/17/22.
//

import Foundation
import SwiftUI

class AppDataModel: ObservableObject {
 
    @Published var currentTab: Tab = .home
    @Published var currentDetailPage: String?
    
    func checkDeepLink(url: URL)->Bool{
        
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return false
        }
        
        // updating tabs
        if host == Tab.home.rawValue{
            currentTab = .home
        }
        else if host == Tab.search.rawValue{
            currentTab = .search
        }
        else if host == Tab.settings.rawValue{
            currentTab = .settings
        }
        else{
            return checkInternalLinks(host: host)
        }
        return true
    }
    
    
    func checkInternalLinks(host: String)->Bool{
        
        // checking if host contains any navigation link ids
        if let index = companies.firstIndex(where: { company in
            return company.id == host
        }){
            // defaults to search tab (since nav links are in search tab)
            currentTab = .search
            currentDetailPage = companies[index].id
            
            return true
        }
        return false
    }
}

// tab enum
enum Tab: String{
    case home = "home"
    case search = "search"
    case settings = "settings"
}
