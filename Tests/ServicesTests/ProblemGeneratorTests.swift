import Testing
@testable import MathKids

@Suite("ProblemGenerator Tests")
struct ProblemGeneratorTests {
    let generator = ProblemGenerator()

    @Test("Easy problems use operands 1-10")
    func easyOperandRange() {
        for _ in 0..<100 {
            let problem = generator.generate(for: .easy)
            // For division, dividend can exceed range (divisor * quotient)
            if problem.operation != .divide {
                #expect(problem.operand1 >= 1 && problem.operand1 <= 10)
                #expect(problem.operand2 >= 1 && problem.operand2 <= 10)
            }
        }
    }

    @Test("Easy problems only use add and subtract")
    func easyOperations() {
        for _ in 0..<100 {
            let problem = generator.generate(for: .easy)
            #expect(problem.operation == .add || problem.operation == .subtract)
        }
    }

    @Test("Medium problems use add, subtract, multiply")
    func mediumOperations() {
        var seenOps: Set<String> = []
        for _ in 0..<200 {
            let problem = generator.generate(for: .medium)
            seenOps.insert(problem.operation.rawValue)
            #expect(problem.operation != .divide)
        }
        #expect(seenOps.count == 3)
    }

    @Test("Hard problems can use all operations")
    func hardOperations() {
        var seenOps: Set<String> = []
        for _ in 0..<200 {
            let problem = generator.generate(for: .hard)
            seenOps.insert(problem.operation.rawValue)
        }
        #expect(seenOps.count == 4)
    }

    @Test("Division problems have clean integer answers")
    func divisionCleanAnswers() {
        for _ in 0..<100 {
            let problem = generator.generate(for: .hard)
            if problem.operation == .divide {
                #expect(problem.operand1 % problem.operand2 == 0)
                #expect(problem.correctAnswer == problem.operand1 / problem.operand2)
            }
        }
    }

    @Test("Easy subtraction never produces negative results")
    func easySubtractionNonNegative() {
        for _ in 0..<200 {
            let problem = generator.generate(for: .easy)
            if problem.operation == .subtract {
                #expect(problem.correctAnswer >= 0,
                       "Got negative: \(problem.operand1) - \(problem.operand2) = \(problem.correctAnswer)")
            }
        }
    }
}
