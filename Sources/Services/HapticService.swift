import UIKit

@MainActor
struct HapticService {
    private static let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private static let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    private static let notification = UINotificationFeedbackGenerator()

    static func buttonTap() {
        lightImpact.impactOccurred()
    }

    static func correctAnswer() {
        notification.notificationOccurred(.success)
    }

    static func wrongAnswer() {
        notification.notificationOccurred(.error)
    }

    static func streakMilestone() {
        heavyImpact.impactOccurred()
    }
}
