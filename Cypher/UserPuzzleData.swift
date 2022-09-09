//
//  UserPuzzleData.swift
//  Cypher
//
//  Created by Zach Tidwell on 9/5/22.
//

import Foundation


class UserPuzzleData: ObservableObject {
@Published var startedPuzzleFileNames = [String]()
@Published var unstartedPuzzleFileNames = [String]()
@Published var completedPuzzleFileNames = [String]()
@Published var activePuzzle = Puzzle()
}//class
