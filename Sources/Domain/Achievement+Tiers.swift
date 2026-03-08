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
}
