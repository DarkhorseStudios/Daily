//
//  CustomShapeView.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/1/22.
//

import SwiftUI

struct CustomShapeView: Shape {
func path(in rect: CGRect) -> Path {
var path = Path()
path.move(to: CGPoint(x: rect.minX, y: rect.minY))

return path
}//func path
}//struct
