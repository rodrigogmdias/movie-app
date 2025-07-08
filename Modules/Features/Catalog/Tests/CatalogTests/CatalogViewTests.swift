import SwiftUI
import Testing

@testable import Catalog

@Test func testCatalogViewInitialization() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()

        // When
        let view = CatalogView(interactor: nil, viewState: viewState)

        // Then
        #expect(view.viewState === viewState)
        #expect(view.interactor == nil)
    }
}

@Test func testCatalogViewStateInitialization() async throws {
    // Given & When
    await MainActor.run {
        let viewState = CatalogView.ViewState()

        // Then
        #expect(viewState.popularMovies.isEmpty)
    }
}

@Test func testCatalogViewStateDisplayMoviesLoaded() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()
        let movies = [
            Movie.mock(id: 1, title: "Test Movie", overview: "Test Overview")
        ]
        let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: movies, status: .loaded)

        // When
        viewState.displayMovies(viewModel: viewModel)

        // Then
        #expect(viewState.popularMovies.count == 1)
        #expect(viewState.popularMovies.first?.title == "Test Movie")
    }
}

@Test func testCatalogViewStateDisplayMoviesFailure() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()
        let error = NSError(
            domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let viewModel = Catalog.DidLoadPopularMovies.ViewModel(movies: [], status: .failure(error))

        // When
        viewState.displayMovies(viewModel: viewModel)

        // Then
        #expect(viewState.popularMovies.isEmpty)
    }
}

@Test func testCatalogViewStateDisplayTopRatedMoviesLoaded() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()
        let movies = [
            Movie.mock(
                id: 1, title: "Top Rated Movie", overview: "Top Rated Overview", voteAverage: 9.5)
        ]
        let viewModel = Catalog.DidLoadTopRatedMovies.ViewModel(movies: movies, status: .loaded)

        // When
        viewState.displayTopRatedMovies(viewModel: viewModel)

        // Then
        #expect(viewState.topRatedMovies.count == 1)
        #expect(viewState.topRatedMovies.first?.title == "Top Rated Movie")
        #expect(viewState.topRatedMovies.first?.voteAverage == 9.5)
    }
}

@Test func testCatalogViewStateDisplayTopRatedMoviesFailure() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()
        let error = NSError(
            domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let viewModel = Catalog.DidLoadTopRatedMovies.ViewModel(movies: [], status: .failure(error))

        // When
        viewState.displayTopRatedMovies(viewModel: viewModel)

        // Then
        #expect(viewState.topRatedMovies.isEmpty)
    }
}

@Test func testCatalogViewStateCheckIfLoadingCompleteWithBothLoaded() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()
        viewState.isLoading = true

        let popularMovies = [Movie.mock(id: 1, title: "Popular Movie")]
        let topRatedMovies = [Movie.mock(id: 2, title: "Top Rated Movie")]

        let popularViewModel = Catalog.DidLoadPopularMovies.ViewModel(
            movies: popularMovies, status: .loaded)
        let topRatedViewModel = Catalog.DidLoadTopRatedMovies.ViewModel(
            movies: topRatedMovies, status: .loaded)

        // When
        viewState.displayMovies(viewModel: popularViewModel)
        viewState.displayTopRatedMovies(viewModel: topRatedViewModel)

        // Then
        #expect(!viewState.isLoading)
    }
}

@Test func testCatalogViewStateCheckIfLoadingCompleteWithOneStillLoading() async throws {
    // Given
    await MainActor.run {
        let viewState = CatalogView.ViewState()
        viewState.isLoading = true

        let popularMovies = [Movie.mock(id: 1, title: "Popular Movie")]

        let popularViewModel = Catalog.DidLoadPopularMovies.ViewModel(
            movies: popularMovies, status: .loaded)
        let topRatedViewModel = Catalog.DidLoadTopRatedMovies.ViewModel(
            movies: [], status: .loading)

        // When
        viewState.displayMovies(viewModel: popularViewModel)
        viewState.displayTopRatedMovies(viewModel: topRatedViewModel)

        // Then
        #expect(viewState.isLoading)
    }
}

@Test func testCatalogViewStateExampleData() async throws {
    // Given & When
    let viewState = CatalogView.ViewState.example

    // Then
    #expect(viewState.popularMovies.count == 5)
    #expect(viewState.popularMovies.first?.title == "Filme 1")
}

@Test func testCatalogViewStateLoadingExample() async throws {
    // Given & When
    let viewState = CatalogView.ViewState.loadingExample

    // Then
    #expect(viewState.popularMovies.isEmpty)
}

@Test func testCatalogViewStateFailureExample() async throws {
    // Given & When
    let viewState = CatalogView.ViewState.failureExample

    // Then
    #expect(viewState.popularMovies.isEmpty)
}

@Test func testCatalogViewStateExampleDataIncludesTopRated() async throws {
    // Given & When
    let viewState = CatalogView.ViewState.example

    // Then
    #expect(viewState.topRatedMovies.count == 3)
    #expect(viewState.topRatedMovies.first?.title == "O Poderoso Chefão")
    #expect(viewState.topRatedMovies.first?.voteAverage == 9.2)
}
