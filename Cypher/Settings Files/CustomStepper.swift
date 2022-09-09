//
//  CustomPicker.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/6/22.
//

import SwiftUI

struct CustomStepper: View {
@ObservedObject var allSettings: AllSettings
//this property is iused for setting the Text view and accessibility labels for the buttons
@State var boundValueName: String
@State var boundValue: Int
var incrementBy: Int

    var body: some View {
        HStack {

 //The two buttons are contained in VStacks so they will be smaller than the Text view that displays the font size
VStack {
Spacer()
Button() {
boundValue -= incrementBy
} label: {
Image(systemName: "minus")
.resizable()
.scaledToFit()
.tint(allSettings.primaryFontColor)
.accessibilityLabel("Decrease \(boundValueName)")
}//Button
.background(.thinMaterial)
.border(.thickMaterial)

Spacer()

}//VStack for minus button

Text(String(boundValue))
//.border(.thickMaterial)
.border(.ultraThickMaterial)
.padding(.horizontal)

VStack {
Spacer()
Button() {
boundValue += incrementBy
} label: {
Image(systemName: "plus")
.resizable()
.scaledToFit()
.tint(allSettings.primaryFontColor)
.accessibilityLabel("Increase \(boundValueName)")
}//Plus button

.background(.thinMaterial)
.border(.thickMaterial)

Spacer()
}//Vstack for plus button
        }//HStack
        .navigationTitle(boundValueName)
    }//body
}//struct

struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
    let allSettings = AllSettings()
    var boundValue = allSettings.fontSize
    var boundValueName = "some value"
        CustomStepper(allSettings: allSettings, boundValueName: boundValueName, boundValue: boundValue, incrementBy: 1)
    }
}
