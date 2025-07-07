import XCTest

@testable import Favorites

final class FavoritesTests: XCTestCase {

    @MainActor
    func testFavoritesConfiguration() {
        let view = FavoritesConfigurator.configure()
        XCTAssertNotNil(view)
    }

    func testFavoritesInteractor() {
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor(presenter: presenter)
        let viewState = FavoritesView.ViewState()

        presenter.display = viewState

        interactor.handleLoadFavorites(request: Favorites.LoadFavorites.Request())

        XCTAssertFalse(viewState.favorites.isEmpty)
        XCTAssertEqual(viewState.favorites.count, 8)
    }

    func testRemoveFavorite() {
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor(presenter: presenter)
        let viewState = FavoritesView.ViewState()

        presenter.display = viewState

        interactor.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
        let initialCount = viewState.favorites.count

        interactor.handleRemoveFavorite(request: Favorites.RemoveFavorite.Request(movie: "Coringa"))

        XCTAssertEqual(viewState.favorites.count, initialCount - 1)
        XCTAssertFalse(viewState.favorites.contains("Coringa"))
    }

    func testClearFavorites() {
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor(presenter: presenter)
        let viewState = FavoritesView.ViewState()

        presenter.display = viewState

        interactor.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
        XCTAssertFalse(viewState.favorites.isEmpty)

        interactor.handleClearFavorites(request: Favorites.ClearFavorites.Request())

        XCTAssertTrue(viewState.favorites.isEmpty)
    }
}
