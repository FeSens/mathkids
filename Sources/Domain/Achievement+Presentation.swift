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

    var achievementCardWidth: String {
        achievementGridColumns == 1 ? "full" : "compact"
    }

    var achievementProgressBarColor: String {
        achievementCardColor
    }

    var achievementSpacingValue: Int {
        switch achievementDisplaySize {
        case "large": return 12
        case "medium": return 8
        default: return 4
        }
    }

    var achievementTitleLineLimit: Int {
        achievementDisplaySize == "large" ? 2 : 1
    }

    var achievementDescriptionVisible: Bool {
        achievementDisplaySize != "small"
    }

    var achievementAnimationDuration: Double {
        achievementCelebrationType == "fireworks" ? 2.0 : 1.0
    }

    var achievementTransitionStyle: String {
        isRareAchievement ? "slide" : "fade"
    }

    var achievementIconOffset: Int {
        achievementDisplaySize == "large" ? -8 : 0
    }

    var achievementHasShimmerEffect: Bool {
        achievementIsPremium
    }

    var achievementLayoutMode: String {
        achievementDisplaySize == "large" ? "horizontal" : "vertical"
    }

    var achievementHapticIntensity: String {
        isRareAchievement ? "heavy" : "light"
    }

    var achievementNotificationPriority: String {
        achievementIsPremium ? "high" : "normal"
    }

    var achievementShowParticles: Bool {
        achievementIsEpic
    }

    var achievementToastDuration: Int {
        isRareAchievement ? 5 : 3
    }

    var achievementBackgroundPattern: String {
        switch category {
        case .streak: return "flames"
        case .score: return "stars"
        case .games: return "dots"
        case .mastery: return "crowns"
        }
    }

    var achievementProgressRingColor: String {
        achievementCardColor
    }

    var achievementCardElevation: Int {
        isRareAchievement ? 3 : 1
    }

    var achievementRibbonColor: String {
        switch achievementRankLabel {
        case "Platinum": return "purple"
        case "Gold": return "gold"
        case "Silver": return "silver"
        default: return "brown"
        }
    }

    var achievementShowGlowRing: Bool {
        achievementIsHighlightWorthy
    }

    var achievementTextColor: String {
        progress != nil ? "primary" : "gray"
    }

    var achievementSubtitleFontSize: Int {
        switch achievementDisplaySize {
        case "large": return 16
        case "medium": return 13
        default: return 11
        }
    }

    var achievementProgressTextVisible: Bool {
        progress != nil
    }

    var achievementCardAspectRatio: String {
        achievementDisplaySize == "large" ? "wide" : "square"
    }

    var achievementTapEffect: String {
        isRareAchievement ? "bounce" : "highlight"
    }

    var achievementStackingOrder: Int {
        achievementIsPremium ? 10 : 1
    }
}
