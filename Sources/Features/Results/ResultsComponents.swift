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
