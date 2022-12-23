import Foundation

//This class contains all initialized data for Puzzle Packs that we need for populating the IndividualPuzzlePackViews in PuzzlePacksView
class AllPuzzlePacks: ObservableObject {

@Published private(set) var puzzlePacks = [PuzzlePack]()
//We hard-code the base of directory file names for each puzzle type. In init, we add the rest of the name to cut-down on the chance of errors
//This is accessed by SpellingTest() to make sure we don't try to convert a directory file into a puzzle
private(set) var puzzlePackDirectoryNames = ["Standard"]

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
puzzlesInPack.append(documentDirectoryProvider.tryLoadingPuzzleFromDocumentDirectory(using: sortedFileNames[j]))
} else {
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

func getPuzzlePackDirectoryFileNames() -> [String] {
return puzzlePackDirectoryNames
}//getDirectoryFileNames

//called by NextPuzzlePromptView to set GameData's puzzle to the next incomplete puzzle.
//If it returns nil, it means that all puzzles have been finished, and it will trigger an alert that tells the player that the game defaults to randomized puzzles when they've been completed.
func getNextUnfinishedPuzzle(after newlyFinishedPuzzle: Puzzle) -> Puzzle? {

//return value
var optionalPuzzle: Puzzle?
for indexOfPuzzlePack in 0..<puzzlePacks.count {

let puzzlesInCurrentPack = puzzlePacks[indexOfPuzzlePack].puzzles

//now, we loop over each puzzle to try and find the index of the puzzle that was just completed
for puzzle in puzzlesInCurrentPack {

if puzzle == newlyFinishedPuzzle {

//We've found the puzzle, so we have to use its index to find the next unfinished puzzle
guard let indexOfNewlyCompletedPuzzle = puzzlesInCurrentPack.firstIndex(of: newlyFinishedPuzzle) else {
print("This shouldn't be possible, but allPuzzlePacks.getNextUnfinishedPuzzle() was unable to find the index for the newlyCompletedPuzzle")
fatalError("See console for description")
}//guard

optionalPuzzle = getNextUnfinishedPuzzleInSamePack(indexOfPack: indexOfPuzzlePack, indexOfPuzzleInPack: indexOfNewlyCompletedPuzzle)
}//conditional checking if puzzles match

//If it equals nil, that means there weren't any unfinished puzzles left in that pack.
if optionalPuzzle == nil {
optionalPuzzle = getNextPuzzleFromDifferentPack(indexOfCurrentPack: indexOfPuzzlePack)
}//conditional checking if the puzzle that was just looped over matches the newlyCompletedPuzzle
}//nested loop
}//loop

return optionalPuzzle
}//getNextUnfinishedPuzzle

//These next two functions are called  in getNextPuzzle. They are contained in their own functions to lessen the signature of getNextPuzzle()
//If this returns nil, it means all of the puzzles in the pack, after the one that was just finished,  were finished
private func getNextUnfinishedPuzzleInSamePack(indexOfPack: Int, indexOfPuzzleInPack: Int) -> Puzzle? {

let puzzlePack = puzzlePacks[indexOfPack]
let numberOfPuzzlesInPack = puzzlePack.puzzles.count
var optionalPuzzle: Puzzle?

//This initial conditional is just for safety so we don't get an out-of-bounds error
if indexOfPuzzleInPack < numberOfPuzzlesInPack - 1 {

for i in (indexOfPuzzleInPack + 1)...(numberOfPuzzlesInPack - 1) {

if !puzzlePack.puzzles[indexOfPuzzleInPack + i].finished {

optionalPuzzle = puzzlePack.puzzles[indexOfPuzzleInPack + i]

}//nested conditional
}//loop
}//conditional

return optionalPuzzle
}//GetUnfinishedPuzzleInPack

//Searches through each pack after whatever pack a puzzle was just completed in. If it gets to the end of the puzzles and they're all finished, it'll start back over at the beginning.
//If this comes-back as nil, we can prompt the user to buy more puzzles, or we can let them replay some of the randomly-generated puzzles
private func getNextPuzzleFromDifferentPack(indexOfCurrentPack: Int) -> Puzzle? {
//return value
var optionalPuzzle: Puzzle?
//We use the count of the puzzlePacks stored property as a limit for the loop to make sure we only look through each pack once
//this boolean state tracks whether it's time to loop from zero up to the index passed-as a parameter
var timeToUseInputAsUpperBound = false
//for i in indexOfCurrentPack..<puzzlePacks.count {
return optionalPuzzle
}//getUnfinishedPuzzleFromNextPack

//These to functions are used in the above function to find the next puzzle pack.
//This one is used first. We only use the userCurrentAsUppderBound() if none of the puzzles after the one that was just finished are incomplete.
private func useCurrentAsLowerBound() -> Puzzle? {

//return value
var optionalPuzzle: Puzzle?

return optionalPuzzle
}//useCurrentAsLowerBound

private func useCurrentAsUpperBound() -> Puzzle? {

//return value
var optionalPuzzle: Puzzle?

return optionalPuzzle
}//useCurrentAsUpperBound
}//class
