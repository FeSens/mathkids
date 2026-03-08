import Foundation

extension Achievement {
    var achievementCardPulseEffect: Bool {
        isRareAchievement
    }

    var achievementRequiredRounds: Int {
        switch category {
        case .mastery: return 50
        case .streak: return 10
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardCrownColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "silver"
        case .score: return "bronze"
        case .games: return "gray"
        }
    }

    var achievementIsPerformanceBased: Bool {
        category == .score || category == .mastery
    }

    var achievementCardRankLabel: String {
        switch category {
        case .mastery: return "S Rank"
        case .streak: return "A Rank"
        case .score: return "B Rank"
        case .games: return "C Rank"
        }
    }

    var achievementCardTrophyStyle: String {
        isRareAchievement ? "large" : "small"
    }

    var achievementExperienceMultiplier: Double {
        switch category {
        case .mastery: return 3.0
        case .streak: return 2.0
        case .score: return 1.5
        case .games: return 1.0
        }
    }

    var achievementCardFrameStyle: String {
        isRareAchievement ? "ornate" : "simple"
    }

    var achievementIsPrecisionBased: Bool {
        category == .score
    }

    var achievementCardTierBadge: String {
        switch category {
        case .mastery: return "Elite"
        case .streak: return "Dedicated"
        case .score: return "Skilled"
        case .games: return "Starter"
        }
    }

    var achievementCardGlowRadius: Double {
        isRareAchievement ? 12 : 0
    }

    var achievementSessionTarget: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 1
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardEmblemStyle: String {
        isRareAchievement ? "decorative" : "plain"
    }

    var achievementIsDedicationBased: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardLevelTag: String {
        switch category {
        case .mastery: return "Level 5"
        case .streak: return "Level 4"
        case .score: return "Level 3"
        case .games: return "Level 1"
        }
    }

    var achievementCardSparkEffect: Bool {
        isRareAchievement
    }

    var achievementMinimumStreakDays: Int {
        category == .streak ? 5 : 0
    }

    var achievementCardSealStyle: String {
        isRareAchievement ? "wax" : "none"
    }

    var achievementIsKnowledgeBased: Bool {
        category == .mastery
    }

    var achievementCardUnlockLabel: String {
        switch category {
        case .mastery: return "Master to unlock"
        case .streak: return "Streak to unlock"
        case .score: return "Score to unlock"
        case .games: return "Play to unlock"
        }
    }

    var achievementCardConfettiColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementAverageSessions: Int {
        switch category {
        case .mastery: return 30
        case .streak: return 10
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardAchievementType: String {
        switch category {
        case .mastery: return "Mastery"
        case .streak: return "Streak"
        case .score: return "Score"
        case .games: return "Participation"
        }
    }

    var achievementIsGrindBased: Bool {
        category == .mastery || category == .games
    }

    var achievementCardStarCount: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 4
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardRibbonStyle: String {
        isRareAchievement ? "banner" : "tag"
    }

    var achievementEstimatedMinutes: Int {
        switch category {
        case .mastery: return 600
        case .streak: return 150
        case .score: return 60
        case .games: return 5
        }
    }

    var achievementCardBadgeShape: String {
        isRareAchievement ? "hexagon" : "circle"
    }

    var achievementIsEngagementBased: Bool {
        category == .streak || category == .games
    }

    var achievementCardProgressText: String {
        "\(category.displayName) in progress"
    }

    var achievementCardBorderGradient: String {
        switch category {
        case .mastery: return "gold-purple"
        case .streak: return "red-orange"
        case .score: return "blue-cyan"
        case .games: return "green-teal"
        }
    }

    var achievementWeeklyGoalCount: Int {
        switch category {
        case .mastery: return 7
        case .streak: return 7
        case .score: return 3
        case .games: return 5
        }
    }

    var achievementCardBadgeFont: String {
        isRareAchievement ? "bold" : "medium"
    }

    var achievementIsHabitForming: Bool {
        category == .streak
    }

    var achievementCardXpLabel: String {
        "\(achievementXpValue) XP"
    }
}
