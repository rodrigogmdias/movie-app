import Testing
import Foundation
@testable import Session

@Suite(.serialized) // Força os testes a executarem sequencialmente
struct SessionManagerTests {
    
    @Test func testSharedInstance() throws {
        // Given & When
        let instance1 = SessionManager.shared
        let instance2 = SessionManager.shared
        
        // Then
        #expect(instance1 === instance2, "SessionManager should be a singleton")
    }
    
    @Test func testSetAndGetToken() throws {
        // Given
        let sessionManager = SessionManager.shared
        let testToken = "test-token-123"
        
        // When
        sessionManager.setSessionToken(testToken)
        
        // Then
        Thread.sleep(forTimeInterval: 0.2)
        let result = sessionManager.sessionToken
        #expect(result == testToken, "Should store and retrieve token correctly")
        
        // Cleanup
        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }
    
    @Test func testClearToken() throws {
        // Given
        let sessionManager = SessionManager.shared
        sessionManager.setSessionToken("test-token-to-clear")
        Thread.sleep(forTimeInterval: 0.2)
        
        // When
        sessionManager.clearSessionToken()
        
        // Then
        Thread.sleep(forTimeInterval: 0.2)
        let result = sessionManager.sessionToken
        #expect(result == nil, "Should clear token")
    }
    
    @Test func testHasValidSessionWithValidToken() throws {
        // Given
        let sessionManager = SessionManager.shared
        let validToken = "valid-token-456"
        
        // When
        sessionManager.setSessionToken(validToken)
        
        // Then
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.hasValidSession == true, "Should have valid session with non-empty token")
        
        // Cleanup
        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }
    
    @Test func testHasValidSessionWithEmptyToken() throws {
        // Given
        let sessionManager = SessionManager.shared
        
        // When
        sessionManager.setSessionToken("")
        
        // Then
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.hasValidSession == false, "Should not have valid session with empty token")
    }
    
    @Test func testHasValidSessionWithNilToken() throws {
        // Given
        let sessionManager = SessionManager.shared
        
        // When
        sessionManager.setSessionToken(nil)
        
        // Then
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.hasValidSession == false, "Should not have valid session with nil token")
    }
    
    @Test func testTokenReplacement() throws {
        // Given
        let sessionManager = SessionManager.shared
        let firstToken = "first-token-789"
        let secondToken = "second-token-abc"
        
        // When & Then
        sessionManager.setSessionToken(firstToken)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == firstToken, "Should store first token")
        
        sessionManager.setSessionToken(secondToken)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == secondToken, "Should replace with second token")
        
        // Cleanup
        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }
    
    @Test func testSequentialOperations() throws {
        // Given
        let sessionManager = SessionManager.shared
        
        // Test sequence: set -> verify -> clear -> verify -> set again -> verify
        let token1 = "sequence-token-1"
        let token2 = "sequence-token-2"
        
        // Step 1: Set first token
        sessionManager.setSessionToken(token1)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == token1, "Should store first token")
        #expect(sessionManager.hasValidSession == true, "Should have valid session")
        
        // Step 2: Clear token
        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == nil, "Should clear token")
        #expect(sessionManager.hasValidSession == false, "Should not have valid session")
        
        // Step 3: Set second token
        sessionManager.setSessionToken(token2)
        Thread.sleep(forTimeInterval: 0.2)
        #expect(sessionManager.sessionToken == token2, "Should store second token")
        #expect(sessionManager.hasValidSession == true, "Should have valid session again")
        
        // Final cleanup
        sessionManager.clearSessionToken()
        Thread.sleep(forTimeInterval: 0.1)
    }
}
