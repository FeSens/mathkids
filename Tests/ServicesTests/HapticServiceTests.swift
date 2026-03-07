import Testing
@testable import MathKids

@Suite("HapticService Tests")
struct HapticServiceTests {
    @Test("HapticService methods exist and are callable")
    @MainActor
    func hapticMethodsExist() {
        // HapticService methods are fire-and-forget UIKit calls
        // We verify they compile and can be called without crashing
        HapticService.buttonTap()
        HapticService.correctAnswer()
        HapticService.wrongAnswer()
        HapticService.streakMilestone()
    }
}
