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
            Movie(
                id: 1, title: "Test Movie", overview: "Test Overview", releaseDate: "2023-01-01",
                posterPath: "/test.jpg")
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
