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
//We iterate over the array of all puzzleFile names to find ones that belong to the current series, then add them to this array for separating them into packs and setting edition names
var arrayOfPuzzleFileNamesInThisPack = [String]()

for puzzleFileName in allPuzzleFileNames {

if puzzleFileName.hasPrefix(individualDataSet.fileNameWithoutNumbers) {

arrayOfPuzzleFileNamesInThisPack.append(puzzleFileName)

guard let indexOfPuzzlePackFile = allPuzzleFileNames.firstIndex(of: puzzleFileName) else {
print("This shouldn't be possible, but AllPuzzlePacks init() faild to find the index of \(puzzleFileName) in the array of allPuzzleFileNames")
fatalError("Couldn't find index of that file name in all puzzle files. This shouldn't be possible")
}//guard
allPuzzleFileNames.remove(at: indexOfPuzzlePackFile)
}//conditional

indexInAllPuzzleFileNames += 1
}//loop iterating over allPuzzleFileNames

separateFilesAndFillPacks(puzzlePackData: individualDataSet, allPuzzleFileNamesInPack: arrayOfPuzzleFileNamesInThisPack)
}//nested loop iterating over differentPuzzlePackData from current directory
}//loop iterating over directoryFileNames

applyEditionsToPuzzlePackTitles()
}// initialize data

//Is passed the data for all puzzles in a single series of puzzles in initializeData()
func separateFilesAndFillPacks(puzzlePackData: PuzzlePackData, allPuzzleFileNamesInPack: [String]) {

var sortedFileNames = [String]()
//We use 0 instead of 1 so that we don't get an untraceable crash if the array of file names is empty.
for i in 0...allPuzzleFileNamesInPack.count {

for fileName in allPuzzleFileNamesInPack {

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

var puzzlesInPack = [Puzzle]()
for j in 0...9 {

//We need this conditional because the index pulled from sortedFileNames will be the same the first times through the loop, if fullPuzzles in this set = 0 or 1
let documentDirectoryProvider = DocumentDirectoryProvider()
if fullPuzzlesInThisSet == 0 {
//puzzlesInPack.append(Puzzle(fromFileWithName: sortedFileNames[j]))
puzzlesInPack.append(documentDirectoryProvider.tryLoadingPuzzleFromDocumentDirectory(using: sortedFileNames[j]))
} else {
//puzzlesInPack.append(Puzzle(fromFileWithName: sortedFileNames[j + (i * 10)]))
puzzlesInPack.append(documentDirectoryProvider.tryLoadingPuzzleFromDocumentDirectory(using: sortedFileNames[j + (i * 10)]))
}//conditional
}//nested loop

 puzzlePacks.append(PuzzlePack(puzzlePackData: puzzlePackData, puzzles: puzzlesInPack))
fullPuzzlesInThisSet += 1
}//loop
}//separateFilesAndFillPacks

//called in initializeData() to iterate over all separated puzzle packs and append their titles to include an edition name
func applyEditionsToPuzzlePackTitles() {

var edition = ""
var namesOfAllPacks = [String]()

for pack in puzzlePacks {

namesOfAllPacks.append(pack.title)
}//loop

//We use this set because it can only contain one of each name. So we can find repeats as we loop through it
let setOfUniquePuzzlePackNames = Set(namesOfAllPacks)

for seriesTitle in setOfUniquePuzzlePackNames {
var puzzlePacksInThisSeries = [PuzzlePack]()

for puzzlePack in puzzlePacks {
if seriesTitle == puzzlePack.title {
puzzlePacksInThisSeries.append(puzzlePack)
}//conditional
}//nested loop iterating over namesOfAllPacks

//Now that we have the number of packs in this series, we set their editions before moving on

for i in 0..<puzzlePacksInThisSeries.count {

if i == 0 {
edition = "First"
} else if i == 1 {
edition = "Second"
} else if i == 2 {
edition = "Third"
} else if i == 3 {
edition = "Fourth"
}else if i == 4 {
edition = "Fifth"
} else if i == 5 {
edition = "Sixth"
}//conditional

puzzlePacksInThisSeries[i].setTitle(puzzlePacksInThisSeries[i].title + ": \(edition) Edition")
}//loop iterating over the count of puzzles in this pack
}//loop
}//func
}//class
