import Foundation

extension Achievement {
    var achievementCardWingStyle: String {
        isRareAchievement ? "spread" : "folded"
    }

    var achievementIsCompetitiveBased: Bool {
        category == .score
    }

    var achievementCardFlameEffect: Bool {
        isRareAchievement
    }

    var achievementDailyTarget: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 1
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardBannerColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "red"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementCardPedestalStyle: String {
        isRareAchievement ? "marble" : "wood"
    }

    var achievementIsFrequencyBased: Bool {
        category == .streak || category == .games
    }

    var achievementCardLaurelStyle: String {
        isRareAchievement ? "golden" : "none"
    }

    var achievementMinRoundsPlayed: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementCardPlateColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "copper"
        case .score: return "bronze"
        case .games: return "silver"
        }
    }

    var achievementCardEtchingStyle: String {
        isRareAchievement ? "detailed" : "simple"
    }

    var achievementIsProgressionBased: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardInscriptionText: String {
        switch category {
        case .mastery: return "Knowledge is power"
        case .streak: return "Consistency wins"
        case .score: return "Precision matters"
        case .games: return "Every game counts"
        }
    }

    var achievementCardGemColor: String {
        switch category {
        case .mastery: return "ruby"
        case .streak: return "amber"
        case .score: return "sapphire"
        case .games: return "emerald"
        }
    }

    var achievementIsAchievementLocked: Bool {
        category == .mastery
    }

    var achievementCardScrollStyle: String {
        isRareAchievement ? "ornate" : "plain"
    }

    var achievementIsOutcomeBased: Bool {
        category == .score || category == .mastery
    }

    var achievementCardVaultLabel: String {
        switch category {
        case .mastery: return "Master Vault"
        case .streak: return "Streak Vault"
        case .score: return "Score Vault"
        case .games: return "Starter Vault"
        }
    }

    var achievementCardFiligreeStyle: String {
        isRareAchievement ? "intricate" : "minimal"
    }

    var achievementRequiredPerfectGames: Int {
        switch category {
        case .mastery: return 20
        case .streak: return 5
        case .score: return 10
        case .games: return 0
        }
    }

    var achievementCardCrestStyle: String {
        isRareAchievement ? "royal" : "basic"
    }

    var achievementIsMilestoneDriven: Bool {
        category == .mastery || category == .games
    }

    var achievementCardEngravedText: String {
        switch category {
        case .mastery: return "Excellence achieved"
        case .streak: return "Dedication proven"
        case .score: return "Precision demonstrated"
        case .games: return "Journey begun"
        }
    }

    var achievementCardPatternStyle: String {
        isRareAchievement ? "damask" : "solid"
    }

    var achievementMinAccuracyRate: Int {
        switch category {
        case .mastery: return 90
        case .streak: return 0
        case .score: return 80
        case .games: return 0
        }
    }

    var achievementCardShieldStyle: String {
        isRareAchievement ? "heraldic" : "plain"
    }

    var achievementIsQualityBased: Bool {
        category == .score || category == .mastery
    }

    var achievementCardMottoBanner: String {
        switch category {
        case .mastery: return "Per aspera ad astra"
        case .streak: return "Day by day"
        case .score: return "Aim higher"
        case .games: return "Play on"
        }
    }

    var achievementCardAuraStyle: String {
        isRareAchievement ? "radiant" : "none"
    }

    var achievementStreakDaysRequired: Int {
        switch category {
        case .mastery: return 0
        case .streak: return 7
        case .score: return 0
        case .games: return 0
        }
    }

    var achievementCardEmbossStyle: String {
        isRareAchievement ? "deep" : "flat"
    }

    var achievementIsQuantityBased: Bool {
        category == .games || category == .mastery
    }

    var achievementCardHeraldryText: String {
        switch category {
        case .mastery: return "Order of Masters"
        case .streak: return "Order of Persistence"
        case .score: return "Order of Precision"
        case .games: return "Order of Players"
        }
    }

    var achievementCardFoilStyle: String {
        isRareAchievement ? "holographic" : "matte"
    }

    var achievementTotalPointsRequired: Int {
        switch category {
        case .mastery: return 500
        case .streak: return 200
        case .score: return 300
        case .games: return 50
        }
    }
}
