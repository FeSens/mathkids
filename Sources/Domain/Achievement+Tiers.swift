import Foundation

extension Achievement {
    var achievementCardCameoStyle: String {
        isRareAchievement ? "carved" : "flat"
    }

    var achievementIsStreakDependent: Bool {
        category == .streak
    }

    var achievementCardLegendText: String {
        switch category {
        case .mastery: return "Legend of Mastery"
        case .streak: return "Legend of Dedication"
        case .score: return "Legend of Precision"
        case .games: return "Legend of Play"
        }
    }

    var achievementCardEnamelingStyle: String {
        isRareAchievement ? "cloisonne" : "basic"
    }

    var achievementTargetGamesPerWeek: Int {
        switch category {
        case .mastery: return 14
        case .streak: return 7
        case .score: return 5
        case .games: return 3
        }
    }

    var achievementCardMarquetryStyle: String {
        isRareAchievement ? "elaborate" : "none"
    }

    var achievementIsScoreDependent: Bool {
        category == .score
    }

    var achievementCardChronicleText: String {
        switch category {
        case .mastery: return "Chronicle of the Master"
        case .streak: return "Chronicle of Perseverance"
        case .score: return "Chronicle of Excellence"
        case .games: return "Chronicle of the Beginner"
        }
    }

    var achievementCardLacquerStyle: String {
        isRareAchievement ? "glossy" : "satin"
    }

    var achievementRequiredCorrectAnswers: Int {
        switch category {
        case .mastery: return 500
        case .streak: return 50
        case .score: return 100
        case .games: return 5
        }
    }

    var achievementCardRepoussStyle: String {
        isRareAchievement ? "raised" : "flat"
    }

    var achievementIsMasteryDependent: Bool {
        category == .mastery
    }

    var achievementCardEpitaphText: String {
        switch category {
        case .mastery: return "Here lies mediocrity"
        case .streak: return "Never missed a day"
        case .score: return "Precision perfected"
        case .games: return "The journey begins"
        }
    }

    var achievementCardPatinaStyle: String {
        isRareAchievement ? "verdigris" : "none"
    }

    var achievementMinQuestionsAnswered: Int {
        switch category {
        case .mastery: return 1000
        case .streak: return 100
        case .score: return 200
        case .games: return 10
        }
    }

    var achievementCardFinialStyle: String {
        isRareAchievement ? "ornate" : "simple"
    }

    var achievementIsGamesDependent: Bool {
        category == .games
    }

    var achievementCardSagaText: String {
        switch category {
        case .mastery: return "The Saga of Mastery"
        case .streak: return "The Saga of Endurance"
        case .score: return "The Saga of Triumph"
        case .games: return "The Saga of Discovery"
        }
    }

    var achievementCardBurnishStyle: String {
        isRareAchievement ? "polished" : "brushed"
    }

    var achievementRequiredOperationCount: Int {
        switch category {
        case .mastery: return 4
        case .streak: return 1
        case .score: return 2
        case .games: return 1
        }
    }
}
