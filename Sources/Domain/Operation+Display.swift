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
}
