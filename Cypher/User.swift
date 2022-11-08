import Foundation

//stores data for the user's completed puzzles, stats, and usage data
class User: Codable {

let userID: UUID
private(set) var userHasBeenCreatedAndStoredOnDevice: Bool

//stats

private(set) var totalPuzzlesCompleted = 0

init() {

let userDefaults = UserDefaults.standard
self.userHasBeenCreatedAndStoredOnDevice = userDefaults.bool(forKey: "userStoredInDefaults")

if userHasBeenCreatedAndStoredOnDevice == false {
self.userID = UUID()
userDefaults.set(userID, forKey: "userID")
} else {
if let storedUserID = userDefaults.object(forKey: "userStoredInDefaults") as? UUID {
self.userID = storedUserID
} else {
print("class User failed to read the stored userID from UserDefaults in its initializer.")
fatalError("Read above")
}//nested conditional unwrap
}//conditional
totalPuzzlesCompleted = userDefaults.integer(forKey: "totalPuzzlesCompleted")
userHasBeenCreatedAndStoredOnDevice = true
userDefaults.set(userHasBeenCreatedAndStoredOnDevice, forKey: "userStoredInDefaults")
}//init

func incrementTotalPuzzlesCompleted() {
totalPuzzlesCompleted += 1
saveTotalPuzzlesCompletedToUserDefaults()
}//incrementTotalPuzzlesCompleted

func saveTotalPuzzlesCompletedToUserDefaults() {
let userDefaults = UserDefaults.standard
userDefaults.set(totalPuzzlesCompleted, forKey: "totalPuzzlesCompleted")
}//saveTotalPuzzlesCompleted
}//class
