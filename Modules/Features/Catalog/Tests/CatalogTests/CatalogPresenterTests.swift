import Testing

@testable import Catalog

@Test func testCatalogPresenterInitialization() async throws {
    // Given & When
    let presenter = CatalogPresenter()

    // Then
    #expect(presenter.display == nil)
}

@Test func testCatalogPresenterPresentingPopularMovies() async throws {
    // Given
    let presenter = CatalogPresenter()
    let mockDisplay = MockCatalogDisplaying()
    presenter.display = mockDisplay

    let movies = [
        Movie.mock(id: 1, title: "Test Movie", overview: "Test Overview")
    ]
    let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: movies, status: .loaded)

    // When
    presenter.presetingPopularMovies(viewModel: viewModel)

    // Then
    #expect(mockDisplay.displayMoviesCalled)
    #expect(mockDisplay.lastViewModel != nil)
    #expect(mockDisplay.lastViewModel?.movies.count == 1)
    #expect(mockDisplay.lastViewModel?.movies.first?.title == "Test Movie")
}

@Test func testCatalogPresenterPresentingTopRatedMovies() async throws {
    // Given
    let presenter = CatalogPresenter()
    let mockDisplay = MockCatalogDisplaying()
    presenter.display = mockDisplay

    let movies = [
        Movie.mock(
            id: 1, title: "Top Rated Movie", overview: "Top Rated Overview", voteAverage: 9.5)
    ]
    let viewModel = Catalog.DidLoadTopRatedMovies.ViewModel(movies: movies, status: .loaded)

    // When
    presenter.presentingTopRatedMovies(viewModel: viewModel)

    // Then
    #expect(mockDisplay.displayTopRatedMoviesCalled)
    #expect(mockDisplay.lastTopRatedViewModel != nil)
    #expect(mockDisplay.lastTopRatedViewModel?.movies.count == 1)
    #expect(mockDisplay.lastTopRatedViewModel?.movies.first?.title == "Top Rated Movie")
    #expect(mockDisplay.lastTopRatedViewModel?.movies.first?.voteAverage == 9.5)
}

@Test func testCatalogPresenterWithNilDisplay() async throws {
    // Given
    let presenter = CatalogPresenter()
    // display is nil by default

    let movies = [
        Movie.mock(id: 1, title: "Test Movie", overview: "Test Overview")
    ]
    let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: movies, status: .loaded)

    // When & Then
    // Should not crash when display is nil
    presenter.presetingPopularMovies(viewModel: viewModel)
}

// MARK: - Mock Classes

final class MockCatalogDisplaying: CatalogDisplaying {
    var displayMoviesCalled = false
    var lastViewModel: Catalog.DidLoadPopularMovies.ViewModel?
    var displayTopRatedMoviesCalled = false
    var lastTopRatedViewModel: Catalog.DidLoadTopRatedMovies.ViewModel?
    var displaySearchResultsCalled = false
    var lastSearchViewModel: Catalog.SearchMovies.ViewModel?

    func displayMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
        displayMoviesCalled = true
        lastViewModel = viewModel
    }

    func displayTopRatedMovies(viewModel: Catalog.DidLoadTopRatedMovies.ViewModel) {
        displayTopRatedMoviesCalled = true
        lastTopRatedViewModel = viewModel
    }

    func displaySearchResults(viewModel: Catalog.SearchMovies.ViewModel) {
        displaySearchResultsCalled = true
        lastSearchViewModel = viewModel
    }
}
