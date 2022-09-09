//
//  PuzzlePacksView.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/5/22.
//

import SwiftUI

struct PuzzlePacksView: View {

@ObservedObject var allSettings: AllSettings
@StateObject var userPuzzleData = UserPuzzleData()
    var body: some View {
        NavigationView {
        ZStack {
        LinearGradient(colors: [allSettings.primaryBackgroundColor, allSettings.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()
ScrollView {
//Unstarted puzzles
LazyVStack {
ForEach(userPuzzleData.unstartedPuzzleFileNames, id: \.self) { fileName in
HStack {
//We use buttons instead of NavLinks because the navLink can't call functionality before populating a new view
Button(fileName) {
//toggle the puzzle to started and move it to the corresponding array

if let newPuzzle = try? Puzzle().fill(fromFile: fileName) {
//We set the puzzles to started and shuffle them between the different arrays for their names in the active puzzle view, after the first word has been solved.
ActivePuzzleView(allSettings: allSettings, currentPuzzle: newPuzzle)
} else {
fatalError("")
}//if lety
}//button
}//HStack
.clipShape(RoundedRectangle(cornerRadius: 5))
.foregroundColor(allSettings.primaryFontColor)
.background(.thinMaterial)
.border(.thickMaterial)
.padding()
}//ForEach
}//Lazy V
.navigationTitle("Unstarted Puzzles")
.padding()
}//ScrollView
}//ZStack
}//NavView
.navigationTitle("All Puzzles")
    }//body
}//struct

struct PuzzlePacksView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzlePacksView(allSettings: AllSettings())
    }
}
