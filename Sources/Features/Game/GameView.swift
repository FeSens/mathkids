import SwiftUI

struct GameView: View {
    @State var viewModel: GameViewModel
    var onGameEnd: (GameSession) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                headerBar

                Spacer()

                problemDisplay

                answerDisplay

                Spacer()

                numberPad

            }
            .padding()

            if viewModel.showCelebration {
                CelebrationView(intensity: viewModel.celebrationIntensity)
                    .allowsHitTesting(false)
            }
        }
        .onAppear {
            viewModel.startGame()
        }
        .onChange(of: viewModel.isGameOver) { _, isOver in
            if isOver {
                onGameEnd(viewModel.session)
            }
        }
    }

    private var headerBar: some View {
        VStack(spacing: 8) {
            HStack {
                Label("\(viewModel.score)", systemImage: "star.fill")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)
                    .accessibilityIdentifier("scoreLabel")

                Spacer()

                if viewModel.currentStreak > 0 {
                    Label("\(viewModel.currentStreak)", systemImage: "flame.fill")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.orange)
                        .accessibilityIdentifier("streakLabel")
                }

                Spacer()

                Label("\(viewModel.timeRemaining)s", systemImage: "timer")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(viewModel.timeProgress < 0.25 ? .red : .primary)
                    .accessibilityIdentifier("timerLabel")
            }

            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: timerColors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * viewModel.timeProgress)
                    .animation(.linear(duration: 1), value: viewModel.timeProgress)
            }
            .frame(height: 8)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .accessibilityIdentifier("timerBar")
        }
    }

    private var timerColors: [Color] {
        if viewModel.timeProgress > 0.5 {
            return [.green, .blue]
        } else if viewModel.timeProgress > 0.25 {
            return [.yellow, .orange]
        } else {
            return [.orange, .red]
        }
    }

    private var problemDisplay: some View {
        Text(viewModel.problemText)
            .font(.system(size: 64, weight: .bold, design: .rounded))
            .foregroundStyle(.primary)
            .modifier(ShakeEffect(shakes: viewModel.showShake ? 4 : 0))
            .animation(.default, value: viewModel.showShake)
            .accessibilityIdentifier("problemLabel")
    }

    private var answerDisplay: some View {
        Text(viewModel.answerText.isEmpty ? "?" : viewModel.answerText)
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundStyle(viewModel.answerText.isEmpty ? .gray : .primary)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            )
            .accessibilityIdentifier("answerField")
    }

    private var numberPad: some View {
        VStack(spacing: 12) {
            ForEach(0..<3) { row in
                HStack(spacing: 12) {
                    ForEach(1...3, id: \.self) { col in
                        let digit = row * 3 + col
                        NumberButton(label: "\(digit)") {
                            viewModel.appendDigit(digit)
                        }
                        .accessibilityIdentifier("num_\(digit)")
                    }
                }
            }
            HStack(spacing: 12) {
                NumberButton(label: "+/-", color: .gray) {
                    viewModel.toggleNegative()
                }
                .accessibilityIdentifier("num_negative")

                NumberButton(label: "0") {
                    viewModel.appendDigit(0)
                }
                .accessibilityIdentifier("num_0")

                NumberButton(label: "⌫", color: .gray) {
                    viewModel.deleteDigit()
                }
                .accessibilityIdentifier("num_delete")
            }

            Button {
                viewModel.submitAnswer()
            } label: {
                Text("GO!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            }
            .accessibilityIdentifier("submitButton")
        }
    }
}

struct NumberButton: View {
    let label: String
    var color: Color = .blue
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color.opacity(0.15))
                )
        }
        .buttonStyle(.plain)
    }
}
