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

    var operationKeyword: String {
        switch self {
        case .add: return "plus"
        case .subtract: return "minus"
        case .multiply: return "times"
        case .divide: return "divided by"
        }
    }

    var isLastInOrder: Bool {
        self == .divide
    }

    var operationPairName: String {
        switch self {
        case .add, .subtract: return "addition/subtraction"
        case .multiply, .divide: return "multiplication/division"
        }
    }

    var gradeLevel: Int {
        switch self {
        case .add: return 1
        case .subtract: return 1
        case .multiply: return 3
        case .divide: return 3
        }
    }

    var operationSortKey: String {
        "\(operationOrder)-\(displayName)"
    }

    var operationTip: String {
        switch self {
        case .add: return "Count up from the larger number"
        case .subtract: return "Count down from the first number"
        case .multiply: return "Think of it as groups of items"
        case .divide: return "Think of sharing equally"
        }
    }

    var isSubtractOrDivide: Bool {
        requiresOrdering
    }

    var operationLabel: String {
        "[\(rawValue)] \(displayName)"
    }

    var operationIndex: Int {
        operationOrder
    }

    var isAddOrMultiply: Bool {
        self == .add || self == .multiply
    }

    var operationQuizPrompt: String {
        "What is the \(resultVerb)?"
    }

    var isReductiveOperation: Bool {
        self == .subtract || self == .divide
    }

    var operationBadge: String {
        String(rawValue.prefix(1))
    }

    var teachingOrder: Int {
        operationOrder + 1
    }

    var operationAccessibilityLabel: String {
        "\(displayName) operation, symbol \(rawValue)"
    }

    var canProduceNegative: Bool {
        self == .subtract
    }

    var operationColor: String {
        switch self {
        case .add: return "blue"
        case .subtract: return "green"
        case .multiply: return "purple"
        case .divide: return "orange"
        }
    }

    var isMultiplyOrDivide: Bool {
        isAdvancedOperation
    }

    var operationDifficultyLabel: String {
        switch self {
        case .add: return "Beginner"
        case .subtract: return "Beginner"
        case .multiply: return "Intermediate"
        case .divide: return "Advanced"
        }
    }

    var relatedFact: String {
        switch self {
        case .add: return "Addition is the foundation of all math"
        case .subtract: return "Subtraction is the inverse of addition"
        case .multiply: return "Multiplication is a shortcut for repeated addition"
        case .divide: return "Division is the inverse of multiplication"
        }
    }

    var canProduceZero: Bool {
        self == .subtract || self == .multiply
    }

    var operationVerb: String {
        switch self {
        case .add: return "add"
        case .subtract: return "subtract"
        case .multiply: return "multiply"
        case .divide: return "divide"
        }
    }

    var needsOrderedOperands: Bool {
        requiresOrdering
    }

    var operationFamily: String {
        switch self {
        case .add, .subtract: return "additive"
        case .multiply, .divide: return "multiplicative"
        }
    }

    var operationAbbreviation: String {
        String(displayName.prefix(1))
    }
}
