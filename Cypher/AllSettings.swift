import Foundation
import SwiftUI

class AllSettings: ObservableObject {

//Published variabls for different things needed for settings.
//@ScaledMetric var fontSizeMultiplier = @Environment\.accessibilityVoiceOverEnabled
@Published var colorScheme = allColorSchemes().greenAndYellow
}//class
