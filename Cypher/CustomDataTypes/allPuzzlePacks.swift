import Foundation

//This class contains all initialized data for Puzzle Packs that we need for populating the IndividualPuzzlePackViews in PuzzlePacksView
class AllPuzzlePacks: ObservableObject {

@Published private(set) var puzzlePacks = [PuzzlePack]()
//We hard-code the base of directory file names for each puzzle type. In init, we add the rest of the name to cut-down on the chance of errors
private var puzzlePackDirectoryNames = ["Standard"]

//methods

//We use this instead of a normal init() because we have to initialize puzzles before creating PuzzlePacks
//called in onAppear() of ContentView
func initializeData() {
var allPuzzleFileNames = BundleDirectoryProvider().allPuzzleFileNames()
for directoryFileName in puzzlePackDirectoryNames {
let arrayOfPuzzlePackDataObjects: [PuzzlePackData]  = Bundle.main.decode(fromFileName: directoryFileName + "PuzzlePacksDirectory.json")

for individualDataSet in arrayOfPuzzlePackDataObjects {
var indexInAllPuzzleFileNames = 0
//We firsst find all of the puzzles from the current directory, and add them to this array. Then we iterate over its data, organizing them by the number in their file name so that they are organized in the IndividualPuzzlePacksView
var puzzleFileNamesFromCurrentDirectory = [String]()
var tempArrayOfPuzzleFileNamesInThisPack = [String]()

for puzzleFileName in allPuzzleFileNames {

if puzzleFileName.hasPrefix(individualDataSet.fileNameWithoutNumbers) {
//temp code
tempArrayOfPuzzleFileNamesInThisPack.append(puzzleFileName)
//end temp code
puzzleFileNamesFromCurrentDirectory.append(puzzleFileName)

guard let indexOfPuzzlePackFile = allPuzzleFileNames.firstIndex(of: puzzleFileName) else {
print("This shouldn't be possible, but AllPuzzlePacks init() faild to find the index of \(puzzleFileName) in the array of allPuzzleFileNames")
fatalError("Couldn't find index of that file name in all puzzle files. This shouldn't be possible")
}//guard
allPuzzleFileNames.remove(at: indexOfPuzzlePackFile)
}//conditional

indexInAllPuzzleFileNames += 1
}//loop iterating over allPuzzleFileNames

separateFilesAndFillPacks(puzzlePackData: individualDataSet, allPuzzleFileNamesInPack: tempArrayOfPuzzleFileNamesInThisPack)
}//nested loop iterating over differentPuzzlePackData from current directory
}//loop iterating over directoryFileNames

applyEditionToPuzzlePackTitles()
}// initialize data

func separateFilesAndFillPacks(puzzlePackData: PuzzlePackData, allPuzzleFileNamesInPack: [String]) {

var sortedFileNames = [String]()
//We use 0 instead of 1 so that we don't get an untraceable crash if the array of file names is empty.
for i in 0...allPuzzleFileNamesInPack.count {

for var fileName in allPuzzleFileNamesInPack {

if fileName == puzzlePackData.fileNameWithoutNumbers + "\(i).json" {
sortedFileNames.append(fileName)
}//conditional
}// nested loop
}//loop
//represents how many packs from this series have been run through the loop already so we label their editions correctly
var fullPuzzlesInThisSet = 0
//We do this math to set a limit of ten puzzles per pack
//May cause an error because the upper bound of the range may return a float in the event that a puzzle pack has a total number of puzzles not divisible by 10
for i in 0..<(sortedFileNames.count / 10) {
print(" i loop running iwth i as \(i)")
print(sortedFileNames)
var puzzlesInPack = [Puzzle]()
for j in 0...9 {

//We need this conditional because the index pulled from sortedFileNames will be the same the first times through the loop, if fullPuzzles in this set = 0 or 1
if fullPuzzlesInThisSet == 0 {
puzzlesInPack.append(Puzzle(fromFileWithName: sortedFileNames[j]))
} else {
puzzlesInPack.append(Puzzle(fromFileWithName: sortedFileNames[j + (i * 10)]))
}//conditional
}//nested loop

 puzzlePacks.append(PuzzlePack(puzzlePackData: puzzlePackData, puzzles: puzzlesInPack))
fullPuzzlesInThisSet += 1
}//loop
}//separateFilesAndFillPacks

///Called in the above method to label PuzzlePackTitles appropriately, including the dition
//After we retrieve the names from the puzzle pack directory, we send them here so they can be compared against puzzle packs while we  set their edition names

//used in initializeData() as we loop over the puzzle packs. we pass puzzle pack data and files into this function one-at-a-time, and it splits everything into packs, then adds them to this class' puzzlePacks property
func applyEditionToPuzzlePackTitles() {
var edition = ""

for index in 0..<puzzlePacks.count {
if index == 0 {
edition = "First Edition"
} else if index == 1 {
edition = "Second Edition"
} else if index == 2 {
edition = "Third Edition"
}else if index == 3 {
edition = "Fourth Edition"
} else if index == 4 {
edition = "Fifth Edition"
} else {
edition = "**Visit ProcessRawData() in AllPuzzlePacks. Currently only accomodates for e editions" + edition
}//conditional

puzzlePacks[index].setTitle(puzzlePacks[index].title + ": \(edition)")
}//loop iterating over each puzzle pack
}//getPuzzlePackTitleWithEdition
}//class
