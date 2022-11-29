/* Using tutorial:
https://www.zerotoappstore.com/how-to-add-background-music-in-swift.html
*/
import SwiftUI
import AVFoundation

struct SoundManager {

@ObservedObject var allSettings: AllSettings
//have to have this as a stored property, because it will stop playing if it's defined inside a function
var audioPlayer = AVAudioPlayer()
let hintSolvedFileName = "Bell_Counter_A.wav"
let puzzleCompleteFileName = "Task_Complete_01.wav"

//These functions have to be marked as mutating because of the AVAudioPlayer
mutating func playHintSolved() {
//File: Bell_Counter_A.wav, from freeSounds.org
//AttributionLicense: "Bell, Counter, A.wav" by InspectorJ (www.jshaw.co.uk) of Freesound.org"
// link on freeSoundshttps://freesound.org/people/InspectorJ/sounds/415510/#

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
//}//conditional checking if soundEffects are enabled
}//playHintSolved

mutating func playPuzzleCompleted() {
//File was from Bundle, originally called:
//Task_Complete_01.wav

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



}
func startBackgroundMusic() {

}//startBackgroundMusic

func getSoundEffectsEnabledFromDefaults() -> Bool {

//return value
var soundEffectsEnabled = false
if let value = UserDefaults.standard.object(forKey: "soundEffectsEnabled") as? Bool ?? Bool(false) {
soundEffectsEnabled = value
}//unwrap

return soundEffectsEnabled
}//getSoundEffectsEngabled
func getSoundEffectVolume() -> Double {

//return value
var volume = 0.0

if let value = UserDefaults.standard.data(forKey: "soundEffectVolume") {
volume = value}

return volume
}//getSoundEffectsVoulume

func getMusicEnabled() -> Bool {
//return value
var musicEnabled = false


if let value = UserDefaults.standard.data(forKey: "musicEnabled") {
musicEnabled = value
}//unwrap

return musicEnabled
}//getMusicEnabled

func getMusicVolume() -> Double {

//return value
var volume = 0.0

if let value = UserDefaults.standard.data(forKey: "musicVolume") {
volume = valueq
}//unwrap

return volume
}//getMusicVolume
}//class
