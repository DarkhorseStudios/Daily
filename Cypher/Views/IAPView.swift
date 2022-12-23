import SwiftUI
//This is how we'll present in-app purchases to the user
/* tutorial:
https://blckbirds.com/post/how-to-use-in-app-purchases-in-swiftui-apps/
*/
struct IAPView: View {

@State private var selectedIAPKey = ""
var body: some View {

List {
VStack(alignment: .leading) {

}//VStack
Button() {
} label: {

if UserDefaults.standard.bool(forKey: selectedIAPKey) {
Text("You already own this Puzzle Pack")
} else {
Button("Purchase for $0.99") {
//conduct purchase
}//nested button
}//conditional
}//Button
}//list
.background(.clear)
.navigationTitle("Additional Puzzle Packs")
.toolbar() {
ToolbarItem(placement: .navigationBarTrailing) {
Button("Restore Purchases") {
//restore
}//button
}//toolbarItem
}//toolbar
}///body
}//struct

struct IAPView_Previews: PreviewProvider {
    static var previews: some View {
        IAPView()
    }
}
