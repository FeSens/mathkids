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
