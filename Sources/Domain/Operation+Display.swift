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
}
