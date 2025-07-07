protocol FavoritesPresenting {
    func presentFavorites(response: Favorites.LoadFavorites.Response)
    func presentRemovedFavorite(response: Favorites.RemoveFavorite.Response)
    func presentClearedFavorites(response: Favorites.ClearFavorites.Response)
    func presentSharedFavorites(response: Favorites.ShareFavorites.Response)
}

class FavoritesInteractor: FavoritesInteracting {
    private let presenter: FavoritesPresenter
    private var favoriteMovies: [String] = [
        "Vingadores: Ultimato",
        "Coringa",
        "Parasita",
        "1917",
        "Era uma Vez em... Hollywood",
        "Pantera Negra",
        "Oppenheimer",
        "Barbie",
    ]

    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
    }

    func handleLoadFavorites(request: Favorites.LoadFavorites.Request) {
        presenter.presentFavorites(
            response: Favorites.LoadFavorites.Response(movies: favoriteMovies))
    }

    func handleRemoveFavorite(request: Favorites.RemoveFavorite.Request) {
        favoriteMovies.removeAll { $0 == request.movie }
        presenter.presentRemovedFavorite(
            response: Favorites.RemoveFavorite.Response(removedMovie: request.movie))
    }

    func handleClearFavorites(request: Favorites.ClearFavorites.Request) {
        favoriteMovies.removeAll()
        presenter.presentClearedFavorites(response: Favorites.ClearFavorites.Response())
    }

    func handleShareFavorites(request: Favorites.ShareFavorites.Request) {
        presenter.presentSharedFavorites(
            response: Favorites.ShareFavorites.Response(movies: favoriteMovies))
    }
}
