import Foundation

extension Operation {
    var operationResultName: String {
        switch self {
        case .add: return "sum"
        case .subtract: return "difference"
        case .multiply: return "product"
        case .divide: return "quotient"
        }
    }

    var operationIsCommutative: Bool {
        self == .add || self == .multiply
    }

    var operationInputLabel: String {
        switch self {
        case .add: return "addends"
        case .subtract: return "minuend and subtrahend"
        case .multiply: return "factors"
        case .divide: return "dividend and divisor"
        }
    }

    var operationMathDomain: String {
        "arithmetic"
    }

    var operationIdentityElement: Int {
        switch self {
        case .add, .subtract: return 0
        case .multiply, .divide: return 1
        }
    }

    var operationSignificance: String {
        switch self {
        case .add: return "Combining quantities"
        case .subtract: return "Finding differences"
        case .multiply: return "Scaling quantities"
        case .divide: return "Distributing equally"
        }
    }

    var operationRelatedSymbols: String {
        switch self {
        case .add: return "+, ∑"
        case .subtract: return "−, Δ"
        case .multiply: return "×, ·, *"
        case .divide: return "÷, /, ∕"
        }
    }

    var operationUnicodeSymbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "−"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }

    var operationLatexSymbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "\\times"
        case .divide: return "\\div"
        }
    }

    var operationWordProblemPhrase: String {
        switch self {
        case .add: return "more than"
        case .subtract: return "less than"
        case .multiply: return "times as many"
        case .divide: return "shared equally among"
        }
    }

    var operationInverseSymbol: String {
        switch self {
        case .add: return "-"
        case .subtract: return "+"
        case .multiply: return "÷"
        case .divide: return "×"
        }
    }

    var operationPrecedence: Int {
        switch self {
        case .add, .subtract: return 1
        case .multiply, .divide: return 2
        }
    }

    var operationSpokenPhrase: String {
        switch self {
        case .add: return "plus"
        case .subtract: return "minus"
        case .multiply: return "times"
        case .divide: return "divided by"
        }
    }

    var operationKeyboardHint: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        }
    }

    var operationPropertyName: String {
        switch self {
        case .add: return "addition"
        case .subtract: return "subtraction"
        case .multiply: return "multiplication"
        case .divide: return "division"
        }
    }

    var operationHasAssociativeProperty: Bool {
        self == .add || self == .multiply
    }

    var operationMaxSingleDigitResult: Int {
        switch self {
        case .add: return 18
        case .subtract: return 9
        case .multiply: return 81
        case .divide: return 9
        }
    }

    var operationMinSingleDigitResult: Int {
        switch self {
        case .add: return 0
        case .subtract: return 0
        case .multiply: return 0
        case .divide: return 0
        }
    }

    var operationAlternateSymbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        }
    }

    var operationIsInverse: Bool {
        self == .subtract || self == .divide
    }

    var operationSentence: String {
        switch self {
        case .add: return "A plus B equals C"
        case .subtract: return "A minus B equals C"
        case .multiply: return "A times B equals C"
        case .divide: return "A divided by B equals C"
        }
    }

    var operationEmoji: String {
        switch self {
        case .add: return "➕"
        case .subtract: return "➖"
        case .multiply: return "✖️"
        case .divide: return "➗"
        }
    }

    var operationGradeDescription: String {
        switch self {
        case .add: return "1st grade"
        case .subtract: return "1st grade"
        case .multiply: return "3rd grade"
        case .divide: return "3rd grade"
        }
    }

    var operationNumberOfOperands: Int {
        2
    }

    var operationIsClosedOnNaturals: Bool {
        self == .add || self == .multiply
    }

    var operationTableSize: Int {
        100
    }

    var operationFlashcardLabel: String {
        "? \(rawValue) ? = ?"
    }

    var operationQuizInstruction: String {
        switch self {
        case .add: return "Find the sum"
        case .subtract: return "Find the difference"
        case .multiply: return "Find the product"
        case .divide: return "Find the quotient"
        }
    }

    var operationHasDistributiveProperty: Bool {
        self == .multiply
    }

    var operationCountingDirection: String {
        switch self {
        case .add, .multiply: return "up"
        case .subtract, .divide: return "down"
        }
    }

    var operationDifficultyStars: Int {
        difficultyWeight
    }

    var operationPracticeGoal: Int {
        switch self {
        case .add: return 20
        case .subtract: return 15
        case .multiply: return 12
        case .divide: return 10
        }
    }

    var operationNumberFact: String {
        switch self {
        case .add: return "Addition was one of the first operations invented"
        case .subtract: return "Subtraction uses the minus sign since 1489"
        case .multiply: return "The multiplication sign × was introduced in 1631"
        case .divide: return "The division sign ÷ is called an obelus"
        }
    }

    var operationMasteryThreshold: Int {
        switch self {
        case .add: return 50
        case .subtract: return 40
        case .multiply: return 35
        case .divide: return 30
        }
    }

    var operationIsAdditive: Bool {
        self == .add || self == .subtract
    }

    var operationIsMultiplicative: Bool {
        self == .multiply || self == .divide
    }

    var operationEncouragementText: String {
        switch self {
        case .add: return "Great job adding!"
        case .subtract: return "Awesome subtraction!"
        case .multiply: return "Multiplication master!"
        case .divide: return "Division champion!"
        }
    }
}
