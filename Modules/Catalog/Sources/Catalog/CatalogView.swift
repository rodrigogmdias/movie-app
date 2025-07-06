import SwiftUI
import Components
import MovieDetail

protocol CatalogInteracting {
    func handleOnAppear(request: Catalog.OnAppear.Request) async
}

public struct CatalogView: View {
    let interactor: CatalogInteracting?
    @ObservedObject var viewState: ViewState

    public var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Bem vindo ao Movie App! 👋")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text("Vamos explorar o catálogo de filmes?")
                                    .font(.body)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Circle()
                                .fill(Color.red)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "film")
                                        .foregroundColor(.white)
                                )
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Buscar filmes...", text: .constant(""))
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        GalleryView(
                            title: "Filmes em destaque",
                            status: viewState.popularMoviesStatus,
                            movies: viewState.popularMovies.map { movie in
                                GalleryView.Movie(
                                    id: movie.id,
                                    title: movie.title,
                                    posterURL: movie.posterURL()
                                )
                            },
                            selectedMovieAction: { movie in
                                print("Filme selecionado: \(movie.title)")
                            },
                            showMoreButtonAction: {
                                print("Ver mais filmes em destaque")
                            }
                        )
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Generos")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(
                                        ["Ação", "Comédia", "Drama", "Terror", "Ficção Científica"],
                                        id: \.self
                                    ) { category in
                                        Text(category)
                                            .padding(10)
                                            .background(Color.red.opacity(0.1))
                                            .cornerRadius(8)
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Mais vistos")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(0..<5, id: \.self) { index in
                                HStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 60, height: 90)
                                        .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Filme \(index + 1)")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                        
                                        Text("Descrição breve do filme.")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .navigationDestination(for: GalleryView.Movie.self) { movie in
                    MovieDetailConfigurator.configure(title: movie.title, coverImageUrl: movie.posterURL)
                }
            }
            .onAppear() {
                Task {[interactor] in
                    await interactor?.handleOnAppear(
                        request: Catalog.OnAppear.Request()
                    )
                }
            }
        }
    }

    final class ViewState: ObservableObject, CatalogDisplaying {
        @Published var popularMovies: [Movie] = []
        @Published var popularMoviesStatus: GalleryView.GalleryStatus = .loading
        
        func displayMovies(viewModel: Catalog.DidLoadPopularMovies.ViewModel) {
            popularMovies = viewModel.movies
            
            switch viewModel.status {
            case .loading:
                popularMoviesStatus = .loading
            case .loaded:
                popularMoviesStatus = .loaded
            case .failure(let error):
                popularMoviesStatus = .failure(error)
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
        viewState.popularMovies = [
            Movie(id: 1,
                  title: "Filme 1",
                  overview: "Descrição do filme 1",
                  releaseDate: "2023-01-01",
                  posterPath: "/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg"),
            Movie(id: 2,
                  title: "Filme 2",
                  overview: "Descrição do filme 2",
                  releaseDate: "2023-02-01",
                  posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"),
            Movie(id: 3,
                  title: "Filme 3",
                  overview: "Descrição do filme 3",
                  releaseDate: "2023-03-01",
                  posterPath: "/yQGaui0bQ5Ai3KIFBB45nTeIqad.jpg"),
            Movie(id: 4,
                  title: "Filme 4",
                  overview: "Descrição do filme 4",
                  releaseDate: "2023-04-01",
                  posterPath: "/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg"),
            Movie(id: 5,
                  title: "Filme 5",
                  overview: "Descrição do filme 5",
                  releaseDate: "2023-05-01",
                  posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg")
        ]
        viewState.popularMoviesStatus = .loaded
        return viewState
    }()
    
    nonisolated(unsafe) static let loadingExample: CatalogView.ViewState = {
        let viewState = CatalogView.ViewState()
        viewState.popularMovies = []
        viewState.popularMoviesStatus = .loading
        return viewState
    }()
    
    nonisolated(unsafe) static let failureExample: CatalogView.ViewState = {
        let viewState = CatalogView.ViewState()
        viewState.popularMovies = []
        viewState.popularMoviesStatus = .failure(
            NSError(domain: "TestError",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Failed to load movies"])
        )
        return viewState
    }()
}
