import Foundation

extension ResultsViewModel {

    /// Average response time per operation from problem history
    var averageTimePerOperation: [Operation: Double] {
        var totals: [Operation: Double] = [:]
        var counts: [Operation: Int] = [:]
        for entry in problemHistory {
            if let time = entry.timeTaken {
                totals[entry.problem.operation, default: 0] += time
                counts[entry.problem.operation, default: 0] += 1
            }
        }
        var result: [Operation: Double] = [:]
        for (op, total) in totals {
            if let count = counts[op], count > 0 {
                result[op] = total / Double(count)
            }
        }
        return result
    }

    /// The operation with the slowest average response time this game
    var slowestOperationThisGame: Operation? {
        let times = averageTimePerOperation
        guard !times.isEmpty else { return nil }
        return times.max(by: { $0.value < $1.value })?.key
    }

    /// Accuracy difference vs player's historical average (positive = above average)
    var accuracyVsAverage: Double {
        guard let avg = playerAverageAccuracy, avg > 0 else { return 0 }
        return accuracy - avg
    }

    /// Elo rating deltas from this game's problem history
    var eloDeltas: [Operation: Double] {
        guard !problemHistory.isEmpty else { return [:] }
        let initialRatings: [Operation: Double] = [
            .add: 1000, .subtract: 1000, .multiply: 1000, .divide: 1000
        ]
        return EloSystem.computeDeltas(from: problemHistory, initialRatings: initialRatings)
    }

    /// Fastest correct answer time per operation
    var fastestTimePerOperation: [Operation: Double] {
        var fastest: [Operation: Double] = [:]
        for entry in problemHistory {
            guard entry.isCorrect, let time = entry.timeTaken else { continue }
            if let current = fastest[entry.problem.operation] {
                fastest[entry.problem.operation] = min(current, time)
            } else {
                fastest[entry.problem.operation] = time
            }
        }
        return fastest
    }

    /// Streak milestone text for best streak achieved this game
    var streakMilestoneText: String? {
        guard bestStreak >= 5 else { return nil }
        if bestStreak >= 10 {
            return "Amazing \(bestStreak)-streak!"
        }
        return "\(bestStreak)-streak!"
    }

    /// Problem difficulty distribution based on Elo difficulty rating
    var problemDifficultyDistribution: [String: Int] {
        guard !problemHistory.isEmpty else { return [:] }
        var dist: [String: Int] = [:]
        for entry in problemHistory {
            let rating = EloSystem.problemDifficultyRating(
                operand1: entry.problem.operand1,
                operand2: entry.problem.operand2,
                operation: entry.problem.operation
            )
            let category: String
            if rating < 900 { category = "Easy" }
            else if rating < 1100 { category = "Moderate" }
            else { category = "Hard" }
            dist[category, default: 0] += 1
        }
        return dist
    }

    /// Accuracy improvement from first half to second half of game
    var accuracyImprovementOverHalves: Double? {
        guard problemHistory.count >= 4 else { return nil }
        let mid = problemHistory.count / 2
        let firstHalf = Array(problemHistory.prefix(mid))
        let secondHalf = Array(problemHistory.suffix(problemHistory.count - mid))
        let firstAcc = Double(firstHalf.filter(\.isCorrect).count) / Double(firstHalf.count) * 100
        let secondAcc = Double(secondHalf.filter(\.isCorrect).count) / Double(secondHalf.count) * 100
        return secondAcc - firstAcc
    }

    /// Longest run of consecutive correct answers in problem history
    var longestCorrectRun: Int {
        var longest = 0
        var current = 0
        for entry in problemHistory {
            if entry.isCorrect {
                current += 1
                longest = max(longest, current)
            } else {
                current = 0
            }
        }
        return longest
    }

    /// Streak frequency: how many streaks of 3+, 5+, 10+
    struct StreakFrequency {
        var threePlus: Int = 0
        var fivePlus: Int = 0
        var tenPlus: Int = 0
    }

    var streakFrequency: StreakFrequency {
        var freq = StreakFrequency()
        var current = 0
        for entry in problemHistory {
            if entry.isCorrect {
                current += 1
            } else {
                if current >= 10 { freq.tenPlus += 1 }
                if current >= 5 { freq.fivePlus += 1 }
                if current >= 3 { freq.threePlus += 1 }
                current = 0
            }
        }
        if current >= 10 { freq.tenPlus += 1 }
        if current >= 5 { freq.fivePlus += 1 }
        if current >= 3 { freq.threePlus += 1 }
        return freq
    }

    /// Answer speed classification
    struct SpeedDistribution {
        var fast: Int = 0    // < 2s
        var normal: Int = 0  // 2-5s
        var slow: Int = 0    // > 5s
    }

    var answerSpeedDistribution: SpeedDistribution {
        var dist = SpeedDistribution()
        for entry in problemHistory {
            guard let time = entry.timeTaken else { continue }
            if time < 2.0 { dist.fast += 1 }
            else if time <= 5.0 { dist.normal += 1 }
            else { dist.slow += 1 }
        }
        return dist
    }

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
