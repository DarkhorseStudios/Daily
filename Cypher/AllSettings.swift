//  AllSettings.swift
//This class is where we store any settings information for displays and the like
//  Cypher
//  Created by Zach Tidwell on 8/24/22.

import Foundation
import SwiftUI

class AllSettings: ObservableObject {

//Published variabls for different things needed for settings.
@Published var primaryBackgroundColor = Color.black
@Published var secondaryBackgroundColor = Color.green
@Published var primaryFontColor = Color.white
@Published var secondaryFontColor = Color.red
//@ScaledMetric var fontSizeMultiplier = @Environment\.accessibilityVoiceOverEnabled
@Published var fontSize = 20
@Published var colorScheme = allColorSchemes().greenAndYellow

}//class
