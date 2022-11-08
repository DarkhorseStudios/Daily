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

func savePuzzleToDocumentDirectory(for puzzle: Puzzle, withFileName: String) {

let url = getDocumentsDirectoryURL().appendingPathComponent(withFileName)

do {
try JSONEncoder().encode(puzzle).write(to: url)
} catch {
print(error.localizedDescription)
fatalError("Couldn't save file to DocumentDirectory")
}//catch block
}//savePuzzleToDocumentDirectory

func loadPuzzleFromDocumentDirectory(fromFileWithName: String) -> Puzzle {

guard let url = try? getDocumentsDirectoryURL().appendingPathComponent(fromFileWithName) else {
print("Couldn't load url from directory for \(fromFileWithName)")
fatalError("Couldn't load url from directory")
}//guard

print("url found for \(fromFileWithName)")
guard let data = try? Data(contentsOf: url) else {
fatalError("url could not be converted to data.")
}//guard

guard let puzzle = try? JSONDecoder().decode(Puzzle.self, from: data) else {
print("Couldn't vonvert data from \(fromFileWithName) into a Puzzle")
fatalError("Couldn't decode from data")
}//guard

return puzzle
}//loadPuzzle

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
//** start here
// if the url isn't found, we have to create one, because that means the user hasn't been initialized
//We use the catch block to make one if-needed.
guard let url = try? getDocumentsDirectoryURL().appendingPathComponent("User") else {
//do { print("")
//} catch {
print("Couldn't find URL for User in DocumentDirectory, and failed to make one.")
fatalError("Couldn't find url for user and failed to make one")
//}//catch
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
