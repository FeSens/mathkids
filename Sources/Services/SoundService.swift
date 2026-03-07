import AudioToolbox

@MainActor
struct SoundService {
    static func playCorrect() {
        guard SettingsManager.shared.soundEnabled else { return }
        AudioServicesPlaySystemSound(1025) // key press positive
    }

    static func playWrong() {
        guard SettingsManager.shared.soundEnabled else { return }
        AudioServicesPlaySystemSound(1073) // negative beep
    }

    static func playCountdownTick() {
        guard SettingsManager.shared.soundEnabled else { return }
        AudioServicesPlaySystemSound(1103) // tock
    }

    static func playGameOver() {
        guard SettingsManager.shared.soundEnabled else { return }
        AudioServicesPlaySystemSound(1114) // descending tone
    }

    static func playAchievement() {
        guard SettingsManager.shared.soundEnabled else { return }
        AudioServicesPlaySystemSound(1026) // ascending positive
    }

    static func playCelebration(intensity: GameViewModel.CelebrationIntensity) {
        guard SettingsManager.shared.soundEnabled else { return }
        switch intensity {
        case .normal:
            AudioServicesPlaySystemSound(1025) // standard correct
        case .big:
            AudioServicesPlaySystemSound(1026) // ascending positive
        case .huge:
            AudioServicesPlaySystemSound(1026) // ascending positive
            AudioServicesPlaySystemSound(1025) // layered effect
        }
    }
}
