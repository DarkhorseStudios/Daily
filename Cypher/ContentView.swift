//  ContentView.swift
//  Cypher
//  Created by Zach Tidwell on 8/24/22.

import SwiftUI

struct ContentView: View {
/* Things to fix:
NavLinks are different sizes. Need a way to standardize the,. probably using geometryReader
-Maybe track down some different fonts.
*/
//This is passed into the environment
@StateObject var allSettings = AllSettings()
//We initialize PuzzlePackData in ContentView so that it is all available and only needs to be intialized when the app opens
@StateObject var allPuzzlePacks = AllPuzzlePacks()

//This wrapper accesses user defaults, but allows us to store a default value, unlike directly accessing UserDefaults
//Additionally, this wrapper is monitored jiust like @State
//@AppStorage("exampleKey") private var someSaveValue = "99"
@State private var showingPuzzlePacksView = false
    var body: some View {
//NavigationView {
ZStack{
RadialGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], center: .center, startRadius: 300, endRadius: 50)
.ignoresSafeArea()
VStack {

Spacer()
//Something to display the game name
HStack {
Spacer()
Text("Welcome to Cypher")
.font(.largeTitle.bold())
.foregroundColor(allSettings.colorScheme.primaryFontColor)
.background(.clear)
Spacer()
}//HStack

Spacer()

//We wrap this list in a HStack so it's centered.
HStack {
Spacer()
//These buttons are contained in a group so I can apply modifiers to each of them with less code
Group {
Button("Test Puzzle View") {
showingPuzzlePacksView.toggle()
}//button
.sheet(isPresented: $showingPuzzlePacksView) {
PuzzlePacksView(showing: $showingPuzzlePacksView)
}//sheet
VStack {
//For now, each of the buttons is the same. However, I want to make the New Game button more prominent, and have it be replaced with Resume Game if a saved game exists//Should I put these smaller buttons in a section?
NavigationLink("Puzzles") {
//PuzzlePacksView()
}//navLink
.font(.title)
.foregroundColor(.black)
NavigationLink("Settings") {
DisplaySettingsView(allSettings: allSettings)
}//NavLink
.font(.title)
.foregroundColor(.black)
}//VStack
}//Group

Spacer()
}//HStack cotaining list of Navigation Links

//Version is contained in a HStack to center it.
HStack {
Spacer()
Text("Version: Still need to add a version")
.tint(allSettings.colorScheme.secondaryFontColor)
.background(.clear)
.font(.footnote)
Spacer()
}//HStack
Spacer()
}//VStack
}//ZStack
.navigationTitle("Welcome to Cypher")
.font(.largeTitle)
//}//NavView
.onAppear() {
allPuzzlePacks.initializeData()
}//onAppear
.environmentObject(allSettings)
.environmentObject(allPuzzlePacks)

}//body
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
