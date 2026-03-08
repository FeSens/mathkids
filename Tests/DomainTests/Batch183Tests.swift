import Testing
@testable import MathKids

@Suite("Batch 183 Tests")
struct Batch183Tests {

    // MARK: - logic-994: achievementIsScore

    @Test
    func achievementIsScore_score100() {
        let a = Achievement.all.first { $0.id == "score_100" }!
        #expect(a.achievementIsScore == true)
    }

    @Test
    func achievementIsScore_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsScore == false)
    }

    // MARK: - logic-995: achievementIsGames

    @Test
    func achievementIsGames_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsGames == true)
    }

    @Test
    func achievementIsGames_streak5() {
        let a = Achievement.all.first { $0.id == "streak_5" }!
        #expect(a.achievementIsGames == false)
    }

    // MARK: - logic-996: achievementBadgeText

    @Test
    func achievementBadgeText_streak() {
        let a = Achievement.all.first { $0.category == .streak }!
        #expect(a.achievementBadgeText == "S")
    }

    @Test
    func achievementBadgeText_games() {
        let a = Achievement.all.first { $0.category == .games }!
        #expect(a.achievementBadgeText == "G")
    }

    // MARK: - logic-997: achievementFullLabel

    @Test
    func achievementFullLabel_containsTitle() {
        let a = Achievement.all[0]
        #expect(a.achievementFullLabel.contains(a.title))
    }

    @Test
    func achievementFullLabel_containsPts() {
        let a = Achievement.all[0]
        #expect(a.achievementFullLabel.contains("pts"))
    }

    // MARK: - logic-998: achievementIsDaily

    @Test
    func achievementIsDaily_daily3() {
        let a = Achievement.all.first { $0.id == "daily_3" }!
        #expect(a.achievementIsDaily == true)
    }

    @Test
    func achievementIsDaily_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsDaily == false)
    }
}
