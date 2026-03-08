import SwiftUI

struct ResultStat: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)

            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(color.opacity(0.1))
        )
    }
}

struct ProblemHistorySection: View {
    let problemHistory: [AnsweredProblem]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Recent Problems")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)

            ForEach(problemHistory) { entry in
                HStack {
                    Text(entry.problem.displayText)
                        .font(.system(size: 14, design: .rounded))
                    Spacer()
                    if let time = entry.timeLabel {
                        Text(time)
                            .font(.system(size: 11, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                    Text("= \(entry.userAnswer)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(entry.isCorrect ? .green : .red)
                    Image(systemName: entry.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(entry.isCorrect ? .green : .red)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
        .accessibilityIdentifier("problemHistory")
    }
}

struct ScoreComparisonView: View {
    let scoreImprovement: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: scoreImprovement >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                .foregroundStyle(scoreImprovement >= 0 ? .green : .red)
            Text("\(abs(scoreImprovement)) vs best")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(scoreImprovement >= 0 ? .green : .red)
        }
        .accessibilityIdentifier("scoreComparison")
    }
}

struct DifficultyRecommendationView: View {
    let recommendation: String
    let isHarder: Bool

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: isHarder ? "arrow.up.right" : "arrow.down.right")
                .foregroundStyle(.blue)
            Text(recommendation)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.blue)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 10).fill(.blue.opacity(0.1)))
        .accessibilityIdentifier("difficultyRecommendation")
    }
}

struct OperationBreakdownView: View {
    let breakdown: [(operation: Operation, count: Int)]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(breakdown, id: \.operation) { item in
                VStack(spacing: 4) {
                    Text(item.operation.rawValue)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(colorFor(item.operation))
                    Text("\(item.count)")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
            }
        }
        .accessibilityIdentifier("operationBreakdown")
    }

    private func colorFor(_ op: Operation) -> Color {
        switch op {
        case .add: .green
        case .subtract: .blue
        case .multiply: .orange
        case .divide: .purple
        }
    }
}

struct StarRatingView: View {
    let accuracy: Double
    let show: Bool
    @State private var animatedStars: Int = 0

    var starCount: Int {
        if accuracy >= 90 { return 5 }
        if accuracy >= 80 { return 4 }
        if accuracy >= 70 { return 3 }
        if accuracy >= 50 { return 2 }
        return 1
    }

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: i <= animatedStars ? "star.fill" : "star")
                    .font(.system(size: 24))
                    .foregroundStyle(i <= animatedStars ? .yellow : .gray.opacity(0.3))
                    .scaleEffect(i <= animatedStars ? 1.0 : 0.8)
                    .animation(.spring(duration: 0.3).delay(Double(i) * 0.1), value: animatedStars)
            }
        }
        .accessibilityIdentifier("starRating")
        .onChange(of: show) { _, newValue in
            if newValue {
                Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(300))
                    animatedStars = starCount
                }
            }
        }
    }
}

struct OperationAccuracyBars: View {
    let breakdown: [Operation: Double]

    private var sortedOps: [(Operation, Double)] {
        breakdown.sorted { $0.key.rawValue < $1.key.rawValue }
    }

    private func barColor(for accuracy: Double) -> Color {
        if accuracy >= 80 { return .green }
        if accuracy >= 50 { return .orange }
        return .red
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Accuracy by Operation")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)

            ForEach(sortedOps, id: \.0) { op, accuracy in
                HStack(spacing: 8) {
                    Text(op.rawValue)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(width: 24)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.15))
                            RoundedRectangle(cornerRadius: 4)
                                .fill(barColor(for: accuracy))
                                .frame(width: geo.size.width * accuracy / 100)
                        }
                    }
                    .frame(height: 12)
                    Text("\(Int(accuracy))%")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(.secondary)
                        .frame(width: 36, alignment: .trailing)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
        .accessibilityIdentifier("operationAccuracyBars")
    }
}

struct EloDeltaView: View {
    let deltas: [Operation: Double]

    static func formatDelta(_ value: Double) -> String {
        let rounded = Int(value.rounded())
        return rounded >= 0 ? "+\(rounded)" : "\(rounded)"
    }

    private var sortedDeltas: [(Operation, Double)] {
        deltas.sorted { $0.key.rawValue < $1.key.rawValue }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Elo Rating Changes")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)

            HStack(spacing: 16) {
                ForEach(sortedDeltas, id: \.0) { op, delta in
                    HStack(spacing: 4) {
                        Text(op.rawValue)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                        Image(systemName: delta >= 0 ? "arrow.up" : "arrow.down")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(delta >= 0 ? .green : .red)
                        Text(Self.formatDelta(delta))
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(delta >= 0 ? .green : .red)
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
        .accessibilityIdentifier("eloDeltaView")
    }
}

struct AccuracyComparisonView: View {
    let accuracyVsAverage: Double
    let comparisonText: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: accuracyVsAverage >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                .foregroundStyle(accuracyVsAverage >= 0 ? .green : .red)
            Text(comparisonText)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(accuracyVsAverage >= 0 ? .green : .red)
        }
        .accessibilityIdentifier("accuracyComparison")
    }
}

struct SpeedBreakdownView: View {
    let times: [Operation: Double]
    let slowest: Operation?

    private var sortedTimes: [(Operation, Double)] {
        times.sorted { $0.key.rawValue < $1.key.rawValue }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Speed by Operation")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)

            ForEach(sortedTimes, id: \.0) { op, time in
                HStack(spacing: 8) {
                    Text(op.rawValue)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(width: 24)
                    Text(String(format: "%.1fs", time))
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(op == slowest ? .red : .primary)
                    if op == slowest {
                        Text("slowest")
                            .font(.system(size: 11, design: .rounded))
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
        .accessibilityIdentifier("speedBreakdown")
    }
}
