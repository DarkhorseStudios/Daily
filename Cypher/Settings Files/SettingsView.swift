//  SettingsView.swift
//  Cypher
//  Created by Zach Tidwell on 8/24/22.

import SwiftUI

struct SettingsView: View {

@ObservedObject var allSettings: AllSettings
    var body: some View {
NavigationView {
ZStack{
LinearGradient(colors: [allSettings.primaryBackgroundColor, allSettings.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

NavigationLink("Display") {
DisplaySettingsView(allSettings: allSettings)
}//NavLink
}//ZStack
}//NavView
.navigationTitle("Settings")
.font(.title)
    }//body
}//SettingsView

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(allSettings: AllSettings())
    }
}
