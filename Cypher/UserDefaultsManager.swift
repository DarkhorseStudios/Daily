import Foundation

//Any time we use UserDefaults, we get the keys from here so they are always the same
struct UserDefaultsManager {

let standardDefaults = UserDefaults.standard
//UserDefaults initializes preferred default values for these keys in the App file. using register()
let soundEffectsEnabledKey = "soundEffectsEnabled"
let musicEnabledKey = "musicEnabled"

func getSoundEffectsEnabled() -> Bool {
return standardDefaults.objectIsForced(forKey: soundEffectsEnabledKey)
}//getSoundEffectsEnabled
func getMusicEnabled() -> Bool {
return standardDefaults.objectIsForced(forKey: musicEnabledKey)
}//getMusicEnabled

//saving functions

func saveSoundEffectsEnabled(to newValue: Bool) {
standardDefaults.set(newValue, forKey: soundEffectsEnabledKey)
}//saveSoundEffects
func saveMusicEnabled(to newValue: Bool) {
standardDefaults.set(newValue, forKey: musicEnabledKey)
}//saveMusicEnabled

}//struct
