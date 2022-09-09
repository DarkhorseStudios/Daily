//
//  HintAnswerView.swift
//  Cypher
//
//  Created by Zach Tidwell on 8/30/22.
//

import SwiftUI

struct HintAnswerView: View {

var activePuzzle = Puzzle()

    var body: some View {
List {
        VStack {
var currentHintAnswerPairs = activePuzzle.hintAnswerPairs
ForEach(currentHintAnswerPairs, id: \.answer) { pair in
HStack {
Text(pair.hint)
//Maybe a divider
Image(systemName: "\(pair.answer.count).circle")
}//HStack
}//ForEach
}//VStack
}//List
    }//body
}//struct

struct HintAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        HintAnswerView()
    }
}
