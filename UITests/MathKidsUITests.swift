import XCTest

@MainActor
final class MathKidsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["--uitesting"]
        app.launch()
    }

    func testHomeScreenShowsTitle() {
        let title = app.staticTexts["appTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
    }

    func testHomeScreenShowsPlayButton() {
        let playButton = app.buttons["playButton"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 3))
    }

    func testDifficultySelection() {
        let easyButton = app.buttons["difficulty_easy"]
        let mediumButton = app.buttons["difficulty_medium"]
        let hardButton = app.buttons["difficulty_hard"]

        XCTAssertTrue(easyButton.waitForExistence(timeout: 3))
        XCTAssertTrue(mediumButton.exists)
        XCTAssertTrue(hardButton.exists)

        mediumButton.tap()
        hardButton.tap()
        easyButton.tap()
    }

    func testStartGameAndSeeGameScreen() {
        let playButton = app.buttons["playButton"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 3))
        playButton.tap()

        // Wait for countdown to finish (~3.5s) then problem appears
        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))

        let timerLabel = app.staticTexts["timerLabel"]
        XCTAssertTrue(timerLabel.waitForExistence(timeout: 3))

        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.exists)
    }

    func testNumberPadInput() {
        app.buttons["playButton"].tap()

        // Wait for countdown overlay to disappear
        let countdown = app.otherElements["countdownOverlay"]
        if countdown.waitForExistence(timeout: 2) {
            _ = countdown.waitForNonExistence(timeout: 6)
        }

        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))

        app.buttons["num_5"].tap()
        app.buttons["num_3"].tap()

        let answerField = app.staticTexts["answerField"]
        XCTAssertTrue(answerField.exists)
        XCTAssertEqual(answerField.label, "53")

        app.buttons["num_delete"].tap()
        XCTAssertEqual(answerField.label, "5")
    }

    func testSubmitAnswer() {
        app.buttons["playButton"].tap()

        // Wait for countdown
        let countdown = app.otherElements["countdownOverlay"]
        if countdown.waitForExistence(timeout: 2) {
            _ = countdown.waitForNonExistence(timeout: 6)
        }

        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 8))

        app.buttons["num_1"].tap()
        app.buttons["submitButton"].tap()

        // After submit, answer field should reset
        let answerField = app.staticTexts["answerField"]
        XCTAssertTrue(answerField.waitForExistence(timeout: 2))
    }

    func testStatsTabExists() {
        app.tabBars.buttons["Stats"].tap()

        let streakIcon = app.images["streakIcon"]
        XCTAssertTrue(streakIcon.waitForExistence(timeout: 3))
    }

    func testPracticeMode() {
        let practiceButton = app.buttons["practiceButton"]
        XCTAssertTrue(practiceButton.waitForExistence(timeout: 3))
        practiceButton.tap()

        // No countdown in practice - problem should appear immediately
        let problemLabel = app.staticTexts["problemLabel"]
        XCTAssertTrue(problemLabel.waitForExistence(timeout: 5))

        // Done button should exist instead of timer
        let doneButton = app.buttons["doneButton"]
        XCTAssertTrue(doneButton.waitForExistence(timeout: 3))

        // Submit an answer
        app.buttons["num_1"].tap()
        app.buttons["submitButton"].tap()

        // End practice
        doneButton.tap()

        // Should see results
        let finalScore = app.staticTexts["finalScore"]
        XCTAssertTrue(finalScore.waitForExistence(timeout: 5))
    }

    func testSettingsSheet() {
        let settingsButton = app.buttons["settingsButton"]
        XCTAssertTrue(settingsButton.waitForExistence(timeout: 3))
        settingsButton.tap()

        // Settings sheet should appear
        let soundToggle = app.switches["soundToggle"]
        XCTAssertTrue(soundToggle.waitForExistence(timeout: 3))

        let hapticsToggle = app.switches["hapticsToggle"]
        XCTAssertTrue(hapticsToggle.exists)

        // Dismiss
        let doneButton = app.buttons["settingsDone"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()

        // Should be back on home
        let title = app.staticTexts["appTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
    }
}
