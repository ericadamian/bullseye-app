//
//  Home.swift
//  Bullseye
//
//  Created by Eric Adamian on 1/17/22.
//


import SwiftUI
import Branch

struct Home: View {
    
    @State private var sliderValue = 50.0
    @State private var animationAmount = 1.0
    @State private var count = 0
    @State private var alertIsVisible = false
    @State private var game = Game()
    @State private var tabSelection = Tab.home
    
    // Create a BranchUniversalObject with your content data:
    let branchUniversalObject = BranchUniversalObject.init()
    
    
// *********************************************************************************************************
    // event tracking
    
    // commerce event
    func commerceEvent() {
        count += 1
        
        
            // ...add data to the branchUniversalObject as needed...
            branchUniversalObject.canonicalIdentifier = "item/12345"
            branchUniversalObject.canonicalUrl        = "https://branch.io/item/12345"
            branchUniversalObject.title               = "My Item Title"

            branchUniversalObject.contentMetadata.contentSchema     = .commerceProduct
            branchUniversalObject.contentMetadata.quantity          = 1
            branchUniversalObject.contentMetadata.price             = 23.20
            branchUniversalObject.contentMetadata.currency          = .USD
            branchUniversalObject.contentMetadata.sku               = "1994320302"
            branchUniversalObject.contentMetadata.productName       = "my_product_name1"
            branchUniversalObject.contentMetadata.productBrand      = "my_prod_Brand1"
            branchUniversalObject.contentMetadata.productCategory   = .apparel
            branchUniversalObject.contentMetadata.productVariant    = "XL"
            branchUniversalObject.contentMetadata.condition         = .new
            branchUniversalObject.contentMetadata.customMetadata = [
                        "custom_key1": "custom_value1",
                        "custom_key2": "custom_value2"
                    ]

            // Create a BranchEvent:
            let event = BranchEvent.standardEvent(.viewAd)

            // Add the BranchUniversalObject with the content (do not add an empty branchUniversalObject):
            event.contentItems     = [ branchUniversalObject ]

            // Add relevant event data:
            event.alias            = "my custom alias"
            event.transactionID    = "12344555"
            event.currency         = .USD
            event.revenue          = 1.5
            event.shipping         = 10.2
            event.tax              = 12.3
            event.coupon           = "test_coupon"
            event.affiliation      = "test_affiliation"
            event.eventDescription = "Event_description"
            event.searchQuery      = "item 123"
            event.customData       = [
                "Custom_Event_Property_Key1": "Custom_Event_Property_val1",
                "Custom_Event_Property_Key2": "Custom_Event_Property_val2"
            ]
        event.logEvent() // Log the event.
    }
    
    
    // content event
    func contentEvent() {
        count += 1
        
        // LOG EVENTS: content views
        let event = BranchEvent.standardEvent(.viewItem)
        event.alias = "my custom alias"
        event.eventDescription = "Product Search"
        event.searchQuery = "user search query terms for product xyz"
        event.customData["Custom_Event_Property_Key1"] = "Custom_Event_Property_val1"
        event.logEvent()
    }
    
    
    // lifecycle event
    func lifecycleEvent() {
            let url = URL(string: "https://bullseye.app.link/g6pJtlzIVmb")
            let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)

            UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
        
            count += 1
        
            let event = BranchEvent.standardEvent(.invite)
            event.alias = "my custom alias"
            event.transactionID = "tx1234"
            event.eventDescription = "User completed registration."
            event.customData["registrationID"] = "12345"
            event.logEvent()
    }
    
    // custom event
    func customEvent() {
        count += 1
        
        let event = BranchEvent.customEvent(withName: "SHORTCUT")
            event.customData["Custom_Event_Property_Key1"] = "Custom_Event_Property_val1"
            event.customData["Custom_Event_Property_Key2"] = "Custom_Event_Property_val2"
          event.alias = "my custom alias"
            event.logEvent()
    }
    
// *********************************************************************************************************
    
    // UI for app
//    let routing = unwrapParams()
    
    
    func displayRouting() {
        let sessionParams = Branch.getInstance().getLatestReferringParams()
        
        if (sessionParams?["+clicked_branch_link"] != nil) == true {
            if sessionParams?["$canonical_url"] != nil {
                var dl_param = sessionParams?["$canonical_url"] as! String
                print(dl_param)
            }
        }else{
            print("default")
        }
    }
    
    @EnvironmentObject var appData: AppDataModel
        var body: some View {
            
            
            TabView(selection: $appData.currentTab) {
                
                VStack () {
                    
                    Text("🎯🎯🎯\nPUT THE BULLSEYE AS CLOSE AS YOU CAN TO")
                        .bold()
                        .kerning(2.0)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4.0)
                        .font(.footnote)
                    Text(String(game.target))
                        .kerning(-1.0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    HStack {
                        Text("1")
                            .bold()
                        Slider(value: $sliderValue, in: 1.0...100.0)
                        Text("100")
                            .bold()
                    }
                    Button(action: {contentEvent()
                        print("Hello, SwiftUI!")
                        alertIsVisible = true
                        
                        
                    }) {
                        Text("Hit me")
                    }
                    
                    Text("The count is: \(self.count)")
                    
                    .alert(isPresented: $alertIsVisible, content: {
                        let roundedValue = Int(sliderValue.rounded())
                        return Alert(title: Text("Hello there!"), message: Text("The slider's value is \(roundedValue).\n" + "You scored \(game.points(sliderValue: roundedValue)) points this round"), dismissButton: .default(Text("Awesome!")))

                    })
                    
                    // routing button
                    Button(action: {displayRouting()
                        
                        print("routing button triggered!")
                        
                    }, label: {
                        Label("Routing", systemImage: " ")
                                
                    })
                    
                    
                    // LOG EVENTS: commerce events
                    Button(action: {commerceEvent()
                        
                        print("count worked!")
                        
                    }, label: {
                        Text("Ad")
                        Image("reywenderlich").renderingMode(.original)
                            .resizable()
                                .frame(width: 40, height: 40)
                        
                        Label("reywenderlich.com", systemImage: " ")
                                
                    })
                    
                    .buttonStyle(.borderedProminent)
                    .overlay(
                        Rectangle()
                            .stroke(.black)
                            .scaleEffect(animationAmount)
                            .opacity(1.5 - animationAmount)
                            .animation(
                                .easeInOut(duration: 2.5)
                                    .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                    )
                    .onAppear {
                        animationAmount = 2
                    }
                    .padding(.top, 100)
                    
                    Text("The count is: \(self.count)")
                    
                    
                }.padding(.top, 250)
                
                
                
                    .tag(Tab.home)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                SearchView()
                    .environmentObject(appData)
                    .tag(Tab.search)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                
                
                VStack {
                    Text("Settings").font(.system(size: 30, weight: .bold)).padding(.top, 40)
                    
                    Text("Shortcut buttons:").font(.system(size: 20 , weight: .bold)).padding(.top, 60)
                    
                    Text("Press your favorite button and").font(.system(size: 16)).padding(.top, 5)
                    Text("click on the search tab.").font(.system(size: 16))
                    
                    Button("Branch") {
                        appData.currentDetailPage = companies[0].id
                    }
                        .tint(.green)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                        .padding(.top, 10)
                    
                    Button("AppsFlyer") {
                        appData.currentDetailPage = companies[1].id
                    }
                        .tint(.green)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                    
                    
                    Button(action: {customEvent()
                        appData.currentDetailPage = companies[2].id
                        print("count worked!")
                        
                    }, label: {
                        Text("Adjust")
        
                        
                                
                    }).tint(.green)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                     
                    
                
                    
                    Text("Share the app!").padding(.top, 50)
                    
                    // lifecycle event
                    Button(action: lifecycleEvent) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.black).padding(5)
                        
                    }
                    
                    Text("The count is: \(self.count)")
                    
                    
                }
                
                    .tag(Tab.settings)
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                
                // HERE, input if/else statement for params.canonicalURL comparison
                // https://stackoverflow.com/questions/62504400/programmatically-change-to-another-tab-in-swiftui/62504503
                
    
            }
        }
        
        
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Search View
struct SearchView: View{
    @EnvironmentObject var appData: AppDataModel
    
    var body: some View{
        
        NavigationView{
            
            List{
                
                // list of available companies
                ForEach(companies){company in
                    
                    NavigationLink(tag: company.id, selection: $appData.currentDetailPage) {
                        DetailView(company: company)
                    } label: {
                        
                        HStack(spacing: 15){
                            
                            Image(company.productImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                Text(company.title)
                                    .font(.body.bold())
                                    .foregroundColor(.primary)
                                
                                Text(company.productPrice)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                            }
                            
                        }
                    }
                    
                }
            }
            .navigationTitle("Search")
            
            // this is just a routing test
            .toolbar {
                Button("Go to Branch"){
                    appData.currentDetailPage = companies[0].id
                }
            }
        }
    }
    
    // detail view
    @ViewBuilder
    func DetailView(company: Company)->some View{
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                Image(company.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 280)
                    .cornerRadius(1)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(company.title)
                        .font(.title.bold())
                        .foregroundColor(.primary)
                    
                    Text(company.productPrice)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text(company.description)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
            
        }
        .navigationTitle(company.title)
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
    
}


//func unwrapParams() -> String {
//    let sessionParams = Branch.getInstance().getLatestReferringParams()
//
//    if (sessionParams?["+clicked_branch_link"] != nil) == true {
//        if sessionParams?["$canonical_url"] != nil {
//            var dl_param = sessionParams?["$canonical_url"] as! String
//            // 17 because value is "https://eric.com/" is 17 characters
//            let index = dl_param.index(dl_param.startIndex, offsetBy: 17)
//            dl_param = String(dl_param[index...])
//            print(dl_param)
//            return dl_param
//        }
//    }
//
//    let ret = "branch"
//    return ret
//}
