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
}//struct
