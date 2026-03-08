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
}
