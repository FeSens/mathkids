import SwiftUI

struct AccuracyChartView: View {
    let accuracies: [Double]

    var body: some View {
        GeometryReader { geo in
            let maxVal = max(accuracies.max() ?? 100, 100)
            let minVal = max(min(accuracies.min() ?? 0, 0), 0)
            let range = max(maxVal - minVal, 1)
            let stepX = accuracies.count > 1 ? geo.size.width / CGFloat(accuracies.count - 1) : geo.size.width
            let height = geo.size.height

            ZStack(alignment: .bottomLeading) {
                // Grid lines
                ForEach([0.0, 25.0, 50.0, 75.0, 100.0], id: \.self) { pct in
                    let y = height - (CGFloat(pct - minVal) / CGFloat(range)) * height
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geo.size.width, y: y))
                    }
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                }

                // Line
                if accuracies.count > 1 {
                    Path { path in
                        for (i, acc) in accuracies.enumerated() {
                            let x = CGFloat(i) * stepX
                            let y = height - (CGFloat(acc - minVal) / CGFloat(range)) * height
                            if i == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(
                        LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round)
                    )
                }

                // Dots
                ForEach(Array(accuracies.enumerated()), id: \.offset) { i, acc in
                    let x = accuracies.count > 1 ? CGFloat(i) * stepX : geo.size.width / 2
                    let y = height - (CGFloat(acc - minVal) / CGFloat(range)) * height
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 6, height: 6)
                        .position(x: x, y: y)
                }

                // Y-axis labels
                Text("100%")
                    .font(.system(size: 9))
                    .foregroundStyle(.secondary)
                    .position(x: 20, y: 6)

                Text("0%")
                    .font(.system(size: 9))
                    .foregroundStyle(.secondary)
                    .position(x: 12, y: height - 6)
            }
        }
    }
}
