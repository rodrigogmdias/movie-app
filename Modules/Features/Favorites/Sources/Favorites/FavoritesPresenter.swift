public protocol FavoritesDisplaying: AnyObject {
    func displayFavorites(viewModel: Favorites.LoadFavorites.ViewModel)
    func displayRemovedFavorite(viewModel: Favorites.RemoveFavorite.ViewModel)
    func displayClearedFavorites(viewModel: Favorites.ClearFavorites.ViewModel)
    func displaySharedFavorites(viewModel: Favorites.ShareFavorites.ViewModel)
}

class FavoritesPresenter: FavoritesPresenting {

    weak var display: FavoritesDisplaying?

    func presentFavorites(response: Favorites.LoadFavorites.Response) {
        display?.displayFavorites(
            viewModel: Favorites.LoadFavorites.ViewModel(movies: response.movies))
    }

    func presentRemovedFavorite(response: Favorites.RemoveFavorite.Response) {
        display?.displayRemovedFavorite(
            viewModel: Favorites.RemoveFavorite.ViewModel(removedMovie: response.removedMovie))
    }

    func presentClearedFavorites(response: Favorites.ClearFavorites.Response) {
        display?.displayClearedFavorites(viewModel: Favorites.ClearFavorites.ViewModel())
    }

    func presentSharedFavorites(response: Favorites.ShareFavorites.Response) {
        display?.displaySharedFavorites(
            viewModel: Favorites.ShareFavorites.ViewModel(movies: response.movies))
    }
}
