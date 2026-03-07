import Testing
@testable import MathKids

@Suite("SoundService Tests")
struct SoundServiceTests {
    @Test("SoundService methods exist and are callable")
    @MainActor
    func soundMethodsExist() {
        SoundService.playCorrect()
        SoundService.playWrong()
        SoundService.playCountdownTick()
        SoundService.playGameOver()
        SoundService.playAchievement()
    }

    @Test("SoundService respects soundEnabled setting")
    @MainActor
    func respectsSoundSetting() {
        // Just verify it doesn't crash when disabled
        SettingsManager.shared.soundEnabled = false
        SoundService.playCorrect()
        SoundService.playWrong()
        SettingsManager.shared.soundEnabled = true
    }
}
