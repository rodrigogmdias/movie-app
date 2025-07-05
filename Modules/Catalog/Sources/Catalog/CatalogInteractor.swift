import Foundation

protocol CatalogPresenting {
    func presetingPopularMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel)
}

@MainActor
final class CatalogInteractor: CatalogInteracting {
    private let presenter: CatalogPresenting
    private let service: CatalogService

    init(presenter: CatalogPresenting, service: CatalogService) {
        self.presenter = presenter
        self.service = service
    }
    
    func handleOnAppear(request: Catalog.OnAppear.Request) async {
        presenter.presetingPopularMovies(viewModel: .init(movies: [], status: .loading))
        
        Task {
            do {
                let request = try await service.getPopularMovies()
                presenter.presetingPopularMovies(viewModel: .init(movies: request.results, status: .loaded))
            } catch {
                presenter.presetingPopularMovies(viewModel: .init(movies: [], status: .failure(error)))
            }
        }
    }
}
