import Foundation

protocol CatalogPresenting {
    func presetingPopularMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel)
    func presentingTopRatedMovies(viewModel: Catalog.DidLoadTopRatedMovies.ViewModel)
    func presentingSearchResults(viewModel: Catalog.SearchMovies.ViewModel)
}

@MainActor
final class CatalogInteractor: CatalogInteracting {
    private let presenter: CatalogPresenting
    private let service: CatalogService
    private var searchTask: Task<Void, Never>?

    init(presenter: CatalogPresenting, service: CatalogService) {
        self.presenter = presenter
        self.service = service
    }

    func handleOnAppear(request: Catalog.OnAppear.Request) async {
        presenter.presetingPopularMovies(viewModel: .init(movies: [], status: .loading))
        presenter.presentingTopRatedMovies(viewModel: .init(movies: [], status: .loading))

        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.loadPopularMovies() }
            group.addTask { await self.loadTopRatedMovies() }
        }
    }
    
    private func loadPopularMovies() async {
        do {
            let request = try await service.getPopularMovies()
            presenter.presetingPopularMovies(
                viewModel: .init(movies: request.results, status: .loaded))
        } catch {
            presenter.presetingPopularMovies(
                viewModel: .init(movies: [], status: .failure(error)))
        }
    }
    
    private func loadTopRatedMovies() async {
        do {
            let request = try await service.getTopRatedMovies()
            presenter.presentingTopRatedMovies(
                viewModel: .init(movies: request.results, status: .loaded))
        } catch {
            presenter.presentingTopRatedMovies(
                viewModel: .init(movies: [], status: .failure(error)))
        }
    }

    func handleSearchMovies(request: Catalog.SearchMovies.Request) async {
        searchTask?.cancel()

        guard !request.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            presenter.presentingSearchResults(
                viewModel: .init(movies: [], status: .idle, canLoadMore: false, isAppending: false))
            return
        }

        if !request.isAppending {
            presenter.presentingSearchResults(
                viewModel: .init(
                    movies: [], status: .loading, canLoadMore: false, isAppending: false))
        }

        searchTask = Task {
            do {
                try await Task.sleep(nanoseconds: 300_000_000)

                if Task.isCancelled { return }

                let response = try await service.searchMovies(
                    query: request.query, page: request.page)
                let canLoadMore = response.page < response.totalPages

                presenter.presentingSearchResults(
                    viewModel: .init(
                        movies: response.results,
                        status: .loaded,
                        canLoadMore: canLoadMore,
                        isAppending: request.isAppending
                    ))
            } catch {
                if !Task.isCancelled {
                    presenter.presentingSearchResults(
                        viewModel: .init(
                            movies: [], status: .failure(error), canLoadMore: false,
                            isAppending: false))
                }
            }
        }
    }
}
