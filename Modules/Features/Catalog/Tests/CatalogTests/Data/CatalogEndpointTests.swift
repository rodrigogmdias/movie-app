import Foundation
import Testing

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
    #expect(queryParams?["language"] == "pt-BR")
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

@Test func testCatalogEndpointTopRatedScheme() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let scheme = endpoint.scheme

    // Then
    #expect(scheme == "https")
}

@Test func testCatalogEndpointTopRatedHost() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let host = endpoint.host

    // Then
    #expect(host == "api.themoviedb.org")
}

@Test func testCatalogEndpointTopRatedPath() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let path = endpoint.path

    // Then
    #expect(path == "/3/movie/top_rated")
}

@Test func testCatalogEndpointTopRatedMethod() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let method = endpoint.method

    // Then
    #expect(method == .get)
}

@Test func testCatalogEndpointTopRatedQueryParams() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let queryParams = endpoint.queryParams

    // Then
    #expect(queryParams != nil)
    #expect(queryParams?["api_key"] == "052969f23bc6cb32135ec7d21bdea2ed")
    #expect(queryParams?["language"] == "pt-BR")
}

@Test func testCatalogEndpointTopRatedHeader() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let header = endpoint.header

    // Then
    #expect(header == nil)
}

@Test func testCatalogEndpointTopRatedAuthToken() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let authToken = endpoint.authToken

    // Then
    #expect(authToken == nil)
}

@Test func testCatalogEndpointTopRatedBody() async throws {
    // Given
    let endpoint = CatalogEndpoint.topRated

    // When
    let body = endpoint.body

    // Then
    #expect(body == nil)
}
