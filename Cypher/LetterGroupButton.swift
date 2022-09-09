//
//  LetterGroupButton.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/1/22.
//

import SwiftUI

struct LetterGroupButton: View {

@State var name = "name not yet set"

    var body: some View {
        Button(name) {
//Maybe I can return the button name to update the current spelling
//self.name
}//Button
.clipShape(RoundedRectangle(cornerRadius: 5))
.border(.thickMaterial)
.background(.ultraThinMaterial)
.foregroundColor(.white)
.tint(.green)
    }//body
}//struct

struct LetterGroupButton_Previews: PreviewProvider {
    static var previews: some View {
        LetterGroupButton()
    }
}
