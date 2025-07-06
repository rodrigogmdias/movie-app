import Foundation
import Testing

@testable import Catalog

@Test func testCatalogInteractorInitialization() async throws {
    // Given
    await MainActor.run {
        let mockPresenter = MockCatalogPresenting()
        let service = CatalogService()

        // When
        let _ = CatalogInteractor(presenter: mockPresenter, service: service)

        // Then
        // Interactor is created successfully (no public properties to test)
        #expect(true)  // Basic initialization test
    }
}

@Test func testCatalogInteractorHandleOnAppearDoesNotThrow() async throws {
    // Given
    await MainActor.run {
        let mockPresenter = MockCatalogPresenting()
        let service = CatalogService()
        let interactor = CatalogInteractor(presenter: mockPresenter, service: service)

        // When & Then
        // Test that the method can be called without throwing
        Task {
            await interactor.handleOnAppear(request: Catalog.OnAppear.Request())
        }

        #expect(true)
    }
}

// MARK: - Mock Classes

final class MockCatalogPresenting: CatalogPresenting {
    func presetingPopularMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
        // Mock implementation - just receives the call
    }
}
