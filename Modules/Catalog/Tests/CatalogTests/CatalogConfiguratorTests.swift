import Testing

@testable import Catalog

@Test func testCatalogConfiguratorConfigure() async throws {
    // Given & When
    await MainActor.run {
        let view = CatalogConfigurator.configure()

        // Then
        #expect(view.interactor != nil)
        // ViewState is non-optional, so we just check if it's properly initialized
        #expect(view.viewState.popularMovies.isEmpty)
    }
}

@Test func testCatalogConfiguratorCreatesViewWithCorrectDependencies() async throws {
    // Given & When
    await MainActor.run {
        let view = CatalogConfigurator.configure()

        // Then
        // Verify that the view has the expected initial state
        #expect(view.viewState.popularMovies.isEmpty)

        // Verify that the view has an interactor
        #expect(view.interactor != nil)
    }
}
