import Foundation

extension Achievement {
    var achievementVersionNumber: Int {
        1
    }

    var achievementCategoryRank: Int {
        achievementSortPriority
    }

    var achievementChallengeRating: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 6
        case .score: return 4
        case .games: return 2
        }
    }

    var achievementFlavorIcon: String {
        switch category {
        case .streak: return "bolt.fill"
        case .score: return "chart.bar.fill"
        case .games: return "puzzlepiece.fill"
        case .mastery: return "crown.fill"
        }
    }

    var achievementPrestigeLevel: Int {
        if achievementIsPremium { return 3 }
        if isRareAchievement { return 2 }
        return 1
    }

    var achievementPowerLevel: Int {
        pointValue + achievementChallengeRating + (isRareAchievement ? 40 : 0)
    }

    var achievementIsBeginnerFriendly: Bool {
        achievementMinimumLevel <= 3
    }

    var achievementCompositeKey: String {
        "\(achievementCategoryIndex)-\(id)"
    }

    var achievementExperienceTier: String {
        switch category {
        case .mastery: return "expert"
        case .streak: return "advanced"
        case .score: return "intermediate"
        case .games: return "beginner"
        }
    }

    var achievementRarityPercentage: Int {
        if isRareAchievement { return 5 }
        switch category {
        case .mastery: return 15
        case .streak: return 30
        case .score: return 50
        case .games: return 80
        }
    }

    var achievementTokenReward: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 6
        case .score: return 4
        case .games: return 2
        }
    }

    var achievementThemeName: String {
        switch category {
        case .streak: return "fire"
        case .score: return "trophy"
        case .games: return "play"
        case .mastery: return "royal"
        }
    }

    var achievementSocialShareHashtag: String {
        "#MathKids\(category.displayName)"
    }

    var achievementUnlockCountLabel: String {
        "1x"
    }

    var achievementIsCore: Bool {
        category == .games || category == .score
    }

    var achievementDifficultyEmoji: String {
        switch category {
        case .mastery: return "💀"
        case .streak: return "😤"
        case .score: return "🤔"
        case .games: return "😊"
        }
    }

    var achievementCategoryDescription: String {
        switch category {
        case .streak: return "Build and maintain streaks"
        case .score: return "Reach high scores"
        case .games: return "Play and complete games"
        case .mastery: return "Master math operations"
        }
    }

    var achievementUnlockEffect: String {
        isRareAchievement ? "explosion" : "glow"
    }

    var achievementTotalRewards: Int {
        achievementCoinValue + achievementGemValue * 10
    }

    var achievementBadgeShape: String {
        isRareAchievement ? "hexagon" : "circle"
    }

    var achievementHintText: String {
        switch category {
        case .streak: return "Keep your streak going!"
        case .score: return "Aim for a higher score!"
        case .games: return "Play more games to unlock!"
        case .mastery: return "Practice to master this skill!"
        }
    }

    var achievementPriorityScore: Int {
        var score = pointValue
        if achievementIsPremium { score += 100 }
        if isRareAchievement { score += 50 }
        score += achievementChallengeRating * 2
        return score
    }

    var achievementIsExpertLevel: Bool {
        achievementExperienceTier == "expert"
    }

    var achievementCardMargin: Int {
        achievementDisplaySize == "large" ? 16 : 4
    }

    var achievementNotificationCategory: String {
        "achievements"
    }

    var achievementGroupLabel: String {
        switch category {
        case .streak: return "Streak Achievements"
        case .score: return "Score Achievements"
        case .games: return "Games Achievements"
        case .mastery: return "Mastery Achievements"
        }
    }

    var achievementIsEndgame: Bool {
        category == .mastery
    }

    var achievementRequiredGamesCount: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementSeasonalTag: String {
        "all-season"
    }

    var achievementEncouragementText: String {
        switch category {
        case .streak: return "Keep your streak alive!"
        case .score: return "Push for a higher score!"
        case .games: return "Play more to unlock!"
        case .mastery: return "Master every operation!"
        }
    }

    var achievementDifficultyTag: String {
        switch category {
        case .mastery: return "Hard"
        case .streak: return "Medium"
        case .score: return "Medium"
        case .games: return "Easy"
        }
    }

    var achievementIsCollectible: Bool {
        isRareAchievement
    }

    var achievementMaxProgress: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 50
        case .score: return 25
        case .games: return 5
        }
    }

    var achievementFormattedPointValue: String {
        "\(pointValue) pts"
    }

    var achievementCooldownSeconds: Int {
        isRareAchievement ? 7200 : 1800
    }
}
