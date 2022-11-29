import SwiftUI

struct ColorScheme {
let name: String
let primaryBackgroundColor: Color
let secondaryBackgroundColor : Color
var primaryFontColor: Color
var secondaryFontColor: Color
var isLightScheme: Bool {
didSet {
if self.isLightScheme == false {
primaryFontColor = .white
secondaryFontColor = .black
} else {
primaryFontColor = .black
secondaryFontColor = .white
}//conditional
}//didSet
}//computed property isLightScheme

}//struct
