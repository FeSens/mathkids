import Foundation

/// Elo-inspired rating system for tracking skill per math operation.
/// Uses velocity (K-factor) that starts high for fast initial calibration
/// and decreases as more problems are solved.
enum EloSystem {
    static let initialRating: Double = 1000
    static let initialKFactor: Double = 64
    static let minimumKFactor: Double = 16
    static let kFactorDecayRate: Double = 0.95

    /// Calculate new rating after answering a problem.
    /// - Parameters:
    ///   - rating: Current Elo rating
    ///   - problemDifficulty: Estimated difficulty of the problem (based on operands)
    ///   - correct: Whether the answer was correct
    ///   - kFactor: Current K-factor (velocity)
    /// - Returns: New rating and updated K-factor
    static func updateRating(
        rating: Double,
        problemDifficulty: Double,
        correct: Bool,
        kFactor: Double
    ) -> (newRating: Double, newKFactor: Double) {
        let expected = expectedScore(rating: rating, opponentRating: problemDifficulty)
        let actual: Double = correct ? 1.0 : 0.0
        let newRating = max(100, rating + kFactor * (actual - expected))
        let newKFactor = max(minimumKFactor, kFactor * kFactorDecayRate)
        return (newRating, newKFactor)
    }

    /// Expected score (probability of getting it right) based on rating difference
    static func expectedScore(rating: Double, opponentRating: Double) -> Double {
        1.0 / (1.0 + pow(10.0, (opponentRating - rating) / 400.0))
    }

    /// Convert problem operands to a difficulty rating
    static func problemDifficultyRating(operand1: Int, operand2: Int, operation: Operation) -> Double {
        let maxOperand = Double(max(abs(operand1), abs(operand2)))
        let base: Double
        switch operation {
        case .add: base = 800 + maxOperand * 15
        case .subtract: base = 850 + maxOperand * 15
        case .multiply: base = 900 + maxOperand * 25
        case .divide: base = 880 + maxOperand * 20
        }
        return base
    }

    /// Determine operand range based on Elo rating for an operation
    static func operandRange(forRating rating: Double, operation: Operation) -> ClosedRange<Int> {
        let normalized = max(0, (rating - 800) / 600) // 0.0 at 800, 1.0 at 1400
        let minRange: Int
        let maxRange: Int

        switch operation {
        case .add, .subtract:
            minRange = 1
            maxRange = max(5, Int(5 + normalized * 95)) // 5 to 100
        case .multiply:
            minRange = 1
            maxRange = max(3, min(Int(3 + normalized * 15), 20)) // 3 to 18
        case .divide:
            minRange = 1
            maxRange = max(2, min(Int(2 + normalized * 14), 16)) // 2 to 16
        }

        return minRange...maxRange
    }

    /// Skill level description based on rating
    static func skillLevel(forRating rating: Double) -> String {
        switch rating {
        case ..<700: return "Beginner"
        case 700..<900: return "Learning"
        case 900..<1100: return "Intermediate"
        case 1100..<1300: return "Advanced"
        case 1300..<1500: return "Expert"
        default: return "Master"
        }
    }
}
