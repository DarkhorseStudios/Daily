import Foundation


class LetterGroupButtonData: ObservableObject, Identifiable {
//Gets uppercased() in initializer
@Published private(set) var name: String
@Published private(set) var shouldBeHidden = false
let id = UUID()

init(name: String) {
self.name = name.uppercased()
}//init

func setShouldBeHidden(_ new: Bool) {
shouldBeHidden = new
}
}//class
