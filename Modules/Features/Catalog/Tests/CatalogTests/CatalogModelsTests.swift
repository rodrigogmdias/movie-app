import Foundation
import Testing

@testable import Catalog

// TODO: Remove tests that only test struct initialization without meaningful assertions

@Test func testCatalogDidLoadPopularMoviesResponse() async throws {
    // Given
    let movies = [
        Movie(
            id: 1, title: "Test Movie", overview: "Test Overview", releaseDate: "2023-01-01",
            posterPath: "/test.jpg")
    ]

    // When
    let response = Catalog.DidLoadPopularMovies.Response(movies: movies)

    // Then
    #expect(response.movies.count == 1)
    #expect(response.movies.first?.title == "Test Movie")
}

@Test func testCatalogDidLoadPopularMoviesViewModelWithLoadingStatus() async throws {
    // Given
    let movies = [
        Movie(
            id: 1, title: "Test Movie", overview: "Test Overview", releaseDate: "2023-01-01",
            posterPath: "/test.jpg")
    ]

    // When
    let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: movies, status: .loading)

    // Then
    #expect(viewModel.movies.count == 1)
    #expect(viewModel.movies.first?.title == "Test Movie")
    // Note: Can't directly test status equality without custom implementation
}

@Test func testCatalogDidLoadPopularMoviesViewModelWithLoadedStatus() async throws {
    // Given
    let movies = [
        Movie(
            id: 1, title: "Test Movie", overview: "Test Overview", releaseDate: "2023-01-01",
            posterPath: "/test.jpg")
    ]

    // When
    let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: movies, status: .loaded)

    // Then
    #expect(viewModel.movies.count == 1)
    #expect(viewModel.movies.first?.title == "Test Movie")
}

@Test func testCatalogDidLoadPopularMoviesViewModelWithFailureStatus() async throws {
    // Given
    let movies: [Movie] = []
    let error = NSError(
        domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])

    // When
    let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: movies, status: .failure(error))

    // Then
    #expect(viewModel.movies.isEmpty)
}
