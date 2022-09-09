//
//  DisplaySettingsView.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/6/22.
//

import SwiftUI

struct DisplaySettingsView: View {

let allSettings: AllSettings
//let allColorSchemes: allColorSchemes
    var body: some View {
        NavigationView {
        ZStack {
LinearGradient(colors: [allSettings.primaryBackgroundColor, allSettings.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()
VStack {
List {
CustomStepper(allSettings: allSettings, boundValueName: "Font size", boundValue: allSettings.fontSize, incrementBy: 1)
.padding()
Section {
//HStack to center text
HStack {
Spacer()
Text("Selecting one of the buttons below will alter the colors used in the bacgrounds and fonts of the game.")
.font(.subheadline)
Spacer()
}//HStack
.padding()
Group {
let allColorSchemes = [allColorSchemes().blueAndWhite, allColorSchemes().greenAndYellow, allColorSchemes().purpleAndBlue]
ForEach(allColorSchemes, id: \.self.name) { scheme in
Button(scheme.name) {
allSettings.colorScheme = scheme
}//button
.foregroundColor(allSettings.primaryFontColor)
.background(.thickMaterial)
.border(.ultraThickMaterial)
.padding()
}//ForEach
}//Group
}//Section
.navigationTitle("Display Color Schemes")
}//List
.navigationTitle("What would you like to change?")
}//VStack
}//ZStack
}//NavView
.navigationTitle("Display Settings")
    }//body
}//struct

struct DisplaySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DisplaySettingsView(allSettings: AllSettings())
    }
}
