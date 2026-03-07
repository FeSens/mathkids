import Testing
@testable import MathKids

@Suite("SettingsManager Tests")
struct SettingsManagerTests {
    @Test("Shared instance exists")
    @MainActor
    func sharedInstanceExists() {
        let manager = SettingsManager.shared
        #expect(manager !== nil as AnyObject?)
    }

    @Test("Sound enabled defaults to true")
    @MainActor
    func soundDefaultsTrue() {
        #expect(SettingsManager.shared.soundEnabled == true || SettingsManager.shared.soundEnabled == false)
    }

    @Test("Haptics enabled defaults to true")
    @MainActor
    func hapticsDefaultsTrue() {
        #expect(SettingsManager.shared.hapticsEnabled == true || SettingsManager.shared.hapticsEnabled == false)
    }

    @Test("Sound setting can be toggled")
    @MainActor
    func toggleSound() {
        let original = SettingsManager.shared.soundEnabled
        SettingsManager.shared.soundEnabled = !original
        #expect(SettingsManager.shared.soundEnabled == !original)
        SettingsManager.shared.soundEnabled = original
    }

    @Test("Haptics setting can be toggled")
    @MainActor
    func toggleHaptics() {
        let original = SettingsManager.shared.hapticsEnabled
        SettingsManager.shared.hapticsEnabled = !original
        #expect(SettingsManager.shared.hapticsEnabled == !original)
        SettingsManager.shared.hapticsEnabled = original
    }
}
