import SwiftUI
import CachedAsyncImage

public struct GalleryView: View {
    public enum GalleryStatus {
        case loading
        case loaded
        case failure(Error)
    }
    
    public struct Movie: Identifiable, Hashable {
        public let id: Int
        public let title: String
        public let posterURL: URL?
        
        public init(id: Int, title: String, posterURL: URL?) {
            self.id = id
            self.title = title
            self.posterURL = posterURL
        }
    }
    
    let title: String
    let movies: [Movie]
    let status: GalleryStatus
    let showMoreButtonAction: (() -> Void)?
    let selectedMovieAction: ((Movie) -> Void)?
    
    public init(title: String,
                status: GalleryStatus = .loading,
                movies: [Movie],
                selectedMovieAction: ((Movie) -> Void)? = nil,
                showMoreButtonAction: (() -> Void)? = nil,
    ) {
        self.title = title
        self.status = status
        self.movies = movies
        self.selectedMovieAction = selectedMovieAction
        self.showMoreButtonAction = showMoreButtonAction
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            switch status {
            case .loading:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<5, id: \.self) { _ in
                            VStack {
                                Color.gray.opacity(0.3)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(8)
                                    .overlay(
                                        Text("Carregando...")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                            .padding(4),
                                        alignment: .bottom
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            case .loaded:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(movies) { movie in
                            VStack {
                                NavigationLink(value: movie) {
                                    CachedAsyncImage(
                                        url: movie.posterURL,
                                        content: { image in
                                            image.resizable()
                                        },
                                        placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                    )
                                    .frame(width: 120, height: 180)
                                    .overlay(
                                        Text(movie.title)
                                            .foregroundColor(.white)
                                            .font(.caption)
                                            .lineLimit(2)
                                            .padding(4)
                                            .background(Color.black.opacity(0.7))
                                            .cornerRadius(4)
                                            .padding(4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.bottom, 4),
                                        alignment: .bottom
                                    )
                                }
                                .cornerRadius(8)
                            }
                        }
                        if let action = showMoreButtonAction {
                            Button(action: action) {
                                Text("Ver mais")
                                    .padding(8)
                                    .foregroundColor(.blue)
                                    .frame(height: 180)
                                    .frame(width: 120)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            case .failure(let error):
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        Text("Erro ao carregar: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    .frame(minHeight: 180)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview("GalleryView Preview") {
    ScrollView {
        GalleryView(title: "Filmes em destaque",
                    status: .loaded,
                    movies: [
                        GalleryView.Movie(
                            id: 1,
                            title: "Filme com nome muito grande",
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/yQGaui0bQ5Ai3KIFBB45nTeIqad.jpg")
                        ),
                        GalleryView.Movie(
                            id: 2,
                            title: "Movie 2",
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg")
                        ),
                        GalleryView.Movie(
                            id: 3,
                            title: "Movie 3",
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg")
                        )
                    ])
        GalleryView(title: "Filmes em destaque",
                    status: .loaded,
                    movies: [
                        GalleryView.Movie(
                            id: 1,
                            title: "Filme com nome muito grande",
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/yQGaui0bQ5Ai3KIFBB45nTeIqad.jpg")
                        ),
                        GalleryView.Movie(
                            id: 2,
                            title: "Movie 2",
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg")
                        ),
                        GalleryView.Movie(
                            id: 3,
                            title: "Movie 3",
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/8OP3h80BzIDgmMNANVaYlQ6H4Oc.jpg")
                        )
                    ],
        )
        GalleryView(title: "Filmes em destaque",
                    status: .loading,
                    movies: [])
        GalleryView(title: "Filmes em destaque",
                    status: .failure(
                        NSError(domain: "TestError",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Failed to load movies"]
                               )
                    ),
                    movies: [])
        
    }
}
