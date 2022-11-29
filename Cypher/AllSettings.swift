
import SwiftUI

class AllSettings: ObservableObject {

//Published variabls for different things needed for settings.
@Published var colorScheme = allColorSchemes().greenAndYellow
@Published var soundEffectsEnabled = false
@Published var soundEffectsVolume = 50.0
@Published var musicEnabled = false
@Published var musicVolume = 50.0
}//class
