import Foundation

extension GameSession {
    var scoreWithBonusText: String {
        "\(score) + \(totalBonusPoints) bonus"
    }

    var performanceSummary: String {
        "\(totalCorrect)/\(totalAnswered) correct | \(score) pts"
    }
}
