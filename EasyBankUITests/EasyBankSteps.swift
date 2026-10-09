import XCTest

final class EasyBankSteps {

    private let page: EasyBankPage
    private let timeout: TimeInterval = 10

    init(app: XCUIApplication) {
        page = EasyBankPage(app: app)
    }

    // Onboarding Steps
    @discardableResult
    func tapLoginOnOnboardingScreen() -> Self {
        tap(page.loginOnboardingButton)
        return self
    }

    @discardableResult
    func tapRegisterOnOnboardingScreen() -> Self {
        tap(page.registerOnboardingButton)
        return self
    }

    // Login Steps
    @discardableResult
    func enterLoginEmail(_ email: String) -> Self {
        enterText(email, into: page.loginEmailField)
        return self
    }

    @discardableResult
    func enterLoginPassword(_ password: String) -> Self {
        enterText(password, into: page.loginPasswordField)
        return self
    }

    @discardableResult
    func submitLoginForm() -> Self {
        tap(page.loginSubmitButton)
        return self
    }

    @discardableResult
    func assertLoginErrorContains(_ expectedText: String) -> Self {
        let errorMessage = page.loginErrorMessage

        guard errorMessage.waitForExistence(timeout: timeout) else {
            XCTFail("Login error message did not appear.")
            return self
        }

        XCTAssertTrue(
            errorMessage.label.localizedCaseInsensitiveContains(expectedText),
            """
            Expected error to contain: "\(expectedText)"
            Actual error: "\(errorMessage.label)"
            """
        )

        return self
    }

    // Registration Steps
    @discardableResult
    func enterRegistrationEmail(_ email: String) -> Self {
        enterText(email, into: page.registrationEmailField)
        return self
    }

    @discardableResult
    func enterRegistrationPassword(_ password: String) -> Self {
        enterSecureText(password, into: page.registrationPasswordField)
        return self
    }

    @discardableResult
    func enterRegistrationPasswordConfirmation(_ password: String) -> Self {
        enterSecureText(
            password,
            into: page.registrationPasswordConfirmationField
        )
        return self
    }

    @discardableResult
    func submitRegistrationForm() -> Self {
        tap(page.registrationSubmitButton)
        return self
    }

    // Home & Logout Steps
    @discardableResult
    func assertHomeScreenIsDisplayed() -> Self {
        let homeTabVisible = page.homeTab.waitForExistence(timeout: timeout)
        let sendMoneyVisible = page.sendMoneyButton.waitForExistence(timeout: timeout)

        XCTAssertTrue(
            homeTabVisible || sendMoneyVisible,
            "The Home screen was not displayed."
        )

        return self
    }

    @discardableResult
    func tapLogoutButton() -> Self {
        tap(page.logoutButton)
        return self
    }

    @discardableResult
    func confirmLogout() -> Self {
        tap(page.logoutConfirmationButton)
        return self
    }

    // Private Helper Methods
    private func tap(_ element: XCUIElement) {
        guard element.waitForExistence(timeout: timeout) else {
            XCTFail("Element did not appear: \(element)")
            return
        }

        guard element.isHittable else {
            XCTFail("Element is not hittable: \(element)")
            return
        }

        element.tap()
    }

    private func enterText(_ text: String, into element: XCUIElement) {
        guard element.waitForExistence(timeout: timeout) else {
            XCTFail("Text field did not appear: \(element)")
            return
        }

        guard element.isHittable else {
            XCTFail("Text field is not hittable: \(element)")
            return
        }

        element.tap()
        element.typeText(text)
    }

    private func enterSecureText(_ text: String, into element: XCUIElement) {
        guard element.waitForExistence(timeout: timeout) else {
            XCTFail("Secure text field did not appear: \(element)")
            return
        }

        guard element.isHittable else {
            XCTFail("Secure text field is not hittable: \(element)")
            return
        }

        element.tap()

        if page.strongPasswordCloseButton.waitForExistence(timeout: 2) {
            page.strongPasswordCloseButton.tap()

            guard element.waitForExistence(timeout: timeout),
                  element.isHittable else {
                XCTFail("Secure text field is unavailable.")
                return
            }

            element.tap()
        }

        element.typeText(text)
    }
}