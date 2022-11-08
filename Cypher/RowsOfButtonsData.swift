import Foundation

struct RowOfLetterGroupButtonData {
let indexInArrayOfRows: Int
//represents the buttons in each instance of this struct
private(set) var allButtonData = [LetterGroupButtonData]()

//methods

mutating func addButtonData(_ from: LetterGroupButtonData) {
allButtonData.append(from)
}//func
}//struct
