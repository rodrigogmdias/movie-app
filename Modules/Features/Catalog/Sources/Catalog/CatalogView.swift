import Components
import MovieDetail
import SwiftUI

protocol CatalogInteracting {
    func handleOnAppear(request: Catalog.OnAppear.Request) async
}

public struct CatalogView: View {
    let interactor: CatalogInteracting?
    @ObservedObject var viewState: ViewState
    
    init(interactor: CatalogInteracting?, viewState: ViewState) {
        self.interactor = interactor
        self.viewState = viewState
        
        Task { [interactor] in
            await interactor?.handleOnAppear(
                request: Catalog.OnAppear.Request()
            )
        }
    }
    
    public var body: some View {
        NavigationStack {
            if viewState.isLoading {
                CatalogLoadingView()
            } else {
                CatalogLoadedView(
                    viewState: viewState,
                    selectedMovieAction: { movie in
                        print("Filme selecionado: \(movie.title)")
                    },
                    showMoreButtonAction: {
                        print("Ver mais filmes em destaque")
                    }
                )
            }
        }
    }
    
    final class ViewState: ObservableObject, CatalogDisplaying {
        @Published var isLoading: Bool = true
        @Published var popularMovies: [Movie] = []
        @Published var popularMoviesStatus: GalleryView.GalleryStatus = .loading
        
        func displayMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
            popularMovies = viewModel.movies
            
            switch viewModel.status {
            case .loading:
                popularMoviesStatus = .loading
                isLoading = true
            case .loaded:
                popularMoviesStatus = .loaded
                isLoading = false
            case .failure(let error):
                popularMoviesStatus = .failure(error)
                isLoading = false
            }
        }
    }
}

#Preview("CatalogView") {
    CatalogView(interactor: nil, viewState: CatalogView.ViewState.example)
}

#Preview("CatalogView Loading") {
    CatalogView(interactor: nil, viewState: CatalogView.ViewState.loadingExample)
}

#Preview("CatalogView Failure") {
    CatalogView(interactor: nil, viewState: CatalogView.ViewState.failureExample)
}

extension CatalogView.ViewState {
    nonisolated(unsafe) static let example: CatalogView.ViewState = {
        let viewState = CatalogView.ViewState()
        viewState.isLoading = false
        viewState.popularMovies = [
            Movie(
                id: 1,
                title: "Filme 1",
                overview: "Descrição do filme 1",
                releaseDate: "2023-01-01",
                posterPath: "/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg"),
            Movie(
                id: 2,
                title: "Filme 2",
                overview: "Descrição do filme 2",
                releaseDate: "2023-02-01",
                posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"),
            Movie(
                id: 3,
                title: "Filme 3",
                overview: "Descrição do filme 3",
                releaseDate: "2023-03-01",
                posterPath: "/yQGaui0bQ5Ai3KIFBB45nTeIqad.jpg"),
            Movie(
                id: 4,
                title: "Filme 4",
                overview: "Descrição do filme 4",
                releaseDate: "2023-04-01",
                posterPath: "/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg"),
            Movie(
                id: 5,
                title: "Filme 5",
                overview: "Descrição do filme 5",
                releaseDate: "2023-05-01",
                posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"),
        ]
        viewState.popularMoviesStatus = .loaded
        return viewState
    }()
    
    nonisolated(unsafe) static let loadingExample: CatalogView.ViewState = {
        let viewState = CatalogView.ViewState()
        viewState.isLoading = true
        viewState.popularMovies = []
        viewState.popularMoviesStatus = .loading
        return viewState
    }()
    
    nonisolated(unsafe) static let failureExample: CatalogView.ViewState = {
        let viewState = CatalogView.ViewState()
        viewState.isLoading = false
        viewState.popularMovies = []
        viewState.popularMoviesStatus = .failure(
            NSError(
                domain: "TestError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to load movies"])
        )
        return viewState
    }()
}
