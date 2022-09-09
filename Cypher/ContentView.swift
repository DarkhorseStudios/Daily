//  ContentView.swift
//  Cypher
//  Created by Zach Tidwell on 8/24/22.

import SwiftUI

struct ContentView: View {

@StateObject var allSettings = AllSettings()
//This wrapper accesses user defaults, but allows us to store a default value, unlike directly accessing UserDefaults
//Additionally, this wrapper is monitored jiust like @State
@AppStorage("exampleKey") private var someSaveValue = "99"
    var body: some View {
NavigationView {
ZStack{
RadialGradient(colors: [allSettings.primaryBackgroundColor, allSettings.secondaryBackgroundColor], center: .center, startRadius: 300, endRadius: 50)
.ignoresSafeArea()
VStack {
//Something to display the game name

//We wrap this list in a HStack so it's centered.
HStack {
Spacer()
//These buttons are contained in a group so I can apply modifiers to each of them with less code
Group {
VStack {
//For now, each of the buttons is the same. However, I want to make the New Game button more prominent, and have it be replaced with Resume Game if a saved game exists//Should I put these smaller buttons in a section?
NavigationLink("Puzzles") {
PuzzlePacksView(allSettings: allSettings)
}//navLink
NavigationLink("Settings") {
SettingsView(allSettings: allSettings)
}//Navview
}//VStack
}//Group

Spacer()
}//HStack cotaining list of Navigation Links

//Version is contained in a HStack to center it.
HStack {
Spacer()
Text("Version: Still need to add a version")
.background(.clear)
.border(.clear)
.font(.footnote)
Spacer()
}//HStack
}//VStack
}//ZStack
}//NavView
.navigationTitle("Welcome to Cypher")
.onAppear{
guard let newPuzzle = try? Puzzle().fill(fromFile: "TestPuzzle.json") else {
fatalError("Test for filling puzzles in ContentView's onAppear call failed") }//onAppear
}//guard
}//body
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
