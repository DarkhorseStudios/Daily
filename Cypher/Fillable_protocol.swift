//  Fillable_protocol.swift
//  Cypher
// Any struct that needs to bring data in from json will conform to this protocol so that I can make sure these types all habve a fill() method
//  Created by Zach Tidwell on 8/25/22.
//

import Foundation

protocol Fillable {
mutating func fill(fromFile: String)
}//protocol
