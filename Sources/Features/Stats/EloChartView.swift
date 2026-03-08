import SwiftUI

struct EloChartView: View {
    let addHistory: [Double]
    let subtractHistory: [Double]
    let multiplyHistory: [Double]
    let divideHistory: [Double]

    let addRating: Double
    let subtractRating: Double
    let multiplyRating: Double
    let divideRating: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Skill Ratings")
                .font(.system(size: 18, weight: .bold, design: .rounded))

            ratingsRow

            chartSection

            legendRow
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
        .accessibilityIdentifier("eloChart")
    }

    private var ratingsRow: some View {
        HStack(spacing: 12) {
            ratingBadge(op: "+", rating: addRating, color: .green)
            ratingBadge(op: "-", rating: subtractRating, color: .blue)
            ratingBadge(op: "x", rating: multiplyRating, color: .orange)
            ratingBadge(op: "/", rating: divideRating, color: .purple)
        }
    }

    private var chartSection: some View {
        EloChartCanvas(
            addHistory: addHistory,
            subtractHistory: subtractHistory,
            multiplyHistory: multiplyHistory,
            divideHistory: divideHistory
        )
        .frame(height: 150)
        .padding(.leading, 28)
    }

    private var legendRow: some View {
        HStack(spacing: 16) {
            legendItem(symbol: "+", color: .green)
            legendItem(symbol: "-", color: .blue)
            legendItem(symbol: "x", color: .orange)
            legendItem(symbol: "/", color: .purple)
        }
        .font(.system(size: 12, design: .rounded))
    }

    private func ratingBadge(op: String, rating: Double, color: Color) -> some View {
        VStack(spacing: 2) {
            Text(op)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(color)
            Text("\(Int(rating))")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            Text(EloSystem.skillLevel(forRating: rating))
                .font(.system(size: 9, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.1))
        )
    }

    private func legendItem(symbol: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(symbol)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(color)
        }
    }
}

private struct EloChartCanvas: View {
    let addHistory: [Double]
    let subtractHistory: [Double]
    let multiplyHistory: [Double]
    let divideHistory: [Double]

    var body: some View {
        GeometryReader { geo in
            let params = chartParams(size: geo.size)
            ZStack(alignment: .topLeading) {
                gridLines(size: geo.size, minVal: params.minVal, range: params.range)
                chartLine(data: addHistory, color: .green, size: geo.size, minVal: params.minVal, range: params.range)
                chartLine(data: subtractHistory, color: .blue, size: geo.size, minVal: params.minVal, range: params.range)
                chartLine(data: multiplyHistory, color: .orange, size: geo.size, minVal: params.minVal, range: params.range)
                chartLine(data: divideHistory, color: .purple, size: geo.size, minVal: params.minVal, range: params.range)
            }
        }
    }

    private struct ChartParams {
        let minVal: Double
        let maxVal: Double
        let range: Double
    }

    private func chartParams(size: CGSize) -> ChartParams {
        let allValues = [addHistory, subtractHistory, multiplyHistory, divideHistory].flatMap { $0 }
        let minVal = (allValues.min() ?? 800) - 50
        let maxVal = (allValues.max() ?? 1200) + 50
        let range = max(maxVal - minVal, 1)
        return ChartParams(minVal: minVal, maxVal: maxVal, range: range)
    }

    private func gridLines(size: CGSize, minVal: Double, range: Double) -> some View {
        let values = [
            minVal,
            minVal + range / 4,
            minVal + range / 2,
            minVal + range * 3 / 4,
            minVal + range
        ]
        return ForEach(Array(values.enumerated()), id: \.offset) { _, val in
            gridLine(val: val, size: size, minVal: minVal, range: range)
        }
    }

    private func gridLine(val: Double, size: CGSize, minVal: Double, range: Double) -> some View {
        let y = size.height * (1 - (val - minVal) / range)
        return ZStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }
            .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)

            Text("\(Int(val))")
                .font(.system(size: 8))
                .foregroundStyle(.secondary)
                .position(x: 18, y: y)
        }
    }

    private func chartLine(data: [Double], color: Color, size: CGSize, minVal: Double, range: Double) -> some View {
        Path { path in
            guard data.count > 1 else { return }
            let stepX = size.width / CGFloat(max(data.count - 1, 1))
            for (i, val) in data.enumerated() {
                let x = CGFloat(i) * stepX
                let y = size.height * (1 - CGFloat((val - minVal) / range))
                if i == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
        }
        .stroke(color, lineWidth: 2)
    }
}
