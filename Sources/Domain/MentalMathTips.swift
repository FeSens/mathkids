import Foundation

/// Database of mental math strategies with step-by-step hints for solving problems.
enum MentalMathTips {

    struct Tip: Identifiable {
        let id = UUID()
        let title: String
        let steps: [String]
    }

    /// Generate contextual step-by-step tips for a specific problem
    static func tips(for problem: MathProblem) -> [String] {
        let a = problem.operand1
        let b = problem.operand2

        switch problem.operation {
        case .add:
            return additionTips(a: a, b: b)
        case .subtract:
            return subtractionTips(a: a, b: b)
        case .multiply:
            return multiplicationTips(a: a, b: b)
        case .divide:
            return divisionTips(a: a, b: b)
        }
    }

    // MARK: - Addition Tips

    private static func additionTips(a: Int, b: Int) -> [String] {
        // Adding 9: add 10, subtract 1
        if b == 9 || a == 9 {
            let other = b == 9 ? a : b
            return [
                "Adding 9 is like adding 10 then subtracting 1",
                "\(other) + 10 = \(other + 10)",
                "\(other + 10) - 1 = \(other + 9)",
                "Answer: \(a + b)"
            ]
        }

        // Adding to make 10 first (bridge to 10)
        if a < 10 && b < 10 && a + b > 10 {
            let complement = 10 - a
            let remainder = b - complement
            return [
                "Bridge to 10: how much does \(a) need to reach 10?",
                "\(a) needs \(complement) more to make 10",
                "Take \(complement) from \(b), leaving \(remainder)",
                "10 + \(remainder) = \(a + b)",
                "Answer: \(a + b)"
            ]
        }

        // Doubles or near-doubles
        if a == b {
            return [
                "This is a double! \(a) + \(a)",
                "Double \(a) = \(a * 2)",
                "Answer: \(a + b)"
            ]
        }
        if abs(a - b) == 1 {
            let smaller = min(a, b)
            return [
                "Near-double: \(a) and \(b) are close",
                "Double \(smaller) = \(smaller * 2)",
                "Add 1 more: \(smaller * 2) + 1 = \(a + b)",
                "Answer: \(a + b)"
            ]
        }

        // Round number strategy for larger numbers
        if b >= 10 {
            let rounded = ((b + 5) / 10) * 10
            let diff = rounded - b
            if diff != 0 && diff < 5 {
                return [
                    "Round \(b) up to \(rounded)",
                    "\(a) + \(rounded) = \(a + rounded)",
                    "Subtract the extra \(diff): \(a + rounded) - \(diff) = \(a + b)",
                    "Answer: \(a + b)"
                ]
            }
        }

        // Default: break apart
        return [
            "Break \(b) into parts you know",
            "\(a) + \(b) = ?",
            "Count up from \(a): add \(b)",
            "Answer: \(a + b)"
        ]
    }

    // MARK: - Subtraction Tips

    private static func subtractionTips(a: Int, b: Int) -> [String] {
        // Subtracting 9: subtract 10, add 1
        if b == 9 {
            return [
                "Subtracting 9 is like subtracting 10 then adding 1",
                "\(a) - 10 = \(a - 10)",
                "\(a - 10) + 1 = \(a - 9)",
                "Answer: \(a - b)"
            ]
        }

        // Count up strategy (when numbers are close)
        if a - b <= 5 && a - b > 0 {
            return [
                "Count up from \(b) to \(a)",
                "How many steps from \(b) to \(a)?",
                "It's \(a - b) steps",
                "Answer: \(a - b)"
            ]
        }

        // Round the subtrahend
        if b >= 10 {
            let rounded = ((b + 5) / 10) * 10
            let diff = rounded - b
            if diff != 0 && diff < 5 {
                return [
                    "Round \(b) up to \(rounded)",
                    "\(a) - \(rounded) = \(a - rounded)",
                    "Add back \(diff): \(a - rounded) + \(diff) = \(a - b)",
                    "Answer: \(a - b)"
                ]
            }
        }

        // Think of addition
        return [
            "Think: what + \(b) = \(a)?",
            "\(b) + ? = \(a)",
            "The missing number is \(a - b)",
            "Answer: \(a - b)"
        ]
    }

    // MARK: - Multiplication Tips

    private static func multiplicationTips(a: Int, b: Int) -> [String] {
        // Multiply by 5: multiply by 10, divide by 2
        if a == 5 || b == 5 {
            let other = a == 5 ? b : a
            return [
                "Multiplying by 5: multiply by 10, then halve it",
                "\(other) x 10 = \(other * 10)",
                "\(other * 10) / 2 = \(other * 5)",
                "Answer: \(a * b)"
            ]
        }

        // Multiply by 9: multiply by 10, subtract once
        if a == 9 || b == 9 {
            let other = a == 9 ? b : a
            return [
                "Multiplying by 9: multiply by 10, then subtract once",
                "\(other) x 10 = \(other * 10)",
                "\(other * 10) - \(other) = \(other * 9)",
                "Answer: \(a * b)"
            ]
        }

        // Break apart strategy (distributive property)
        if a > 5 && b > 5 {
            let splitA = a > b ? a : b
            let otherNum = a > b ? b : a
            let part1 = splitA / 2
            let part2 = splitA - part1
            return [
                "Break \(splitA) into \(part1) + \(part2)",
                "\(otherNum) x \(part1) = \(otherNum * part1)",
                "\(otherNum) x \(part2) = \(otherNum * part2)",
                "\(otherNum * part1) + \(otherNum * part2) = \(a * b)",
                "Answer: \(a * b)"
            ]
        }

        // Doubles
        if a == 2 || b == 2 {
            let other = a == 2 ? b : a
            return [
                "Multiplying by 2 is doubling",
                "Double \(other) = \(other * 2)",
                "Answer: \(a * b)"
            ]
        }

        // Groups visualization
        return [
            "Think of \(a) groups of \(b)",
            "\(a) x \(b) = \(a) groups with \(b) in each",
            "Answer: \(a * b)"
        ]
    }

    // MARK: - Division Tips

    private static func divisionTips(a: Int, b: Int) -> [String] {
        let answer = a / b

        // Think of multiplication
        if b <= 12 {
            return [
                "Think: \(b) x ? = \(a)",
                "What number times \(b) gives \(a)?",
                "\(b) x \(answer) = \(a)",
                "Answer: \(answer)"
            ]
        }

        // Halving for dividing by 2
        if b == 2 {
            return [
                "Dividing by 2 is finding half",
                "Half of \(a) = \(answer)",
                "Answer: \(answer)"
            ]
        }

        // Division by repeated subtraction concept
        return [
            "How many times does \(b) fit into \(a)?",
            "Count: \(b), \((b * 2 <= a) ? "\(b*2)" : "...")...",
            "\(b) fits \(answer) times",
            "Answer: \(answer)"
        ]
    }
}
