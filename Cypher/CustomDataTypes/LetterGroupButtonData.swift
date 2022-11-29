import Foundation

class LetterGroupButtonData: ObservableObject, Codable, Identifiable, Hashable {
//Gets uppercased() in initializer
@Published private(set) var name: String
@Published private(set) var shouldBeHidden = false {
didSet {
if shouldBeHidden {
appearanceData.setOpacity(0.85)
appearanceData.setRotationAmount(180.0)
self.appearanceData.setAccessibilityLabel("Dimmed: \(name)")
self.appearanceData.setAccessibilityLabelShouldBeReadAsCharacters(false)
} else {
appearanceData.setOpacity(1.0)
appearanceData.setRotationAmount(0.0)
appearanceData.setAccessibilityLabel(name.lowercased())
appearanceData.setAccessibilityLabelShouldBeReadAsCharacters(true)
}//conditional
}//didset
}//shouldBeHidden
let id: UUID
@Published private(set) var appearanceData: LetterGroupButtonAppearanceData

init(name: String) {
self.name = name.uppercased()
self.appearanceData = LetterGroupButtonAppearanceData(accessibilityLabel: name.lowercased(), accessibilityLabelShouldBeReadAsCharacters: true)
self.id = UUID()
}//init

required init(from decoder: Decoder) throws {
let container = try decoder.container(keyedBy: CodingKeys.self)

name = try container.decode(String.self, forKey: .name)
shouldBeHidden = try container.decode(Bool.self, forKey: .shouldBeHidden)
appearanceData = try container.decode(LetterGroupButtonAppearanceData.self, forKey: .appearanceData)
if let loadedID = try? container.decode(UUID.self, forKey: .id) {
id = loadedID
} else {
id = UUID()
}//unwrap for id
}//required init

func encode(to encoder: Encoder) throws {
var container = try encoder.container(keyedBy: CodingKeys.self)

try container.encode(name, forKey: .name)
try container.encode(shouldBeHidden, forKey: .shouldBeHidden)
try container.encode(appearanceData, forKey: .appearanceData)
try container.encode(id, forKey: .id)

}//encode

enum CodingKeys: CodingKey {
case name, shouldBeHidden, id, appearanceData
}//CodingKeys
func setShouldBeHidden(_ new: Bool) {
shouldBeHidden = new
}//shouldBeHidden

func hash(into hasher: inout Hasher) {
hasher.combine(id)
}//hash
static func ==(lhs: LetterGroupButtonData, rhs: LetterGroupButtonData) -> Bool{
return lhs.id == rhs.id
}// ==

class LetterGroupButtonAppearanceData: Codable {

//All of thesevalues are updated in the property observer for shouldBeHidden in LetterGroupButtonData
private(set) var accessibilityLabel: String
private(set) var accessibilityLabelShouldBeReadAsCharacters: Bool
private(set) var opacity = 1.0
private(set) var rotationAmount = 0.0

init(accessibilityLabel: String, accessibilityLabelShouldBeReadAsCharacters: Bool) {
self.accessibilityLabel = accessibilityLabel
self.accessibilityLabelShouldBeReadAsCharacters = accessibilityLabelShouldBeReadAsCharacters
}//init

//methods
func setAccessibilityLabel(_ new: String) {
accessibilityLabel = new
}//setAccessibilityLabel
func setAccessibilityLabelShouldBeReadAsCharacters(_ new: Bool) {
accessibilityLabelShouldBeReadAsCharacters = new

}//accessibilityLabelShouldBeReadAsCharacters
func setOpacity(_ new: Double) {
opacity = new
}//setOpacity
func setRotationAmount(_ new: Double) {
rotationAmount = new
}//setRotationAmount
}//nested class
}//class
