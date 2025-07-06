import Foundation
import Testing

@testable import Session

@Suite(.serialized)
struct SessionManagerTests {

    @Test func testSharedInstance() throws {
        let instance1 = SessionManager.shared
        let instance2 = SessionManager.shared

        #expect(instance1 === instance2, "SessionManager should be a singleton")
    }

    @Test func testSetAndGetToken() throws {
        let sessionManager = SessionManager.shared
        let testToken = "test-token-123"

        sessionManager.setSessionToken(testToken)

        Thread.sleep(forTimeInterval: 0.2)
        let result = sessionManager.sessionToken
        #expect(result == testToken, "Should store and retrieve token correctly")

        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }

    @Test func testClearToken() throws {
        let sessionManager = SessionManager.shared
        sessionManager.setSessionToken("test-token-to-clear")
        Thread.sleep(forTimeInterval: 0.2)

        sessionManager.clearSessionToken()

        Thread.sleep(forTimeInterval: 0.2)
        let result = sessionManager.sessionToken
        #expect(result == nil, "Should clear token")
    }

    @Test func testHasValidSessionWithValidToken() throws {
        let sessionManager = SessionManager.shared
        let validToken = "valid-token-456"

        sessionManager.setSessionToken(validToken)

        Thread.sleep(forTimeInterval: 0.2)
        #expect(
            sessionManager.hasValidSession == true, "Should have valid session with non-empty token"
        )

        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }

    @Test func testHasValidSessionWithEmptyToken() throws {
        let sessionManager = SessionManager.shared

        sessionManager.setSessionToken("")

        Thread.sleep(forTimeInterval: 0.2)
        #expect(
            sessionManager.hasValidSession == false,
            "Should not have valid session with empty token")
    }

    @Test func testHasValidSessionWithNilToken() throws {
        let sessionManager = SessionManager.shared

        sessionManager.setSessionToken(nil)

        Thread.sleep(forTimeInterval: 0.2)
        #expect(
            sessionManager.hasValidSession == false, "Should not have valid session with nil token")
    }

    @Test func testTokenReplacement() throws {
        let sessionManager = SessionManager.shared
        let firstToken = "first-token-789"
        let secondToken = "second-token-abc"

        sessionManager.setSessionToken(firstToken)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == firstToken, "Should store first token")

        sessionManager.setSessionToken(secondToken)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == secondToken, "Should replace with second token")

        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }

    @Test func testSequentialOperations() throws {
        let sessionManager = SessionManager.shared

        let token1 = "sequence-token-1"
        let token2 = "sequence-token-2"

        sessionManager.setSessionToken(token1)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == token1, "Should store first token")
        #expect(sessionManager.hasValidSession == true, "Should have valid session")

        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == nil, "Should clear token")
        #expect(sessionManager.hasValidSession == false, "Should not have valid session")

        sessionManager.setSessionToken(token2)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == token2, "Should store second token")
        #expect(sessionManager.hasValidSession == true, "Should have valid session again")

        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }
}
