//
//  Company.swift
//  Bullseye
//
//  Created by Eric Adamian on 1/17/22.
//

import Foundation
import SwiftUI

// company tags associated with each value in the array
struct Company: Identifiable{
    var id: String
    var title: String
    var description: String
    var productImage: String
    var productPrice: String
}


// company array: associates ID's with each deep link
var companies: [Company] = [
    Company(id: "branch", title: "Branch", description: "More expensive than its competitors, but higher quality solutions!", productImage: "Branch", productPrice: "$175,000"),
    Company(id: "appsflyer", title: "AppsFlyer", description: "Cheaper solution than Branch and offers less, but used by most.", productImage: "AppsFlyer", productPrice: "$95,000"),
    Company(id: "adjust", title: "Adjust", description: "An alternative solution to Branch or AppsFlyer.", productImage: "Adjust", productPrice: "$105,000"),
]
