/*link to page to fix changing the background:
https://stackoverflow.com/questions/72005730/swift-ui-i-am-trying-to-change-the-background-it-is-giving-me-an-error-underimport SwiftUI
*/

import SwiftUI
struct DisplaySettingsView: View {

@ObservedObject var allSettings: AllSettings

    var body: some View {
        NavigationView {
        ZStack {
LinearGradient(colors: [allSettings.colorScheme.primaryBackgroundColor, allSettings.colorScheme.secondaryBackgroundColor], startPoint: .top, endPoint: .bottom)
.ignoresSafeArea()
VStack {
List {
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
.foregroundColor(allSettings.colorScheme.primaryFontColor)
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
