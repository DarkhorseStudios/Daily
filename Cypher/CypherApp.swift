//
//  CypherApp.swift
//  Cypher
//
//  Created by Zach Tidwell on 8/24/22.
//

import SwiftUI

@main
struct CypherApp: App {

//we initialize userDefaults with preferred default values. This method won't overwrite any choices made by the user.
init() {
let userDefaultsManager = UserDefaultsManager()
UserDefaults.standard.register(defaults: [
userDefaultsManager.soundEffectsEnabledKey: true,
userDefaultsManager.musicEnabledKey: true
 ])
 }//init
//Initialized this oject for this tutorial on IAP: https://blckbirds.com/post/how-to-use-in-app-purchases-in-swiftui-apps/
@StateObject var storeManager = StoreManager()
/*This initializer is according to this article for using AdMob with SwiftUI:
https://jacobko.info/swiftui/swiftui-12/
*/
//init() {
//GADMobileAds.sharedInstance().start(completionHandler: nil)
//}//init
    var body: some Scene {
        WindowGroup {
            ContentView(storeManager: storeManager)
        }
    }
}
