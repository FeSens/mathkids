import Foundation

extension Operation {
    var inverseOperation: Operation {
        switch self {
        case .add: return .subtract
        case .subtract: return .add
        case .multiply: return .divide
        case .divide: return .multiply
        }
    }

    var isBasicArithmetic: Bool {
        isPrimaryOperation
    }

    var operationDescription: String {
        switch self {
        case .add: return "Addition combines two numbers"
        case .subtract: return "Subtraction finds the difference"
        case .multiply: return "Multiplication is repeated addition"
        case .divide: return "Division splits into equal parts"
        }
    }

    var isAdvancedOperation: Bool {
        !isPrimaryOperation
    }

    var operationOrder: Int {
        switch self {
        case .add: return 0
        case .subtract: return 1
        case .multiply: return 2
        case .divide: return 3
        }
    }

    var operationSymbolName: String {
        switch self {
        case .add: return "plus"
        case .subtract: return "minus"
        case .multiply: return "multiply"
        case .divide: return "divide"
        }
    }

    var operationShortName: String {
        switch self {
        case .add: return "ADD"
        case .subtract: return "SUB"
        case .multiply: return "MUL"
        case .divide: return "DIV"
        }
    }

    var isFirstInOrder: Bool {
        self == .add
    }

    var operationComplexity: String {
        isPrimaryOperation ? "basic" : "advanced"
    }

    var symbolForDisplay: String {
        switch self {
        case .add: return "+"
        case .subtract: return "−"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}
