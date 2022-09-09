//  Puzzle.swift
//This struct is the structure for all jumbled puzzles in the style of Seven Little Words
//  Cypher
//
//  Created by Zach Tidwell on 8/25/22.
//

import Foundation

struct Puzzle: Codable {
var title = "title not yet set by this puzzle object"
var hintAnswerPairs = [HintAnswerPair]()
var started = false
//Something to track the current spelling.

//This method parses json data into the puzzle
//Maybe I'll pass the file url in by iterating overnall of the possible puzzles.

func fill(fromFile: String) -> Puzzle{
let newPuzzle = Bundle.main.decodePuzzle(fromFile: "TestPuzzle")
return newPuzzle
}//func

//enums
enum FillError: Error {
case general
}//FillError
}//struct
