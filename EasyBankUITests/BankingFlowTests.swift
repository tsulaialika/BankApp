import XCTest

final class BankingFlowTests: BaseClass {

    private lazy var steps = EasyBankSteps(app: app)

    func testLoginRejectsMalformedEmailAddress() {
        steps.tapLoginOnOnboardingScreen()
            .enterLoginEmail(BankingFlowTestData.malformedEmail)
            .enterLoginPassword(BankingFlowTestData.testPassword)
            .submitLoginForm()
            .assertLoginErrorContains(
                BankingFlowTestData.malformedEmailError
            )
    }

    func testLoginRejectsUnregisteredEmailAddress() {
        let email = BankingFlowTestData.makeUniqueEmail()

        steps.tapLoginOnOnboardingScreen()
            .enterLoginEmail(email)
            .enterLoginPassword(BankingFlowTestData.testPassword)
            .submitLoginForm()
            .assertLoginErrorContains(
                BankingFlowTestData.invalidCredentialsError
            )
    }

    func testUserCanRegisterLogoutAndLoginAgain() {
        let email = BankingFlowTestData.makeUniqueEmail()
        let password = BankingFlowTestData.testPassword

        steps.tapRegisterOnOnboardingScreen()
            .enterRegistrationEmail(email)
            .enterRegistrationPassword(password)
            .enterRegistrationPasswordConfirmation(password)
            .submitRegistrationForm()
            .assertHomeScreenIsDisplayed()
            .tapLogoutButton()
            .confirmLogout()

        steps.tapLoginOnOnboardingScreen()
            .enterLoginEmail(email)
            .enterLoginPassword(password)
            .submitLoginForm()
            .assertHomeScreenIsDisplayed()
    }
}