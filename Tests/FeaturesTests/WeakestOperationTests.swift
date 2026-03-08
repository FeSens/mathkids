import Testing
@testable import MathKids

@Suite("Weakest Operation Widget Tests")
struct WeakestOperationTests {

    // MARK: - improve-002: Weakest operation on home screen

    @Test("HomeViewModel exposes weakest Elo operation")
    @MainActor
    func weakestEloOperation() {
        let stats = PlayerStats()
        stats.eloAdd = 1200
        stats.eloSubtract = 1100
        stats.eloMultiply = 800
        stats.eloDivide = 950
        let weakest = stats.weakestEloOperation
        #expect(weakest == .multiply)
    }

    @Test("Weakest Elo operation nil when all ratings equal")
    @MainActor
    func weakestEloOperationAllEqual() {
        let stats = PlayerStats()
        // All default to 1000
        let weakest = stats.weakestEloOperation
        #expect(weakest == nil)
    }

    @Test("Weakest Elo returns operation with lowest rating")
    @MainActor
    func weakestEloReturnsLowest() {
        let stats = PlayerStats()
        stats.eloAdd = 1000
        stats.eloSubtract = 1000
        stats.eloMultiply = 1000
        stats.eloDivide = 750
        #expect(stats.weakestEloOperation == .divide)
    }
}
