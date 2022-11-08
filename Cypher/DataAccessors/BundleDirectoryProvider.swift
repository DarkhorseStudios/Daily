import Foundation

struct BundleDirectoryProvider {
/* I used this tutorial:
https://www.hackingwithswift.com/example-code/system/how-to-read-the-contents-of-a-directory-using-filemanager
*/
let defaultFileManager = FileManager.default
//this path, which is an optional string, is force-unwrapped by the exclamation mark at the end of this initializer
let bundlePath = Bundle.main.resourcePath!
func getAllPuzzlePackURLs() -> [URL] {
var allPuzzlePackFolderURLs = [URL]()
do {
let items = try defaultFileManager.contentsOfDirectory(atPath: bundlePath)
for item in items {
print("BundleDirectoryProvider found \(item)")
}//loop
} catch {
print("Entering catch block for Bundle Directory Provider")
}//catch
print("failed")
return allPuzzlePackFolderURLs
}//func

/*uses this tutorial
https://www.hackingwithswift.com/example-code/system/how-to-read-the-contents-of-a-directory-using-filemanager
*/

func getAllPuzzlePackFolderNames() {

let path = Bundle.main.resourcePath!
do {
    let items = try defaultFileManager.contentsOfDirectory(atPath: path)

    for item in items {
        print("Found \(item)")
    }
} catch {
    // failed to read directory – bad permissions, perhaps?
}
}//func
func allPuzzleFileNames() -> [String] {
//return array
var allFileNames = [String]()
let path = Bundle.main.resourcePath!
do {
    let items = try defaultFileManager.contentsOfDirectory(atPath: path)

    for item in items {
    if item.hasSuffix(".json") {
        allFileNames.append(item)
        }//conditional
    }//loop
} catch {
    // failed to read directory – bad permissions, perhaps?
}//catch

return allFileNames
}//func

/*used to access the user's document directory for our app. Used this ytutorial:
https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory
*/
func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}//get documetnsDirectory

}//struct
