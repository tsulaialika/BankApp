import XCTest

final class EasyBankPage {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // Onboarding Elements
    var loginOnboardingButton: XCUIElement { app.buttons["onboarding.login"] }
    var registerOnboardingButton: XCUIElement { app.buttons["onboarding.register"] }

    // Login Elements
    var loginEmailField: XCUIElement { app.textFields["login.email"] }
    var loginPasswordField: XCUIElement { app.secureTextFields["login.password"] }
    var loginSubmitButton: XCUIElement { app.buttons["login.submit"] }
    var loginErrorMessage: XCUIElement { app.staticTexts["login.error"] }

    // Registration Elements
    var registrationEmailField: XCUIElement { app.textFields["registration.email"] }
    var registrationPasswordField: XCUIElement { app.secureTextFields["registration.password"] }
    var registrationPasswordConfirmationField: XCUIElement { app.secureTextFields["registration.repeatPassword"] }
    var registrationSubmitButton: XCUIElement { app.buttons["registration.submit"] }
    var strongPasswordCloseButton: XCUIElement { app.buttons["Close"] }

    // Home & Logout Elements
    var homeTab: XCUIElement { app.tabBars.buttons["Home"] }
    var sendMoneyButton: XCUIElement { app.buttons["home.sendMoney"] }
    var logoutButton: XCUIElement { app.buttons["home.logout"] }
    var logoutAlert: XCUIElement { app.alerts["Logging Out"] }
    var logoutConfirmationButton: XCUIElement { logoutAlert.buttons["Yes"] }
}