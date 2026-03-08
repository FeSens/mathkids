import Foundation

extension Achievement {
    var achievementCardAccentColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "cyan"
        case .games: return "mint"
        }
    }

    var achievementCompletionStars: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 4
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementIsChallengeable: Bool {
        category == .mastery || category == .score
    }

    var achievementCardStampText: String {
        isRareAchievement ? "RARE" : "EARNED"
    }

    var achievementProgressEmoji: String {
        switch category {
        case .mastery: return "📚"
        case .streak: return "🔥"
        case .score: return "🎯"
        case .games: return "🎮"
        }
    }

    var achievementCardShadowOpacity: Double {
        isRareAchievement ? 0.4 : 0.1
    }

    var achievementRequiredDays: Int {
        switch category {
        case .mastery: return 30
        case .streak: return 7
        case .score: return 0
        case .games: return 0
        }
    }

    var achievementCardHeaderStyle: String {
        isRareAchievement ? "prominent" : "compact"
    }

    var achievementIsPassive: Bool {
        category == .games
    }

    var achievementRewardLabelText: String {
        "+\(pointValue) pts"
    }

    var achievementCardTagColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "red"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementMinGamesPlayed: Int {
        switch category {
        case .mastery: return 25
        case .streak: return 5
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardLayoutMode: String {
        isRareAchievement ? "expanded" : "compact"
    }

    var achievementIsEnduranceBased: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardSubtitleText: String {
        "\(category.displayName) challenge"
    }

    var achievementCardEmojiOffset: Double {
        isRareAchievement ? -4 : 0
    }

    var achievementStreakMultiplierValue: Double {
        category == .streak ? 1.5 : 1.0
    }

    var achievementCardBorderColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "gray"
        }
    }

    var achievementIsGoalOriented: Bool {
        category == .mastery || category == .score
    }

    var achievementCardInfoLabel: String {
        "\(category.displayName) — \(pointValue) pts"
    }

    var achievementCardTitleSize: Double {
        isRareAchievement ? 20 : 16
    }

    var achievementRewardMultiplier: Double {
        switch category {
        case .mastery: return 2.5
        case .streak: return 1.5
        case .score: return 1.2
        case .games: return 1.0
        }
    }

    var achievementCardFooterStyle: String {
        isRareAchievement ? "detailed" : "minimal"
    }

    var achievementIsDifficultyScaled: Bool {
        category == .mastery
    }

    var achievementCardDescriptionLines: Int {
        isRareAchievement ? 3 : 2
    }

    var achievementCardButtonStyle: String {
        isRareAchievement ? "filled" : "bordered"
    }

    var achievementTotalAttemptsNeeded: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 30
        case .score: return 20
        case .games: return 1
        }
    }

    var achievementCardRibbonText: String {
        isRareAchievement ? "EXCLUSIVE" : ""
    }

    var achievementIsPracticeBased: Bool {
        category == .mastery
    }

    var achievementCardCategoryBadge: String {
        "\(category.emoji) \(category.displayName)"
    }

    var achievementCardStatusText: String {
        isRareAchievement ? "Rare Achievement" : "Achievement"
    }

    var achievementDaysToComplete: Int {
        switch category {
        case .mastery: return 60
        case .streak: return 14
        case .score: return 7
        case .games: return 1
        }
    }

    var achievementCardProgressStyle: String {
        switch category {
        case .mastery: return "circular"
        case .streak: return "linear"
        case .score: return "linear"
        case .games: return "step"
        }
    }

    var achievementIsSpeedBased: Bool {
        category == .score
    }

    var achievementCardRewardIcon: String {
        switch category {
        case .mastery: return "crown"
        case .streak: return "flame.fill"
        case .score: return "trophy"
        case .games: return "star"
        }
    }

    var achievementCardShineEffect: Bool {
        isRareAchievement
    }

    var achievementScoreThreshold: Int {
        switch category {
        case .mastery: return 0
        case .streak: return 0
        case .score: return 80
        case .games: return 0
        }
    }

    var achievementCardEmojiRotation: Double {
        isRareAchievement ? 15 : 0
    }

    var achievementIsConsistencyBased: Bool {
        category == .streak
    }

    var achievementCardPointsLabel: String {
        "\(pointValue) Points"
    }

    var achievementCardSeparatorColor: String {
        isRareAchievement ? "gold" : "lightGray"
    }

    var achievementWeightedScore: Int {
        pointValue * achievementCategoryWeight
    }

    var achievementCardChevronStyle: String {
        isRareAchievement ? "filled" : "outlined"
    }

    var achievementIsEffortIntensive: Bool {
        category == .mastery
    }

    var achievementCardCompletionIcon: String {
        switch category {
        case .mastery: return "checkmark.seal.fill"
        case .streak: return "flame.circle.fill"
        case .score: return "star.circle.fill"
        case .games: return "checkmark.circle"
        }
    }

    var achievementCardWaveEffect: Bool {
        isRareAchievement
    }

    var achievementAccuracyThreshold: Int {
        switch category {
        case .mastery: return 95
        case .streak: return 0
        case .score: return 85
        case .games: return 0
        }
    }

    var achievementCardMedalColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "silver"
        case .score: return "bronze"
        case .games: return "copper"
        }
    }

    var achievementIsVolumeBased: Bool {
        category == .games
    }

    var achievementCardEmojiLabel: String {
        "\(emoji) \(category.displayName)"
    }
}
