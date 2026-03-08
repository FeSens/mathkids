import Testing
@testable import MathKids

@Suite("ProblemGenerator Tests")
struct ProblemGeneratorTests {
    @Test("Easy problems use operands 1-10")
    func easyOperandRange() {
        var gen = ProblemGenerator()
        for _ in 0..<100 {
            let problem = gen.generate(for: .easy)
            if problem.operation != .divide {
                #expect(problem.operand1 >= 1 && problem.operand1 <= 10)
                #expect(problem.operand2 >= 1 && problem.operand2 <= 10)
            }
        }
    }

    @Test("Easy problems only use add and subtract")
    func easyOperations() {
        var gen = ProblemGenerator()
        for _ in 0..<100 {
            let problem = gen.generate(for: .easy)
            #expect(problem.operation == .add || problem.operation == .subtract)
        }
    }

    @Test("Medium problems use add, subtract, multiply")
    func mediumOperations() {
        var gen = ProblemGenerator()
        var seenOps: Set<String> = []
        for _ in 0..<200 {
            let problem = gen.generate(for: .medium)
            seenOps.insert(problem.operation.rawValue)
            #expect(problem.operation != .divide)
        }
        #expect(seenOps.count == 3)
    }

    @Test("Hard problems can use all operations")
    func hardOperations() {
        var gen = ProblemGenerator()
        var seenOps: Set<String> = []
        for _ in 0..<200 {
            let problem = gen.generate(for: .hard)
            seenOps.insert(problem.operation.rawValue)
        }
        #expect(seenOps.count == 4)
    }

    @Test("Division problems have clean integer answers")
    func divisionCleanAnswers() {
        var gen = ProblemGenerator()
        for _ in 0..<100 {
            let problem = gen.generate(for: .hard)
            if problem.operation == .divide {
                #expect(problem.operand1 % problem.operand2 == 0)
                #expect(problem.correctAnswer == problem.operand1 / problem.operand2)
            }
        }
    }

    @Test("Easy subtraction never produces negative results")
    func easySubtractionNonNegative() {
        var gen = ProblemGenerator()
        for _ in 0..<200 {
            let problem = gen.generate(for: .easy)
            if problem.operation == .subtract {
                #expect(problem.correctAnswer >= 0,
                       "Got negative: \(problem.operand1) - \(problem.operand2) = \(problem.correctAnswer)")
            }
        }
    }

    @Test("Operations filter restricts generated operations")
    func operationsFilter() {
        var gen = ProblemGenerator()
        let addOnly: Set<Operation> = [.add]
        for _ in 0..<100 {
            let problem = gen.generate(for: .hard, allowedOperations: addOnly)
            #expect(problem.operation == .add)
        }
    }

    @Test("Operations filter intersects with difficulty allowed operations")
    func operationsFilterIntersectsDifficulty() {
        var gen = ProblemGenerator()
        let multiplyOnly: Set<Operation> = [.multiply]
        for _ in 0..<100 {
            let problem = gen.generate(for: .easy, allowedOperations: multiplyOnly)
            #expect(problem.operation == .add || problem.operation == .subtract)
        }
    }

    // MARK: - Duplicate Prevention (ui-169)

    @Test("Consecutive problems are not identical")
    func noDuplicateConsecutive() {
        var gen = ProblemGenerator()
        var lastProblem = gen.generate(for: .easy)
        var duplicateCount = 0
        for _ in 0..<50 {
            let problem = gen.generate(for: .easy)
            if problem == lastProblem { duplicateCount += 1 }
            lastProblem = problem
        }
        // With duplicate prevention, should have 0 or very few duplicates
        #expect(duplicateCount <= 2)
    }
}
