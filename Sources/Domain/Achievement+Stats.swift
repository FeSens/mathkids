import Foundation

extension Achievement {
    var achievementStatsSummary: String {
        "\(category.displayName): \(pointValue) pts"
    }

    var achievementCardRadius: Double {
        isRareAchievement ? 16 : 8
    }

    var achievementIsDailyQuest: Bool {
        category == .streak
    }

    var achievementBadgeTag: String {
        "\(emoji) \(title)"
    }

    var achievementEffortDescription: String {
        switch category {
        case .mastery: return "Requires significant practice"
        case .streak: return "Requires daily consistency"
        case .score: return "Requires high performance"
        case .games: return "Requires playing games"
        }
    }

    var achievementDifficultyRating: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 3
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementGradientStartColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementIsFinishable: Bool {
        true
    }

    var achievementCardTitleFont: String {
        isRareAchievement ? "bold" : "regular"
    }

    var achievementPointsSummary: String {
        "\(pointValue) points"
    }

    var achievementUnlockThreshold: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementCardSubtitleStyle: String {
        isRareAchievement ? "italic" : "regular"
    }

    var achievementIsPremiumTier: Bool {
        category == .mastery
    }

    var achievementBarFillColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementCardTitleAlignment: String {
        isRareAchievement ? "center" : "leading"
    }

    var achievementCardBackgroundStyle: String {
        isRareAchievement ? "gradient" : "solid"
    }

    var achievementMinPlayerLevel: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardBadgePosition: String {
        isRareAchievement ? "topRight" : "topLeft"
    }

    var achievementIsMonitorable: Bool {
        category == .mastery || category == .streak
    }

    var achievementRewardDescriptionText: String {
        "Earn \(pointValue) points"
    }

    var achievementSectionHeaderText: String {
        "\(category.displayName) Achievements"
    }

    var achievementCardDividerColor: String {
        isRareAchievement ? "gold" : "gray"
    }

    var achievementIsMultiStep: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardContentSpacing: Double {
        isRareAchievement ? 12 : 8
    }

    var achievementGoalDescription: String {
        switch category {
        case .mastery: return "Master all operations"
        case .streak: return "Maintain a daily streak"
        case .score: return "Achieve a high score"
        case .games: return "Complete games"
        }
    }

    var achievementCardIconPosition: String {
        isRareAchievement ? "center" : "leading"
    }

    var achievementStreakRequirementText: String {
        category == .streak ? "Play every day to maintain your streak" : "No streak required"
    }

    var achievementCardOpacityLevel: Double {
        isRareAchievement ? 1.0 : 0.85
    }

    var achievementIsNewbieFriendly: Bool {
        category == .games
    }

    var achievementCelebrationText: String {
        "\(emoji) Congratulations! You earned \(title)!"
    }

    var achievementCardLabelStyle: String {
        isRareAchievement ? "highlighted" : "default"
    }

    var achievementRequiredAccuracyPercent: Int {
        switch category {
        case .mastery: return 90
        case .streak: return 0
        case .score: return 80
        case .games: return 0
        }
    }

    var achievementCardHighlightColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementIsSkillBased: Bool {
        category == .mastery || category == .score
    }

    var achievementProgressSummaryText: String {
        "\(category.displayName) progress"
    }

    var achievementCardActionLabel: String {
        switch category {
        case .mastery: return "View Progress"
        case .streak: return "Check Streak"
        case .score: return "View Score"
        case .games: return "Play Now"
        }
    }

    var achievementTargetScore: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 0
        case .score: return 50
        case .games: return 0
        }
    }

    var achievementCardStatusIcon: String {
        isRareAchievement ? "star.fill" : "circle"
    }

    var achievementIsCumulative: Bool {
        category == .mastery || category == .games
    }

    var achievementUnlockHint: String {
        switch category {
        case .mastery: return "Practice all operations to master them"
        case .streak: return "Play every day to build your streak"
        case .score: return "Try to beat your high score"
        case .games: return "Keep playing to unlock"
        }
    }

    var achievementRewardBadgeStyle: String {
        isRareAchievement ? "gold" : "silver"
    }

    var achievementGamesRequired: Int {
        switch category {
        case .mastery: return 50
        case .streak: return 0
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementCardEmojiBackground: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementIsTimeSensitive: Bool {
        category == .streak
    }

    var achievementCardFooterIcon: String {
        switch category {
        case .mastery: return "graduationcap"
        case .streak: return "flame"
        case .score: return "chart.bar"
        case .games: return "gamecontroller"
        }
    }

    var achievementCardGlowColor: String {
        isRareAchievement ? "gold" : "clear"
    }

    var achievementMasteryPercentage: Int {
        category == .mastery ? 100 : 0
    }

    var achievementCardRibbonColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "red"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementIsExclusiveReward: Bool {
        category == .mastery
    }

    var achievementOneLinerSummary: String {
        "\(title) — \(category.displayName)"
    }
}
