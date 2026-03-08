import Foundation

extension Achievement {
    var achievementGlowColor: String {
        isRareAchievement ? "gold" : "none"
    }

    var achievementListPosition: String {
        progress != nil ? "top" : "bottom"
    }

    var achievementShowBadge: Bool {
        isRareAchievement
    }

    var achievementDetailLines: [String] {
        [title, category.displayName, "\(pointValue) pts"]
    }

    var achievementIsHighlightWorthy: Bool {
        achievementIsPremium || achievementIsFeatured
    }
}
