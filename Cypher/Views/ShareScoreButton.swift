import SwiftUI

struct ShareScoreButton: View {

let appStoreLink = URL(string: "https://zachtidwell.net")
//Used to get the score and puzzle name
//let completedPuzzle: Puzzle

var body: some View {
Button() {
} label: {
ShareLink("Share your score", item: appStoreLink!, message: Text("Good luck beating this."))
}//Button

}//body
}//struct

struct ShareScoreSheet_Previews: PreviewProvider {
    static var previews: some View {
        Text("ShareScoreSheetPreview")
    }
}
