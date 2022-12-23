/* Using tutorial:
https://www.zerotoappstore.com/how-to-add-background-music-in-swift.html
*/
import SwiftUI
import AVFoundation

struct SoundManager {

//have to have this as a stored property, because it will stop playing if it's defined inside a function
var audioPlayer = AVAudioPlayer()
//Used to check if sounds are enabled
let defaultsManager = UserDefaultsManager()
let hintSolvedFileName = "Bell_Counter_A.wav"
let puzzleCompleteFileName = "Task_Complete.wav"

//These functions have to be marked as mutating because of the AVAudioPlayer
mutating func playHintSolved() {
//File: Bell_Counter_A.wav, from freeSounds.org
//AttributionLicense: "Bell, Counter, A.wav" by InspectorJ (www.jshaw.co.uk) of Freesound.org"
// link on freeSoundshttps://freesound.org/people/InspectorJ/sounds/415510/#
if defaultsManager.getSoundEffectsEnabled() {
//force unwrapped path
let path = Bundle.main.path(forResource: hintSolvedFileName, ofType: nil)!
let url = URL(fileURLWithPath: path)

do {
audioPlayer = try AVAudioPlayer(contentsOf: url)
audioPlayer.play()
} catch {
print("SoundManager.playHintSolved couldn't play")
fatalError("Coudln't play file")
}//catch
}//conditional checking if soundEffects are enabled
}//playHintSolved

mutating func playPuzzleCompleted() {
//File was from Bundle, originally called:
//Task_Complete_01.wav
if defaultsManager.getSoundEffectsEnabled() {
//force unwrap path
let path = Bundle.main.path(forResource: puzzleCompleteFileName, ofType: nil)!
let url = URL(fileURLWithPath: path)

do {
audioPlayer = try AVAudioPlayer(contentsOf: url)
audioPlayer.play()
} catch {
print("SoundManager.playPuzzleComplete couldn't play")
fatalError("Coudln't play file")
}//catch
}//conditional checking if sound is enabled
}//play puzzle solved
func startBackgroundMusic() {

if defaultsManager.getMusicEnabled() {
}//conditional checking if music enabled
}//startBackgroundMusic

func getSoundEffectsEnabledFromDefaults() -> Bool {

//return value
var soundEffectsEnabled = false
if let value = try? UserDefaults.standard.object(forKey: "soundEffectsEnabled") as? Bool ?? false{
soundEffectsEnabled = value
}//unwrap

return soundEffectsEnabled
}//getSoundEffectsEngabled
func getSoundEffectVolume() -> Double {
 return UserDefaults.standard.object(forKey: "soundEffectVolume") as? Double ?? 49
}//getSoundEffectsVoulume

func getMusicEnabled() -> Bool {
//return value
var musicEnabled = false
return UserDefaults.standard.object(forKey: "musicEnabled") as? Bool ?? false
}//getMusicEnabled

func getMusicVolume() -> Double {

//return value
var volume = 0.0

if let value = UserDefaults.standard.object(forKey: "musicVolume") as?  Double{
volume = value
}//unwrap

return volume
}//getMusicVolume
}//class
