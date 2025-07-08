protocol CatalogDisplaying: AnyObject {
    func displayMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel)
    func displayTopRatedMovies(viewModel: Catalog.DidLoadTopRatedMovies.ViewModel)
    func displaySearchResults(viewModel: Catalog.SearchMovies.ViewModel)
}

final class CatalogPresenter: CatalogPresenting {
    weak var display: CatalogDisplaying?

    func presetingPopularMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
        display?.displayMovies(viewModel: .init(movies: viewModel.movies, status: viewModel.status))
    }

    func presentingTopRatedMovies(viewModel: Catalog.DidLoadTopRatedMovies.ViewModel) {
        display?.displayTopRatedMovies(
            viewModel: .init(movies: viewModel.movies, status: viewModel.status))
    }

    func presentingSearchResults(viewModel: Catalog.SearchMovies.ViewModel) {
        display?.displaySearchResults(
            viewModel: .init(
                movies: viewModel.movies,
                status: viewModel.status,
                canLoadMore: viewModel.canLoadMore,
                isAppending: viewModel.isAppending
            ))
    }
}
