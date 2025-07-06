import Foundation
import Testing

@testable import Catalog

// TODO: Implement meaningful tests for CatalogInteractor with proper mocking

// MARK: - Mock Classes

final class MockCatalogPresenting: CatalogPresenting {
    func presetingPopularMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
        // Mock implementation - just receives the call
    }
}
