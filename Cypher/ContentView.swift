//  ContentView.swift
//  Cypher
//  Created by Zach Tidwell on 8/24/22.

import SwiftUI

struct ContentView: View {

//is passed-in during initialization in the .app file
@ObservedObject var storeManager: StoreManager
//This is passed into the environment
@StateObject var allSettings = AllSettings()
//We initialize PuzzlePackData in ContentView so that it is all available and only needs to be intialized when the app opens
@StateObject var allPuzzlePacks = AllPuzzlePacks()
//contains all of the booleans that are passed to sheet views as bindings so we can dismiss multiple views in a stack
@StateObject var allSheetViewBooleans = AllSheetViewBooleans()

//This wrapper accesses user defaults, but allows us to store a default value, unlike directly accessing UserDefaults
//Additionally, this wrapper is monitored jiust like @State
//@AppStorage("exampleKey") private var someSaveValue = "99"
    var body: some View {
NavigationView {
ZStack{
RadialGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], center: .center, startRadius: 300, endRadius: 50)
.ignoresSafeArea()
VStack {
Button("Test puzzles for spelling errors") {
SpellingTest().testAllPuzzles(allPuzzlePacks: allPuzzlePacks)
}
Spacer()
//Something to display the game name
HStack {
Spacer()
Text("Welcome to Zanagrams")
.font(.largeTitle.bold())
.shadow(radius: 10.0)
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.background(.clear)
.accessibilityHeading(.h1)
Spacer()
}//HStack

Spacer()

//We wrap this list in a HStack so it's centered.
HStack {
Spacer()
//These buttons are contained in a group so I can apply modifiers to each of them with less code
Group {
VStack {
//For now, each of the buttons is the same. However, I want to make the New Game button more prominent, and have it be replaced with Resume Game if a saved game exists//Should I put these smaller buttons in a section?

NavigationLink() {
PuzzlePacksView()
} label: {
	Button("Puzzles") {
allSheetViewBooleans.showingPuzzlePacksView = true
}//button
.font(.title)
.clipShape(Capsule())
}//navLink

NavigationLink() {
DisplaySettingsView(allSettings: allSettings)
} label: {
	Button("Settings") {
//has no functionality, is only here to make the nav link look like a buton
}//Button
.font(.title)
.clipShape(Capsule())
}//NavLink
}//VStack
}//Group

Spacer()
}//HStack cotaining list of Navigation Links

//Version is contained in a HStack to center it.
HStack {
Spacer()
Text("Version: Alpha 1.0.0")
.tint(allSettings.colorScheme.secondaryFontColor)
.background(.clear)
.font(.footnote)
Spacer()
}//HStack
Spacer()
//This is an id from the test ads, not my app
//BannerAd(unitID: "ca-app-pub-3940256099942544/2934735716")
}//VStack
}//ZStack
}//NavView
.onAppear() {
//PuzzlePacksView needs this to be initialized to draw the DisclosureGrops for puzzle packs, and GameData needs it to intialize data for puzzles
allPuzzlePacks.initializeData()
}//onAppear
.environmentObject(allSettings)
.environmentObject(allSheetViewBooleans)
.environmentObject(allPuzzlePacks)

}//body
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ContentView preview")
    }
}
