import Testing
@testable import MathKids

@Suite("MathProblem Extended Tests")
struct MathProblemExtendedTests {

    // MARK: - Operation Difficulty Rank (logic-276)

    @Test("Add is rank 1")
    func addRank() {
        #expect(Operation.add.difficultyRank == 1)
    }

    @Test("Subtract is rank 2")
    func subtractRank() {
        #expect(Operation.subtract.difficultyRank == 2)
    }

    @Test("Multiply is rank 3")
    func multiplyRank() {
        #expect(Operation.multiply.difficultyRank == 3)
    }

    @Test("Divide is rank 4")
    func divideRank() {
        #expect(Operation.divide.difficultyRank == 4)
    }

    // MARK: - Estimated Difficulty Time (logic-279)

    @Test("Easy addition takes less estimated time")
    func easyAdditionTime() {
        let easy = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let hard = MathProblem(operand1: 15, operand2: 8, operation: .multiply)
        #expect(easy.estimatedSeconds < hard.estimatedSeconds)
    }

    @Test("All estimates are positive")
    func allEstimatesPositive() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.estimatedSeconds > 0)
    }

    // MARK: - Formatted Answer (logic-286)

    @Test("Single digit formats without comma")
    func formattedAnswerSingleDigit() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.formattedAnswer == "5")
    }

    @Test("Large number formats correctly")
    func formattedAnswerLarge() {
        let problem = MathProblem(operand1: 50, operand2: 50, operation: .multiply)
        #expect(problem.formattedAnswer == "2,500")
    }

    // MARK: - Operation Color (logic-292)

    @Test("Each operation has a non-empty color")
    func operationColors() {
        for op in Operation.allCases {
            #expect(!op.colorName.isEmpty)
        }
    }

    @Test("All operations have different colors")
    func uniqueOperationColors() {
        let colors = Operation.allCases.map(\.colorName)
        #expect(Set(colors).count == 4)
    }

    // MARK: - Inverse Problem (logic-296)

    @Test("Addition inverse creates subtraction")
    func additionInverseProblem() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let inverse = problem.inverseProblem
        #expect(inverse.operation == .subtract)
    }

    @Test("Multiplication inverse creates division")
    func multiplicationInverseProblem() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .multiply)
        let inverse = problem.inverseProblem
        #expect(inverse.operation == .divide)
    }

    @Test("Inverse answer equals original operand")
    func inverseAnswerEqualsOperand() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add) // 3+4=7
        let inverse = problem.inverseProblem // 7-4=3
        #expect(inverse.correctAnswer == problem.operand1)
    }

    // MARK: - Operation isCommutative (logic-305)

    @Test("Add is commutative")
    func addIsCommutative() {
        #expect(Operation.add.isCommutative == true)
    }

    @Test("Multiply is commutative")
    func multiplyIsCommutative() {
        #expect(Operation.multiply.isCommutative == true)
    }

    @Test("Subtract is not commutative")
    func subtractIsNotCommutative() {
        #expect(Operation.subtract.isCommutative == false)
    }

    @Test("Divide is not commutative")
    func divideIsNotCommutative() {
        #expect(Operation.divide.isCommutative == false)
    }

    // MARK: - Difficulty Score (logic-309)

    @Test("Simple addition has low score")
    func simpleAdditionLowScore() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.difficultyScore <= 3)
    }

    @Test("Large multiplication has high score")
    func largeMultiplicationHighScore() {
        let problem = MathProblem(operand1: 45, operand2: 38, operation: .multiply)
        #expect(problem.difficultyScore >= 7)
    }

    @Test("Score is between 1 and 10")
    func scoreInRange() {
        let problem = MathProblem(operand1: 10, operand2: 5, operation: .subtract)
        #expect(problem.difficultyScore >= 1 && problem.difficultyScore <= 10)
    }

    // MARK: - Keyboard Shortcut Hint (logic-315)

    @Test("Each operation has a non-empty hint")
    func allHintsNonEmpty() {
        for op in Operation.allCases {
            #expect(!op.keyboardHint.isEmpty)
        }
    }

    @Test("All hints are unique")
    func allHintsUnique() {
        let hints = Operation.allCases.map(\.keyboardHint)
        #expect(Set(hints).count == 4)
    }
}
