import Testing
@testable import MathKids

@Suite("Batch 135 Tests")
struct Batch135Tests {

    // MARK: - logic-754: maxStreakBonus

    @Test
    func maxStreakBonus_easy() {
        #expect(DifficultyLevel.easy.maxStreakBonus == 10)
    }

    @Test
    func maxStreakBonus_hard() {
        #expect(DifficultyLevel.hard.maxStreakBonus == 30)
    }

    // MARK: - logic-755: difficultyStars

    @Test
    func difficultyStars_easy() {
        #expect(DifficultyLevel.easy.difficultyStars == 1)
    }

    @Test
    func difficultyStars_medium() {
        #expect(DifficultyLevel.medium.difficultyStars == 2)
    }

    @Test
    func difficultyStars_hard() {
        #expect(DifficultyLevel.hard.difficultyStars == 3)
    }

    // MARK: - logic-756: problemComplexity

    @Test
    func problemComplexity_easy() {
        #expect(DifficultyLevel.easy.problemComplexity == "simple")
    }

    @Test
    func problemComplexity_hard() {
        #expect(DifficultyLevel.hard.problemComplexity == "complex")
    }

    // MARK: - logic-757: estimatedSessionMinutes

    @Test
    func estimatedSessionMinutes_easy() {
        #expect(DifficultyLevel.easy.estimatedSessionMinutes == 1)
    }

    // MARK: - logic-758: recommendedAge

    @Test
    func recommendedAge_easy() {
        #expect(DifficultyLevel.easy.recommendedAge == "5-7")
    }

    @Test
    func recommendedAge_medium() {
        #expect(DifficultyLevel.medium.recommendedAge == "7-9")
    }

    @Test
    func recommendedAge_hard() {
        #expect(DifficultyLevel.hard.recommendedAge == "9-12")
    }
}
