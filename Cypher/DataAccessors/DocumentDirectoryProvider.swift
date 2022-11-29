import Foundation

/*HWS related tutorial:
https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory
*/
class DocumentDirectoryProvider {

func getDocumentsDirectoryURL() -> URL {

    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}//getDocumentdirefctory

func savePuzzleToDocumentDirectory(for puzzle: Puzzle) {
guard let fileName = try puzzle.fileName else {
print("When saving the puzzle \(puzzle.title) to the DocumentDirectory, it had no file name.")
fatalError("Couldn't find fileName for puzzle")
}//guard

let url = getDocumentsDirectoryURL().appendingPathComponent(fileName)

do {
try JSONEncoder().encode(puzzle).write(to: url)
} catch {
print(error.localizedDescription)
fatalError("Couldn't save file to DocumentDirectory")
}//catch block
}//savePuzzleToDocumentDirectory

//Used to load puzzles from the document directory because they may not have been saved there from the Bundle yet
//Attempts to load a puzzle from the DocumentsDirectory. If the contents of the Data object can't make a puzzle, we just return a puzzle from the Bundle.
func tryLoadingPuzzleFromDocumentDirectory(using fileName: String) -> Puzzle {

//returned value. Initially set to TestPuzzle so I know there's an error if I see it.
var puzzleFromDirectory = Puzzle(fromFileWithName: "TestPuzzle.json")

guard let url = try? getDocumentsDirectoryURL().appendingPathComponent(fileName) else {
print("Couldn't load url from directory for \(fileName)")
fatalError("Couldn't load url from directory from \(fileName)")
}//guard

//This first section happens if the file has been saved in the document directory. If not, we bring in a puzzle from the bundle, save it to the document directory, then load it.
if let data = try? Data(contentsOf: url) {
if let puzzle = try? JSONDecoder().decode(Puzzle.self, from: data) {
puzzleFromDirectory = puzzle
}//unwrap for puzzle from data

} else { //if data couldn't be loaded because the file isn't saved in the DocumentDirectory yet

let initializedPuzzle = initializePuzzleFromBundleAndSaveToDocumentDirectory(using: fileName)

//after initializing the puzzle from the bndle and saving it, we should be able to load it from the document directory
guard let urlAfterInitializingFromBundle = try? getDocumentsDirectoryURL().appendingPathComponent(fileName) else {
print("DocumentDirectoryProvider.tryLoadingPuzzleFromDocumentDirectoryProvider() couldn't load urlAfterInitializingFromBundle for \(fileName)")
fatalError("Couldn't load urlAfterInitializingFromBundle")
}//guard for secondaryURL

guard let dataAfterInitializingFromBundle = try? Data(contentsOf: urlAfterInitializingFromBundle) else {
print(".tryLoadingPuzzleFromDocumentDirectory failed its second try to laod the puzzle, after initializng and saving it from the bundle and trying to load again.")
fatalError("Faild to load uralAfterInitializingFromBundle")
}// guard for dataAfterInitializingFromBundle

if let puzzleInitializedFromBundle = try? JSONDecoder().decode(Puzzle.self, from: dataAfterInitializingFromBundle) {
puzzleFromDirectory = puzzleInitializedFromBundle
}//conditional unwrap
}//main conditional seeing if we can load the puzzle from the DocumentDirectory
if let puzzleFileName = try! puzzleFromDirectory.fileName {
print("from puzzle: \(puzzleFileName). Parameter: \(fileName)")
}//forced unwrap
return puzzleFromDirectory
}//tryLoadingPuzzleFromDocumentDirectory

//used in loadPuzzle() when we try to load a puzzle from the document directory that hasn't been saved there yet.
//returns the puzzle that it initialized so we can use its fileName variable to load it from the DocumentDirectory
func initializePuzzleFromBundleAndSaveToDocumentDirectory(using fileName: String) -> Puzzle {
var secondaryPuzzle: Puzzle = Bundle.main.decode(fromFileName: fileName)
//Because class Puzzle has a required intializer for decoder, we can't pass the fileName to the new object, and have to set it after initialization to overwrite the default value
secondaryPuzzle.setFileName(fileName)
savePuzzleToDocumentDirectory(for: secondaryPuzzle)

return secondaryPuzzle
}//initializePuzzleFromBundleAndSaveToDirectory.

func saveUser(user: User) {
let url = getDocumentsDirectoryURL().appendingPathComponent("User")

do {
try JSONEncoder().encode(user).write(to: url)
} catch {
print(error.localizedDescription)
fatalError("Failed to save user to DocumentDirectory")
}//catch
}//saveUserData

func loadUser() -> User {

// if the url isn't found, we have to create one, because that means the user hasn't been initialized
//We use the catch block to make one if-needed.
guard let url = try? getDocumentsDirectoryURL().appendingPathComponent("User") else {
do {
print("No directory for User was found. Making a new one instead")
return User()
} catch {
print("Couldn't find URL for User in DocumentDirectory, and failed to make one.")
fatalError("Couldn't find url for user and failed to make one")
}//catch
}// guard


guard let data = try? Data(contentsOf: url) else {
print("Couldn't convert url for User into Data")
fatalError("url could not be converted to data.")
}//guard

guard let user = try? JSONDecoder().decode(User.self, from: data) else {
print("Couldn't load User from DocumentDirectory")
fatalError("Failed to load user")
}//guard

return user
}//loadUser
}//class
