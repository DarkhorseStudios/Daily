//
//  DecodePuzzle_extension.swift
//  Cypher
//
//  Created by Zach Tidwell on 8/27/22.
//

import Foundation
import SwiftUI

extension Bundle {
func decodePuzzle(fromFile: String) -> Puzzle {
guard let url = self.url(forResource: fromFile, withExtension: "json") else {
print("fileName was \(fromFile)")
fatalError("failed to locate \(fromFile) with a json extension in Bundle")
}//guard
guard let data = try? Data(contentsOf: url) else {
fatalError("PuzzleDecoder failed to  load \(fromFile) into Data()")

}//guard

let decoder = JSONDecoder()
guard let loaded = try? decoder.decode(Puzzle.self, from: data) else {
fatalError("not loaded")
}//guard

return loaded
}//func
}//struct
