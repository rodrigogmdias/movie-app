import Testing
import Foundation
@testable import Catalog

@Test func testCatalogEndpointPopularScheme() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let scheme = endpoint.scheme
    
    // Then
    #expect(scheme == "https")
}

@Test func testCatalogEndpointPopularHost() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let host = endpoint.host
    
    // Then
    #expect(host == "api.themoviedb.org")
}

@Test func testCatalogEndpointPopularPath() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let path = endpoint.path
    
    // Then
    #expect(path == "/3/movie/popular")
}

@Test func testCatalogEndpointPopularMethod() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let method = endpoint.method
    
    // Then
    #expect(method == .get)
}

@Test func testCatalogEndpointPopularQueryParams() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let queryParams = endpoint.queryParams
    
    // Then
    #expect(queryParams != nil)
    #expect(queryParams?["api_key"] == "052969f23bc6cb32135ec7d21bdea2ed")
}

@Test func testCatalogEndpointPopularHeader() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let header = endpoint.header
    
    // Then
    #expect(header == nil)
}

@Test func testCatalogEndpointPopularAuthToken() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let authToken = endpoint.authToken
    
    // Then
    #expect(authToken == nil)
}

@Test func testCatalogEndpointPopularBody() async throws {
    // Given
    let endpoint = CatalogEndpoint.popular
    
    // When
    let body = endpoint.body
    
    // Then
    #expect(body == nil)
}
