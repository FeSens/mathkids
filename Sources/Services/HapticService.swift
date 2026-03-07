import UIKit

@MainActor
struct HapticService {
    private static let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private static let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    private static let notification = UINotificationFeedbackGenerator()

    static func buttonTap() {
        guard SettingsManager.shared.hapticsEnabled else { return }
        lightImpact.impactOccurred()
    }

    static func correctAnswer() {
        guard SettingsManager.shared.hapticsEnabled else { return }
        notification.notificationOccurred(.success)
    }

    static func wrongAnswer() {
        guard SettingsManager.shared.hapticsEnabled else { return }
        notification.notificationOccurred(.error)
    }

    static func streakMilestone() {
        guard SettingsManager.shared.hapticsEnabled else { return }
        heavyImpact.impactOccurred()
    }

    private static let mediumImpact = UIImpactFeedbackGenerator(style: .medium)

    static func streakPattern(streak: Int) {
        guard SettingsManager.shared.hapticsEnabled else { return }
        if streak >= 10 {
            heavyImpact.impactOccurred(intensity: 1.0)
        } else if streak >= 5 {
            mediumImpact.impactOccurred(intensity: 0.8)
        } else if streak >= 3 {
            lightImpact.impactOccurred(intensity: 0.6)
        }
    }
}
