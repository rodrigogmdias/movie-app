protocol CatalogDisplaying: AnyObject {
    func displayMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel)
}

final class CatalogPresenter: CatalogPresenting {
    weak var display: CatalogDisplaying?
    
    func presetingPopularMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
        display?.displayMovies(viewModel: .init(movies: viewModel.movies, status: viewModel.status))
    }
}
