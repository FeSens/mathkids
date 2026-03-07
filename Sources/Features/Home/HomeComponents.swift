import SwiftUI

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
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
    }
}

struct DifficultyButton: View {
    let level: DifficultyLevel
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(level.emoji)
                    .font(.title2)
                Text(level.displayName)
                    .font(.subheadline.bold())
                Text(level.briefDescription)
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? levelColor.opacity(0.2) : Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? levelColor : .gray.opacity(0.3), lineWidth: 2)
                    )
            )
        }
        .buttonStyle(.plain)
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
