import XCTest

class BaseClass: XCTestCase {

    private(set) var app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("UI-Testing")
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }

    func relaunchApp() {
        app.terminate()
        app.launch()
    }
}