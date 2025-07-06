import Components
import MovieDetail
import SwiftUI

struct CatalogLoadedView: View {
    let viewState: CatalogView.ViewState
    let selectedMovieAction: (GalleryView.Movie) -> Void
    let showMoreButtonAction: () -> Void

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
            .padding(.vertical)
        }
    }
}

#Preview {
    let mockViewState = CatalogView.ViewState()
    mockViewState.popularMovies = [
        Movie(
            id: 1,
            title: "The Shawshank Redemption",
            overview:
                "Dois homens presos se unem ao longo de vários anos, encontrando consolo e eventual redenção através de atos de decência comum.",
            releaseDate: "1994-09-23",
            posterPath: "/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"
        ),
        Movie(
            id: 2,
            title: "The Godfather",
            overview: "A saga de uma família do crime italiano-americana.",
            releaseDate: "1972-03-24",
            posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
        ),
    ]
    mockViewState.popularMoviesStatus = .loaded

    return CatalogLoadedView(
        viewState: mockViewState,
        selectedMovieAction: { movie in
            print("Filme selecionado: \(movie.title)")
        },
        showMoreButtonAction: {
            print("Ver mais filmes")
        }
    )
}
