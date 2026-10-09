import Foundation

enum BankingFlowTestData {

    static let malformedEmail = "invalid-email"
    static let testPassword = "LikaTest12!"

    static let malformedEmailError = "badly formatted"
    static let invalidCredentialsError = "malformed or has expired"

    private static let emailPrefix = "test"
    private static let emailDomain = "easybank.test"

    static func makeUniqueEmail() -> String {
        let uniqueID = UUID().uuidString
            .prefix(8)
            .lowercased()

        return "\(emailPrefix)_\(uniqueID)@\(emailDomain)"
    }
}