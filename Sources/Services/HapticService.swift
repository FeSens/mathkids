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
}
