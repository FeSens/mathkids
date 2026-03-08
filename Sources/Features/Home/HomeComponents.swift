import SwiftUI

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    @State private var animatedValue: Int = 0
    @State private var hasAppeared = false

    private var numericValue: Int? {
        Int(value)
    }

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(numericValue != nil ? "\(animatedValue)" : value)
                .font(.system(size: 24, weight: .bold, design: .rounded))

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.1))
        )
        .onAppear {
            guard !hasAppeared, let target = numericValue, target > 0 else {
                if let n = numericValue { animatedValue = n }
                return
            }
            hasAppeared = true
            let steps = min(target, 20)
            let increment = max(target / steps, 1)
            Task { @MainActor in
                for _ in 0..<steps {
                    try? await Task.sleep(for: .milliseconds(30))
                    animatedValue = min(animatedValue + increment, target)
                }
                animatedValue = target
            }
        }
    }
}

struct DifficultyButton: View {
    let level: DifficultyLevel
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(level.emoji)
                    .font(.title2)
                    .scaleEffect(isSelected ? 1.2 : 1.0)
                    .animation(.spring(duration: 0.4, bounce: 0.5), value: isSelected)
                Text(level.displayName)
                    .font(.system(size: 15, weight: .bold, design: .rounded))

                HStack(spacing: 3) {
                    ForEach(level.allowedOperations.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { op in
                        Text(op.rawValue)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundStyle(levelColor.opacity(0.8))
                    }
                }

                HStack(spacing: 4) {
                    Image(systemName: "number")
                        .font(.system(size: 9))
                    Text("1-\(level.operandRange.upperBound)")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                }
                .foregroundStyle(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: "timer")
                        .font(.system(size: 9))
                    Text("\(level.timeLimitSeconds)s")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                }
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? levelColor.opacity(0.2) : Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? levelColor : .clear, lineWidth: 2)
                    )
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(duration: 0.3), value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("difficulty_\(level.displayName)")
    }

    private var levelColor: Color {
        switch level {
        case .easy: .green
        case .medium: .orange
        case .hard: .red
        }
    }
}

struct OperationChip: View {
    let operation: Operation
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(operation.rawValue)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .frame(width: 52, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.purple.opacity(0.2) : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? Color.purple : .gray.opacity(0.3), lineWidth: 2)
                        )
                )
                .foregroundStyle(isSelected ? .purple : .gray)
        }
        .buttonStyle(.plain)
    }
}

struct LevelBadgeView: View {
    let level: Int
    let name: String
    let progress: Double
    let totalXP: Int

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                Text("Lv.\(level)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    )

                Text(name)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
            }
            .accessibilityIdentifier("levelBadge")

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * progress)
                }
            }
            .frame(height: 6)
            .padding(.horizontal, 40)
            .accessibilityIdentifier("xpProgressBar")

            HStack {
                Text("\(totalXP) XP")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(.purple)
            }
        }
        .accessibilityIdentifier("levelProgressSection")
    }
}

struct MathTipCard: View {
    let seed: Int

    private static let tips = [
        "To add 9, add 10 then subtract 1!",
        "Doubles are easy: 6+6=12, 7+7=14, 8+8=16",
        "To multiply by 5, multiply by 10 then divide by 2",
        "Subtraction is the opposite of addition",
        "To multiply by 9, multiply by 10 then subtract once",
        "Break big numbers into friendly parts: 14+8 = 14+6+2",
        "Even + Even = Even, Odd + Odd = Even",
        "Any number times 0 is always 0",
        "Practice makes permanent - keep at it!"
    ]

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .font(.title3)
                .foregroundStyle(.yellow)

            Text(Self.tips[abs(seed) % Self.tips.count])
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.yellow.opacity(0.08))
        )
        .accessibilityIdentifier("mathTipCard")
    }
}
