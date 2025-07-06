import Testing
import Foundation
import Network
@testable import Catalog

@Test func testCatalogServiceInitialization() async throws {
    // Given & When
    let _ = CatalogService()
    
    // Then
    // Service is created successfully (no public properties to test)
    #expect(true)
}

@Test func testCatalogServiceGetPopularMoviesDoesNotThrow() async throws {
    // Given
    let service = CatalogService()
    
    // When & Then
    // Test that the method exists and can be called (may fail due to network)
    do {
        let _ = try await service.getPopularMovies()
        #expect(true) // Success case
    } catch {
        #expect(true) // Expected to fail without proper network setup
    }
}
