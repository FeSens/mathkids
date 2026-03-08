import Foundation

struct AnsweredProblem: Identifiable, Sendable {
    let id = UUID()
    let problem: MathProblem
    let userAnswer: Int
    var timeTaken: Double?
    var isCorrect: Bool { problem.isCorrect(answer: userAnswer) }

    var timeLabel: String? {
        guard let time = timeTaken, time > 0 else { return nil }
        return String(format: "%.1fs", time)
    }
}
