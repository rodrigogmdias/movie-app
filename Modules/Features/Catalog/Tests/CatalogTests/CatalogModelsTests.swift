import Foundation
import Testing

@testable import Catalog

// TODO: Remove tests that only test struct initialization without meaningful assertions

@Test func testCatalogDidLoadPopularMoviesResponse() async throws {
    // Given
    let movies = [
        Movie.mock(id: 1, title: "Test Movie", overview: "Test Overview")
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
        Movie.mock(id: 1, title: "Test Movie", overview: "Test Overview")
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
        Movie.mock(id: 1, title: "Test Movie", overview: "Test Overview")
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

@Test func testCatalogDidLoadTopRatedMoviesResponse() async throws {
    // Given
    let movies = [
        Movie.mock(
            id: 1, title: "Top Rated Movie", overview: "Top Rated Overview", voteAverage: 9.5)
    ]

    // When
    let response = Catalog.DidLoadTopRatedMovies.Response(movies: movies)

    // Then
    #expect(response.movies.count == 1)
    #expect(response.movies.first?.title == "Top Rated Movie")
    #expect(response.movies.first?.voteAverage == 9.5)
}

@Test func testCatalogDidLoadTopRatedMoviesViewModelWithLoadingStatus() async throws {
    // Given
    let movies = [
        Movie.mock(
            id: 1, title: "Top Rated Movie", overview: "Top Rated Overview", voteAverage: 9.5)
    ]

    // When
    let viewModel = Catalog.DidLoadTopRatedMovies.ViewModel(movies: movies, status: .loading)

    // Then
    #expect(viewModel.movies.count == 1)
    #expect(viewModel.movies.first?.title == "Top Rated Movie")
    #expect(viewModel.movies.first?.voteAverage == 9.5)
}

@Test func testCatalogDidLoadTopRatedMoviesViewModelWithLoadedStatus() async throws {
    // Given
    let movies = [
        Movie.mock(
            id: 1, title: "Top Rated Movie", overview: "Top Rated Overview", voteAverage: 9.5)
    ]

    // When
    let viewModel = Catalog.DidLoadTopRatedMovies.ViewModel(movies: movies, status: .loaded)

    // Then
    #expect(viewModel.movies.count == 1)
    #expect(viewModel.movies.first?.title == "Top Rated Movie")
    #expect(viewModel.movies.first?.voteAverage == 9.5)
}

@Test func testCatalogDidLoadTopRatedMoviesViewModelWithFailureStatus() async throws {
    // Given
    let movies: [Movie] = []
    let error = NSError(
        domain: "TestError", code: 1,
        userInfo: [NSLocalizedDescriptionKey: "Top rated movies test error"])

    // When
    let viewModel = Catalog.DidLoadTopRatedMovies.ViewModel(movies: movies, status: .failure(error))

    // Then
    #expect(viewModel.movies.isEmpty)
}
