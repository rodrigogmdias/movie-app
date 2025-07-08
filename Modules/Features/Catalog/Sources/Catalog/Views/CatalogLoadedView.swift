import Components
import MovieDetail
import SwiftUI

struct CatalogLoadedView: View {
    let viewState: CatalogView.ViewState
    let selectedMovieAction: (GalleryView.Movie) -> Void
    let showMoreButtonAction: () -> Void
    let searchAction: (String) -> Void
    let loadMoreSearchAction: () -> Void

    @State private var searchText: String = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
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
                    TextField("Buscar filmes...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .onChange(of: searchText) { newValue in
                            searchAction(newValue)
                        }
                }
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

                if !searchText.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Resultados da pesquisa")
                                .font(.headline)
                            Spacer()
                            Button("Limpar") {
                                searchText = ""
                                searchAction("")
                            }
                            .font(.caption)
                            .foregroundColor(.red)
                        }
                        .padding(.horizontal)

                        if case .loading = viewState.searchStatus {
                            HStack {
                                Spacer()
                                VStack(spacing: 8) {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                    Text("Pesquisando...")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                        } else if viewState.searchResults.isEmpty {
                            HStack {
                                Spacer()
                                VStack(spacing: 8) {
                                    Image(systemName: "film.stack")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                    Text("Nenhum filme encontrado")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(viewState.searchResults, id: \.id) { movie in
                                    VStack(spacing: 0) {
                                        HStack(alignment: .top, spacing: 12) {
                                            AsyncImage(url: movie.posterURL()) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                Rectangle()
                                                    .fill(Color.gray.opacity(0.3))
                                                    .overlay(
                                                        Image(systemName: "film")
                                                            .foregroundColor(.gray)
                                                    )
                                            }
                                            .frame(width: 90, height: 135)
                                            .cornerRadius(8)

                                            VStack(alignment: .leading, spacing: 8) {
                                                Text(movie.title)
                                                    .font(.headline)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(2)

                                                HStack(spacing: 16) {
                                                    HStack(spacing: 4) {
                                                        Image(systemName: "star.fill")
                                                            .foregroundColor(.yellow)
                                                            .font(.caption)
                                                        Text(movie.formattedVoteAverage)
                                                            .font(.caption)
                                                            .foregroundColor(.secondary)
                                                    }

                                                    HStack(spacing: 4) {
                                                        Image(systemName: "calendar")
                                                            .foregroundColor(.blue)
                                                            .font(.caption)
                                                        Text(movie.releaseYear)
                                                            .font(.caption)
                                                            .foregroundColor(.secondary)
                                                    }

                                                    Spacer()
                                                }

                                                Text(movie.overview)
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(4)

                                                HStack {
                                                    Text(
                                                        "Popularidade: \(String(format: "%.0f", movie.popularity))"
                                                    )
                                                    .font(.caption2)
                                                    .foregroundColor(.secondary)

                                                    Spacer()

                                                    Text("\(movie.voteCount) avaliações")
                                                        .font(.caption2)
                                                        .foregroundColor(.secondary)
                                                }

                                                Spacer()
                                            }

                                            Spacer()
                                        }

                                        Divider()
                                            .padding(.top, 12)
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedMovieAction(
                                            GalleryView.Movie(
                                                id: movie.id,
                                                title: movie.title,
                                                posterURL: movie.posterURL()
                                            ))
                                    }
                                    .onAppear {
                                        if movie.id == viewState.searchResults.last?.id
                                            && viewState.canLoadMore
                                        {
                                            loadMoreSearchAction()
                                        }
                                    }
                                }

                                if viewState.isSearching && viewState.canLoadMore {
                                    HStack {
                                        Spacer()
                                        VStack(spacing: 8) {
                                            ProgressView()
                                                .scaleEffect(0.8)
                                            Text("Carregando mais filmes...")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {

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
                        selectedMovieAction: selectedMovieAction,
                        showMoreButtonAction: showMoreButtonAction
                    )

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Generos")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(
                                    [
                                        "Ação", "Comédia", "Drama", "Terror",
                                        "Ficção Científica",
                                    ],
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
            }
            .padding(.vertical)
        }
        .navigationDestination(for: GalleryView.Movie.self) { movie in
            MovieDetailConfigurator.configure(
                id: movie.id,
                title: movie.title,
                coverImageUrl: movie.posterURL
            )
        }
    }
}

#Preview {
    CatalogLoadedView(
        viewState: {
            let mockViewState = CatalogView.ViewState()
            mockViewState.popularMovies = [
                Movie(
                    id: 1,
                    title: "The Shawshank Redemption",
                    overview:
                        "Dois homens presos se unem ao longo de vários anos, encontrando consolo e eventual redenção através de atos de decência comum.",
                    releaseDate: "1994-09-23",
                    posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg",
                    backdropPath: "/backdrop1.jpg",
                    voteAverage: 9.3,
                    voteCount: 2_500_000,
                    popularity: 125.5,
                    adult: false,
                    originalLanguage: "en",
                    originalTitle: "The Shawshank Redemption",
                    genreIds: [18, 80]
                ),
                Movie(
                    id: 2,
                    title: "The Godfather",
                    overview: "A saga de uma família do crime italiano-americana.",
                    releaseDate: "1972-03-24",
                    posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
                    backdropPath: "/backdrop2.jpg",
                    voteAverage: 9.2,
                    voteCount: 1_800_000,
                    popularity: 98.7,
                    adult: false,
                    originalLanguage: "en",
                    originalTitle: "The Godfather",
                    genreIds: [18, 80]
                ),
            ]
            mockViewState.popularMoviesStatus = .loaded
            return mockViewState
        }(),
        selectedMovieAction: { movie in
            print("Filme selecionado: \(movie.title)")
        },
        showMoreButtonAction: {
            print("Ver mais filmes")
        },
        searchAction: { query in
            print("Pesquisar: \(query)")
        },
        loadMoreSearchAction: {
            print("Carregar mais resultados")
        }
    )
}
