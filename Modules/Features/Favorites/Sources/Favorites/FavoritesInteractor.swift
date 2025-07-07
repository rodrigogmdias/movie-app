protocol FavoritesPresenting {
    func presentFavorites(response: Favorites.LoadFavorites.Response)
    func presentRemovedFavorite(response: Favorites.RemoveFavorite.Response)
    func presentClearedFavorites(response: Favorites.ClearFavorites.Response)
    func presentSharedFavorites(response: Favorites.ShareFavorites.Response)
}

class FavoritesInteractor: FavoritesInteracting {
    private let presenter: FavoritesPresenter
    private let localStorage: FavoritesLocalStorage

    init(
        presenter: FavoritesPresenter, localStorage: FavoritesLocalStorage = FavoritesLocalStorage()
    ) {
        self.presenter = presenter
        self.localStorage = localStorage
    }

    func handleLoadFavorites(request: Favorites.LoadFavorites.Request) {
        let favorites = localStorage.getFavorites()
        presenter.presentFavorites(
            response: Favorites.LoadFavorites.Response(movies: favorites))
    }

    func handleRemoveFavorite(request: Favorites.RemoveFavorite.Request) {
        localStorage.removeFavorite(movieId: request.movieId)
        presenter.presentRemovedFavorite(
            response: Favorites.RemoveFavorite.Response(removedMovieId: request.movieId))
    }

    func handleClearFavorites(request: Favorites.ClearFavorites.Request) {
        localStorage.clearFavorites()
        presenter.presentClearedFavorites(response: Favorites.ClearFavorites.Response())
    }

    func handleShareFavorites(request: Favorites.ShareFavorites.Request) {
        let favorites = localStorage.getFavorites()
        presenter.presentSharedFavorites(
            response: Favorites.ShareFavorites.Response(movies: favorites))
    }
}
