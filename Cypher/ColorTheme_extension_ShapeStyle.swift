//
//  ColorTheme_extension_ShapeStyle.swift
//  Cypher
//
//  Created by Zach Tidwell on 8/27/22.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }//dark

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }//light
}//extension
