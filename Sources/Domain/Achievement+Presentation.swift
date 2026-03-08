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

    var achievementOpacityValue: Double {
        progress != nil ? 1.0 : 0.5
    }

    var achievementScaleEffect: Double {
        switch achievementDisplaySize {
        case "large": return 1.2
        case "medium": return 1.0
        default: return 0.8
        }
    }

    var achievementCornerRadius: Int {
        switch achievementDisplaySize {
        case "large": return 16
        case "medium": return 12
        default: return 8
        }
    }

    var achievementFontSize: Int {
        switch achievementDisplaySize {
        case "large": return 20
        case "medium": return 17
        default: return 14
        }
    }

    var achievementShadowRadius: Int {
        isRareAchievement ? 8 : 2
    }

    var achievementPaddingValue: Int {
        switch achievementDisplaySize {
        case "large": return 16
        case "medium": return 12
        default: return 8
        }
    }

    var achievementBorderWidth: Int {
        isRareAchievement ? 3 : 1
    }

    var achievementEmojiSize: Int {
        switch achievementDisplaySize {
        case "large": return 40
        case "medium": return 32
        default: return 24
        }
    }

    var achievementRowHeight: Int {
        switch achievementDisplaySize {
        case "large": return 80
        case "medium": return 60
        default: return 44
        }
    }

    var achievementBadgeLabel: String {
        isRareAchievement ? "RARE" : ""
    }
}
