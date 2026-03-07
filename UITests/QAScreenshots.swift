import XCTest

@MainActor
final class QAScreenshots: XCTestCase {
    let app = XCUIApplication()
    let screenshotDir = "/Users/felipebonetto/Code/mathkids/screenshots"

    override func setUp() {
        continueAfterFailure = true
        app.launchArguments += ["--uitesting"]
        app.launch()
    }

    // MARK: - QA-001: Home screen and difficulty selection

    func test_QA001_HomeScreen() {
        try? FileManager.default.createDirectory(
            atPath: screenshotDir,
            withIntermediateDirectories: true
        )

        // Step 1: Home screen visible
        let title = app.staticTexts["appTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 5))
        Thread.sleep(forTimeInterval: 1)
        saveScreenshot("qa-001-step-01-home")

        // Step 2: Stat cards visible
        let streakCard = app.otherElements["dailyStreakCard"]
        let solvedCard = app.otherElements["totalSolvedCard"]
        let bestScoreCard = app.otherElements["bestScoreCard"]
        XCTAssertTrue(streakCard.exists)
        XCTAssertTrue(solvedCard.exists)
        XCTAssertTrue(bestScoreCard.exists)
        saveScreenshot("qa-001-step-02-stats-cards")

        // Step 3: Tap Medium difficulty
        let mediumButton = app.buttons["difficulty_medium"]
        XCTAssertTrue(mediumButton.waitForExistence(timeout: 3))
        mediumButton.tap()
        Thread.sleep(forTimeInterval: 0.5)
        saveScreenshot("qa-001-step-03-medium-selected")

        // Step 4: Tap Hard difficulty
        let hardButton = app.buttons["difficulty_hard"]
        hardButton.tap()
        Thread.sleep(forTimeInterval: 0.5)
        saveScreenshot("qa-001-step-04-hard-selected")

        // Reset to easy
        let easyButton = app.buttons["difficulty_easy"]
        easyButton.tap()
    }

    // MARK: - QA-002: Game play flow

    func test_QA002_GamePlay() {
        // Start game
        let playButton = app.buttons["playButton"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 5))
        playButton.tap()

        // Wait for countdown to finish
        waitForCountdown()

        // Step 1: Game screen visible
        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))
        Thread.sleep(forTimeInterval: 1)
        saveScreenshot("qa-002-step-01-game-screen")

        // Step 2: Enter an answer and submit (try a number - may or may not be correct)
        app.buttons["num_5"].tap()
        saveScreenshot("qa-002-step-02-number-entered")

        app.buttons["submitButton"].tap()
        Thread.sleep(forTimeInterval: 0.8)
        saveScreenshot("qa-002-step-03-after-submit")

        // Step 3: Enter another answer
        app.buttons["num_1"].tap()
        app.buttons["num_0"].tap()
        app.buttons["submitButton"].tap()
        Thread.sleep(forTimeInterval: 0.8)
        saveScreenshot("qa-002-step-04-second-answer")

        // Step 4: Timer bar visible
        let timerLabel = app.staticTexts["timerLabel"]
        XCTAssertTrue(timerLabel.exists)
        saveScreenshot("qa-002-step-05-timer-visible")
    }

    // MARK: - QA-003: Results screen

    func test_QA003_Results() {
        // Start a game on easy (60 seconds)
        let playButton = app.buttons["playButton"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 5))
        playButton.tap()

        waitForCountdown()

        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))

        // Answer a few questions quickly
        for _ in 0..<5 {
            app.buttons["num_1"].tap()
            app.buttons["submitButton"].tap()
            Thread.sleep(forTimeInterval: 0.3)
        }

        // Wait for game to end (max 60s for easy)
        let finalScore = app.staticTexts["finalScore"]
        let exists = finalScore.waitForExistence(timeout: 65)

        if exists {
            Thread.sleep(forTimeInterval: 1.5)
            saveScreenshot("qa-003-step-01-results-screen")

            // Verify stats
            let correctStat = app.otherElements["correctStat"]
            let accuracyStat = app.otherElements["accuracyStat"]
            let streakStat = app.otherElements["streakStat"]
            XCTAssertTrue(correctStat.exists)
            XCTAssertTrue(accuracyStat.exists)
            XCTAssertTrue(streakStat.exists)
            saveScreenshot("qa-003-step-02-stats-visible")

            // Step 3: Tap Play Again
            let playAgainButton = app.buttons["playAgainButton"]
            if playAgainButton.exists {
                playAgainButton.tap()
                Thread.sleep(forTimeInterval: 1)
                let newProblem = app.staticTexts["problemLabel"]
                XCTAssertTrue(newProblem.waitForExistence(timeout: 5))
                saveScreenshot("qa-003-step-03-play-again")
            }
        }
    }

    // MARK: - QA-004: Stats screen

    func test_QA004_StatsScreen() {
        // Navigate to Stats tab
        app.tabBars.buttons["Stats"].tap()
        Thread.sleep(forTimeInterval: 1)

        // Step 1: Stats screen visible
        let dailyStreakValue = app.staticTexts["dailyStreakValue"]
        XCTAssertTrue(dailyStreakValue.waitForExistence(timeout: 5))
        saveScreenshot("qa-004-step-01-stats-screen")

        // Step 2: Scroll down to see achievements
        app.swipeUp()
        Thread.sleep(forTimeInterval: 0.5)
        saveScreenshot("qa-004-step-02-achievements")

        // Step 3: Scroll more to see weekly activity
        app.swipeUp()
        Thread.sleep(forTimeInterval: 0.5)
        saveScreenshot("qa-004-step-03-weekly-activity")
    }

    // MARK: - QA-005: Tab navigation

    func test_QA005_TabNavigation() {
        // Step 1: Switch between tabs
        app.tabBars.buttons["Stats"].tap()
        Thread.sleep(forTimeInterval: 0.5)
        saveScreenshot("qa-005-step-01-stats-tab")

        app.tabBars.buttons["Play"].tap()
        Thread.sleep(forTimeInterval: 0.5)
        saveScreenshot("qa-005-step-02-play-tab")

        // Step 2: Full nav flow - play game, results, home
        let playButton = app.buttons["playButton"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 3))
        playButton.tap()

        waitForCountdown()

        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))
        saveScreenshot("qa-005-step-03-in-game")
    }

    // MARK: - QA-007: Soak test - multiple games

    func test_QA007_SoakMultipleGames() {
        // Play multiple quick games
        for gameNum in 1...2 {
            let playButton = app.buttons["playButton"]
            XCTAssertTrue(playButton.waitForExistence(timeout: 5))

            // Select difficulty based on game number
            if gameNum == 2 {
                app.buttons["difficulty_medium"].tap()
                Thread.sleep(forTimeInterval: 0.3)
            }

            playButton.tap()

            waitForCountdown()

            let problemLabel = app.staticTexts["problemLabel"]
            XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))

            // Answer several questions
            for _ in 0..<3 {
                app.buttons["num_2"].tap()
                app.buttons["submitButton"].tap()
                Thread.sleep(forTimeInterval: 0.3)
            }

            saveScreenshot("qa-007-game-\(gameNum)-playing")

            // Wait for game to end
            let finalScore = app.staticTexts["finalScore"]
            if finalScore.waitForExistence(timeout: 65) {
                saveScreenshot("qa-007-game-\(gameNum)-results")

                // Go home
                let homeButton = app.buttons["homeButton"]
                if homeButton.exists {
                    homeButton.tap()
                    Thread.sleep(forTimeInterval: 1)
                }
            }
        }

        // Check stats after multiple games
        saveScreenshot("qa-007-home-after-games")

        app.tabBars.buttons["Stats"].tap()
        Thread.sleep(forTimeInterval: 1)
        saveScreenshot("qa-007-stats-after-games")

        // Switch tabs rapidly
        for _ in 0..<3 {
            app.tabBars.buttons["Play"].tap()
            Thread.sleep(forTimeInterval: 0.2)
            app.tabBars.buttons["Stats"].tap()
            Thread.sleep(forTimeInterval: 0.2)
        }
        saveScreenshot("qa-007-after-rapid-tab-switch")
    }

    // MARK: - QA-006: Dark mode screenshots

    func test_QA006_DarkMode() {
        // Dark mode is set externally via simctl before running this test
        // Home screen
        let title = app.staticTexts["appTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 5))
        Thread.sleep(forTimeInterval: 1)
        saveScreenshot("qa-006-dark-home-xcui")

        // Stats screen
        app.tabBars.buttons["Stats"].tap()
        Thread.sleep(forTimeInterval: 1)
        saveScreenshot("qa-006-dark-stats")

        // Start a game
        app.tabBars.buttons["Play"].tap()
        Thread.sleep(forTimeInterval: 0.5)
        app.buttons["playButton"].tap()
        waitForCountdown()
        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))
        Thread.sleep(forTimeInterval: 1)
        saveScreenshot("qa-006-dark-game")
    }

    // MARK: - Helpers

    private func waitForCountdown() {
        let countdown = app.otherElements["countdownOverlay"]
        if countdown.waitForExistence(timeout: 2) {
            _ = countdown.waitForNonExistence(timeout: 6)
        }
        Thread.sleep(forTimeInterval: 0.5)
    }

    private func saveScreenshot(_ name: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let data = screenshot.pngRepresentation
        let url = URL(fileURLWithPath: "\(screenshotDir)/\(name).png")
        try? data.write(to: url)
    }
}
