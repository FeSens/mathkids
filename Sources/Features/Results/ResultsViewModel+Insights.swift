import Foundation

extension ResultsViewModel {

    /// Session performance grade
    var sessionGrade: String {
        if accuracy >= 95 { return "A+" }
        if accuracy >= 90 { return "A" }
        if accuracy >= 80 { return "B" }
        if accuracy >= 70 { return "C" }
        if accuracy >= 60 { return "D" }
        return "F"
    }

    /// Net score: correct minus wrong with penalty, floored at 0
    var netScore: Int {
        let penalty = session.difficulty.pointsPerCorrect / 2
        let score = totalCorrect * session.difficulty.pointsPerCorrect - (totalAnswered - totalCorrect) * penalty
        return max(0, score)
    }

    /// Accuracy at different positions in the problem sequence
    struct PositionalAccuracy {
        var early: Double
        var middle: Double
        var late: Double
    }

    var accuracyByPosition: PositionalAccuracy? {
        guard problemHistory.count >= 6 else { return nil }
        let third = problemHistory.count / 3
        let early = Array(problemHistory.prefix(third))
        let middle = Array(problemHistory.dropFirst(third).prefix(third))
        let late = Array(problemHistory.suffix(third))

        func acc(_ arr: [AnsweredProblem]) -> Double {
            guard !arr.isEmpty else { return 0 }
            return Double(arr.filter(\.isCorrect).count) / Double(arr.count) * 100
        }
        return PositionalAccuracy(early: acc(early), middle: acc(middle), late: acc(late))
    }

    /// Average operand size per operation
    var averageOperandSize: [Operation: Double] {
        var totals: [Operation: Double] = [:]
        var counts: [Operation: Int] = [:]
        for entry in problemHistory {
            let op = entry.problem.operation
            totals[op, default: 0] += Double(entry.problem.operand1 + entry.problem.operand2)
            counts[op, default: 0] += 2
        }
        var result: [Operation: Double] = [:]
        for (op, total) in totals {
            if let count = counts[op], count > 0 {
                result[op] = total / Double(count)
            }
        }
        return result
    }

    /// Efficiency score: combines accuracy and speed (0-100)
    var efficiencyScore: Int {
        guard totalAnswered > 0 else { return 0 }
        let accScore = accuracy
        let times = problemHistory.compactMap(\.timeTaken)
        let speedScore: Double
        if times.isEmpty {
            speedScore = 50
        } else {
            let avgTime = times.reduce(0, +) / Double(times.count)
            speedScore = max(0, min(100, 100 - (avgTime - 1.0) * 10))
        }
        return Int((accScore * 0.7 + speedScore * 0.3).rounded())
    }

    /// Formatted efficiency score text
    var efficiencyScoreText: String {
        "\(efficiencyScore)%"
    }

    /// Letter grade for efficiency score
    var efficiencyGrade: String {
        let score = efficiencyScore
        if score >= 95 { return "A+" }
        if score >= 90 { return "A" }
        if score >= 80 { return "B" }
        if score >= 70 { return "C" }
        if score >= 60 { return "D" }
        return "F"
    }

    /// Whether the player made a comeback (20+ point accuracy improvement)
    var isComeback: Bool {
        guard let improvement = accuracyImprovementOverHalves else { return false }
        return improvement >= 20
    }

    /// Encouraging text for comebacks, nil if no comeback
    var comebackText: String? {
        guard isComeback else { return nil }
        return "Amazing comeback! You turned it around!"
    }

    /// Number of problems before first correct answer (warm-up period)
    var warmUpCount: Int {
        guard let idx = problemHistory.firstIndex(where: { $0.isCorrect }) else {
            return problemHistory.count
        }
        return idx
    }

    /// Warm-up description text, nil if no warm-up needed
    var warmUpText: String? {
        let count = warmUpCount
        guard count > 0 else { return nil }
        if count == 1 { return "Warmed up after 1 problem" }
        return "Warmed up after \(count) problems"
    }

    /// Number of distinct clusters of consecutive wrong answers
    var errorClusterCount: Int {
        var clusters = 0
        var inError = false
        for entry in problemHistory {
            if !entry.isCorrect {
                if !inError { clusters += 1; inError = true }
            } else {
                inError = false
            }
        }
        return clusters
    }

    /// Longest run of consecutive wrong answers
    var longestErrorRun: Int {
        var longest = 0
        var current = 0
        for entry in problemHistory {
            if !entry.isCorrect {
                current += 1
                longest = max(longest, current)
            } else {
                current = 0
            }
        }
        return longest
    }

    /// Speed progression over the game
    enum SpeedProgression { case faster, slower, stable }

    var speedProgression: SpeedProgression {
        let times = problemHistory.compactMap(\.timeTaken)
        guard times.count >= 4 else { return .stable }
        let mid = times.count / 2
        let firstAvg = times.prefix(mid).reduce(0, +) / Double(mid)
        let secondAvg = times.suffix(times.count - mid).reduce(0, +) / Double(times.count - mid)
        let diff = firstAvg - secondAvg
        if diff > 0.5 { return .faster }
        if diff < -0.5 { return .slower }
        return .stable
    }

    var speedProgressionText: String? {
        switch speedProgression {
        case .faster: return "Getting faster!"
        case .slower: return "Slowing down"
        case .stable: return nil
        }
    }

    /// Problem count per operation
    var problemCountPerOperation: [Operation: Int] {
        var counts: [Operation: Int] = [:]
        for entry in problemHistory {
            counts[entry.problem.operation, default: 0] += 1
        }
        return counts
    }

    /// Consistency score (0-100): how uniform the player's answers were
    /// 100 = all correct or all wrong, lower = more alternation
    var consistencyScore: Int {
        guard !problemHistory.isEmpty else { return 0 }
        let results = problemHistory.map(\.isCorrect)
        let correctCount = results.filter { $0 }.count
        let ratio = Double(correctCount) / Double(results.count)
        let variance = ratio * (1.0 - ratio)
        return Int((1.0 - variance * 4.0) * 100)
    }

    /// Most improved operation (biggest accuracy gain from early to late in session)
    var mostImprovedOperation: Operation? {
        guard problemHistory.count >= 4 else { return nil }
        let mid = problemHistory.count / 2
        let firstHalf = Array(problemHistory.prefix(mid))
        let secondHalf = Array(problemHistory.suffix(problemHistory.count - mid))

        var bestImprovement: Double = 0
        var bestOp: Operation? = nil

        for op in Operation.allCases {
            let earlyProblems = firstHalf.filter { $0.problem.operation == op }
            let lateProblems = secondHalf.filter { $0.problem.operation == op }
            guard !earlyProblems.isEmpty && !lateProblems.isEmpty else { continue }
            let earlyAcc = Double(earlyProblems.filter(\.isCorrect).count) / Double(earlyProblems.count) * 100
            let lateAcc = Double(lateProblems.filter(\.isCorrect).count) / Double(lateProblems.count) * 100
            let improvement = lateAcc - earlyAcc
            if improvement > bestImprovement {
                bestImprovement = improvement
                bestOp = op
            }
        }
        return bestOp
    }
}
