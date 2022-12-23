
import SwiftUI

class AllSettings: ObservableObject {

let defaultsManager = UserDefaultsManager()
//Published variabls for different things needed for settings.
//The values related to userDefaults are initialized in the .App file, and passed-in to the initializer for this class so they can be tracked. Any time these values change, we update them via property observers
@Published var colorScheme: ColorScheme
@Published var soundEffectsEnabled: Bool {
didSet {
defaultsManager.saveMusicEnabled(to: soundEffectsEnabled)
}//didset
}//soundEffectsEnabled
@Published var musicEnabled: Bool {
didSet {
defaultsManager.saveMusicEnabled(to: musicEnabled)
}//didset
}//musicEmabled

init() {
self.colorScheme = allColorSchemes().greenAndYellow
let defaultManager = UserDefaultsManager()
self.soundEffectsEnabled = defaultManager.getSoundEffectsEnabled()
self.musicEnabled = defaultManager.getMusicEnabled()
}//init
}//class
