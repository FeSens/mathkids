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

    static func playGameOver(accuracy: Double) {
        guard SettingsManager.shared.soundEnabled else { return }
        if accuracy >= 80 {
            AudioServicesPlaySystemSound(1026) // triumphant ascending
        } else if accuracy >= 50 {
            AudioServicesPlaySystemSound(1025) // encouraging positive
        } else {
            AudioServicesPlaySystemSound(1114) // standard descending
        }
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
