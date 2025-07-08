import Components
import MovieDetail
import SwiftUI

protocol CatalogInteracting {
    func handleOnAppear(request: Catalog.OnAppear.Request) async
    func handleSearchMovies(request: Catalog.SearchMovies.Request) async
}

public struct CatalogView: View {
    let interactor: CatalogInteracting?
    @ObservedObject var viewState: ViewState
    @State private var navigationPath = NavigationPath()
    
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
        NavigationStack(path: $navigationPath) {
            if viewState.isLoading {
                CatalogLoadingView()
            } else {
                CatalogLoadedView(
                    viewState: viewState,
                    selectedMovieAction: { movie in
                        navigationPath.append(movie)
                    },
                    showMoreButtonAction: {
                        print("Ver mais filmes em destaque")
                    },
                    searchAction: { query in
                        viewState.searchQuery = query
                        if let interactor = interactor {
                            Task {
                                if query.isEmpty {
                                    await interactor.handleSearchMovies(
                                        request: Catalog.SearchMovies.Request(query: "", page: 1, isAppending: false)
                                    )
                                } else {
                                    viewState.currentSearchQuery = query
                                    await interactor.handleSearchMovies(
                                        request: Catalog.SearchMovies.Request(query: query, page: 1, isAppending: false)
                                    )
                                }
                            }
                        }
                    },
                    loadMoreSearchAction: {
                        if viewState.canLoadMore && !viewState.isSearching {
                            viewState.currentSearchPage += 1
                            if let interactor = interactor {
                                Task {
                                    await interactor.handleSearchMovies(
                                        request: Catalog.SearchMovies.Request(
                                            query: viewState.currentSearchQuery,
                                            page: viewState.currentSearchPage,
                                            isAppending: true
                                        )
                                    )
                                }
                            }
                        }
                    }
                )
            }
        }
        .navigationDestination(for: GalleryView.Movie.self) { movie in
            MovieDetailConfigurator.configure(
                id: movie.id,
                title: movie.title,
                coverImageUrl: movie.posterURL
            )
        }
    }
    
    final class ViewState: ObservableObject, CatalogDisplaying {
        @Published var isLoading: Bool = true
        @Published var popularMovies: [Movie] = []
        @Published var popularMoviesStatus: GalleryView.GalleryStatus = .loading
        @Published var topRatedMovies: [Movie] = []
        @Published var topRatedMoviesStatus: GalleryView.GalleryStatus = .loading
        @Published var searchQuery: String = ""
        @Published var searchResults: [Movie] = []
        @Published var searchStatus: GalleryView.GalleryStatus = .loading
        @Published var isSearching: Bool = false
        @Published var canLoadMore: Bool = false
        @Published var currentSearchPage: Int = 1
        @Published var currentSearchQuery: String = ""
        
        func displayMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
            popularMovies = viewModel.movies
            
            switch viewModel.status {
            case .loading:
                popularMoviesStatus = .loading
            case .loaded:
                popularMoviesStatus = .loaded
                checkIfLoadingComplete()
            case .failure(let error):
                popularMoviesStatus = .failure(error)
                checkIfLoadingComplete()
            }
        }
        
        func displayTopRatedMovies(viewModel: Catalog.DidLoadTopRatedMovies.ViewModel) {
            topRatedMovies = viewModel.movies
            
            switch viewModel.status {
            case .loading:
                topRatedMoviesStatus = .loading
            case .loaded:
                topRatedMoviesStatus = .loaded
                checkIfLoadingComplete()
            case .failure(let error):
                topRatedMoviesStatus = .failure(error)
                checkIfLoadingComplete()
            }
        }
        
        private func checkIfLoadingComplete() {
            if case .loading = popularMoviesStatus { return }
            if case .loading = topRatedMoviesStatus { return }
            isLoading = false
        }
        
        func displaySearchResults(viewModel: Catalog.SearchMovies.ViewModel) {
            if viewModel.isAppending {
                searchResults.append(contentsOf: viewModel.movies)
            } else {
                searchResults = viewModel.movies
            }
            
            canLoadMore = viewModel.canLoadMore
            
            switch viewModel.status {
            case .idle:
                searchStatus = .loaded
                isSearching = false
                searchResults = []
                currentSearchPage = 1
                currentSearchQuery = ""
            case .loading:
                searchStatus = .loading
                isSearching = true
            case .loaded:
                searchStatus = .loaded
                isSearching = false
                if !viewModel.isAppending {
                    currentSearchPage = 1
                }
            case .failure(let error):
                searchStatus = .failure(error)
                isSearching = false
            }
        }
    }
}

#Preview("CatalogView") {
    CatalogView(interactor: nil as (any CatalogInteracting)?, viewState: CatalogView.ViewState.example)
}

#Preview("CatalogView Loading") {
    CatalogView(interactor: nil as (any CatalogInteracting)?, viewState: CatalogView.ViewState.loadingExample)
}

#Preview("CatalogView Failure") {
    CatalogView(interactor: nil as (any CatalogInteracting)?, viewState: CatalogView.ViewState.failureExample)
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
                posterPath: "/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg",
                backdropPath: "/backdrop1.jpg",
                voteAverage: 8.5,
                voteCount: 1500,
                popularity: 85.2,
                adult: false,
                originalLanguage: "en",
                originalTitle: "Movie 1",
                genreIds: [28, 12]
            ),
            Movie(
                id: 2,
                title: "Filme 2",
                overview: "Descrição do filme 2",
                releaseDate: "2023-02-01",
                posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg",
                backdropPath: "/backdrop2.jpg",
                voteAverage: 7.8,
                voteCount: 2300,
                popularity: 72.1,
                adult: false,
                originalLanguage: "en",
                originalTitle: "Movie 2",
                genreIds: [18, 35]
            ),
            Movie(
                id: 3,
                title: "Filme 3",
                overview: "Descrição do filme 3",
                releaseDate: "2023-03-01",
                posterPath: "/yQGaui0bQ5Ai3KIFBB45nTeIqad.jpg",
                backdropPath: "/backdrop3.jpg",
                voteAverage: 9.1,
                voteCount: 4500,
                popularity: 95.7,
                adult: false,
                originalLanguage: "en",
                originalTitle: "Movie 3",
                genreIds: [16, 10751]
            ),
            Movie(
                id: 4,
                title: "Filme 4",
                overview: "Descrição do filme 4",
                releaseDate: "2023-04-01",
                posterPath: "/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg",
                backdropPath: "/backdrop4.jpg",
                voteAverage: 6.5,
                voteCount: 890,
                popularity: 45.3,
                adult: false,
                originalLanguage: "en",
                originalTitle: "Movie 4",
                genreIds: [27, 53]
            ),
            Movie(
                id: 5,
                title: "Filme 5",
                overview: "Descrição do filme 5",
                releaseDate: "2023-05-01",
                posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg",
                backdropPath: "/backdrop5.jpg",
                voteAverage: 7.2,
                voteCount: 1200,
                popularity: 62.8,
                adult: false,
                originalLanguage: "en",
                originalTitle: "Movie 5",
                genreIds: [878, 12]
            ),
        ]
        viewState.popularMoviesStatus = .loaded
        viewState.topRatedMovies = [
            Movie(
                id: 6,
                title: "O Poderoso Chefão",
                overview: "Uma família do crime organizado luta para manter sua supremacia.",
                releaseDate: "1972-03-24",
                posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
                backdropPath: "/backdrop6.jpg",
                voteAverage: 9.2,
                voteCount: 1800000,
                popularity: 150.5,
                adult: false,
                originalLanguage: "en",
                originalTitle: "The Godfather",
                genreIds: [18, 80]
            ),
            Movie(
                id: 7,
                title: "Um Sonho de Liberdade",
                overview: "Dois homens presos formam uma amizade ao longo dos anos.",
                releaseDate: "1994-09-23",
                posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg",
                backdropPath: "/backdrop7.jpg",
                voteAverage: 9.3,
                voteCount: 2500000,
                popularity: 135.8,
                adult: false,
                originalLanguage: "en",
                originalTitle: "The Shawshank Redemption",
                genreIds: [18, 80]
            ),
            Movie(
                id: 8,
                title: "A Lista de Schindler",
                overview: "Um homem salva mais de mil judeus durante o Holocausto.",
                releaseDate: "1993-12-15",
                posterPath: "/yPisjyLweCl1tbgwgtzBCNCBle.jpg",
                backdropPath: "/backdrop8.jpg",
                voteAverage: 9.0,
                voteCount: 1400000,
                popularity: 112.3,
                adult: false,
                originalLanguage: "en",
                originalTitle: "Schindler's List",
                genreIds: [18, 36, 10752]
            )
        ]
        viewState.topRatedMoviesStatus = .loaded
        return viewState
    }()
    
    nonisolated(unsafe) static let loadingExample: CatalogView.ViewState = {
        let viewState = CatalogView.ViewState()
        viewState.isLoading = true
        viewState.popularMovies = []
        viewState.popularMoviesStatus = .loading
        viewState.topRatedMovies = []
        viewState.topRatedMoviesStatus = .loading
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
        viewState.topRatedMovies = []
        viewState.topRatedMoviesStatus = .failure(
            NSError(
                domain: "TestError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to load top rated movies"])
        )
        return viewState
    }()
}
