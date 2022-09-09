//This view is for when the player has successfully completed a puzzle
//  NextPuzzlePromptView.swift
//  Cypher
//
//  Created by Zach Tidwell on 8/29/22.
//

import SwiftUI

struct NextPuzzlePromptView: View {
//Some array to store different congats messages
let allSettings = AllSettings()
    var body: some View {
        NavigationView {
ZStack {
        LinearGradient(colors: [allSettings.primaryBackgroundColor, allSettings.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()

        VStack {
        Section {
Button("Next Puzzle") {
//Open Next Puzzle
}//Button
Button("Puzzlepacks") {
//Back to the list of all puzzles
}//Button
Button("Main Menu") {
//ContentView()
}//button
}//Section
}//VStack
}//ZStack
}//NavView
.navigationTitle("Placeholder")
    }//body
}//struct

struct NextPuzzlePromptView_Previews: PreviewProvider {
    static var previews: some View {
        NextPuzzlePromptView()
    }
}
