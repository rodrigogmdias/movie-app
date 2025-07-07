import SharedPreferences
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
        let mockSharedPreferences = SharedPreferences()
        let localStorage = FavoritesLocalStorage(sharedPreferences: mockSharedPreferences)
        let interactor = FavoritesInteractor(presenter: presenter, localStorage: localStorage)
        let viewState = FavoritesView.ViewState()

        presenter.display = viewState

        interactor.handleLoadFavorites(request: Favorites.LoadFavorites.Request())

        XCTAssertTrue(viewState.favorites.isEmpty)
        XCTAssertEqual(viewState.favorites.count, 0)
    }

    func testRemoveFavorite() {
        let presenter = FavoritesPresenter()
        let mockSharedPreferences = SharedPreferences()
        let localStorage = FavoritesLocalStorage(sharedPreferences: mockSharedPreferences)
        let interactor = FavoritesInteractor(presenter: presenter, localStorage: localStorage)
        let viewState = FavoritesView.ViewState()

        presenter.display = viewState

        // Adicionar um filme favorito primeiro
        let testMovie = FavoriteMovie(id: 475557, title: "Coringa", coverImageUrl: nil)
        localStorage.addFavorite(movie: testMovie)

        interactor.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
        let initialCount = viewState.favorites.count

        let jokerMovieId = 475557
        interactor.handleRemoveFavorite(
            request: Favorites.RemoveFavorite.Request(movieId: jokerMovieId))

        XCTAssertEqual(viewState.favorites.count, initialCount - 1)
        XCTAssertFalse(viewState.favorites.contains(where: { $0.id == jokerMovieId }))
    }

    func testClearFavorites() {
        let presenter = FavoritesPresenter()
        let mockSharedPreferences = SharedPreferences()
        let localStorage = FavoritesLocalStorage(sharedPreferences: mockSharedPreferences)
        let interactor = FavoritesInteractor(presenter: presenter, localStorage: localStorage)
        let viewState = FavoritesView.ViewState()

        presenter.display = viewState

        // Adicionar alguns filmes favoritos primeiro
        let testMovie1 = FavoriteMovie(id: 475557, title: "Coringa", coverImageUrl: nil)
        let testMovie2 = FavoriteMovie(
            id: 299536, title: "Vingadores: Ultimato", coverImageUrl: nil)
        localStorage.addFavorite(movie: testMovie1)
        localStorage.addFavorite(movie: testMovie2)

        interactor.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
        XCTAssertFalse(viewState.favorites.isEmpty)

        interactor.handleClearFavorites(request: Favorites.ClearFavorites.Request())

        XCTAssertTrue(viewState.favorites.isEmpty)
    }
}
