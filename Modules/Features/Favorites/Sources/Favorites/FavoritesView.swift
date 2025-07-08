import MovieDetail
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public protocol FavoritesInteracting: AnyObject {
    func handleLoadFavorites(request: Favorites.LoadFavorites.Request)
    func handleRemoveFavorite(request: Favorites.RemoveFavorite.Request)
    func handleClearFavorites(request: Favorites.ClearFavorites.Request)
    func handleShareFavorites(request: Favorites.ShareFavorites.Request)
}

public struct FavoritesView: View {
    let interactor: FavoritesInteracting?
    @ObservedObject var viewState: ViewState

    @State private var showingDeleteConfirmation = false
    @State private var movieToDelete: FavoriteMovie?

    public init(interactor: FavoritesInteracting?, viewState: ViewState) {
        self.interactor = interactor
        self.viewState = viewState
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    FavoritesHeaderView(favoritesCount: viewState.favorites.count)

                    if viewState.favorites.isEmpty {
                        FavoritesEmptyView()
                    } else {
                        FavoritesListView(
                            movies: viewState.favorites,
                            onRemoveMovie: confirmRemoval,
                            onShareList: shareList,
                            onClearAll: clearAllFavorites
                        )
                    }
                }
            }
            .navigationDestination(for: FavoriteMovie.self) { movie in
                MovieDetailConfigurator.configure(
                    id: movie.id,
                    title: movie.title,
                    coverImageUrl: movie.coverImageUrl.flatMap { URL(string: $0) }
                )
            }
            .onAppear {
                interactor?.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
            }
            .refreshable {
                interactor?.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
            }
        }
        .alert("Remover dos Favoritos", isPresented: $showingDeleteConfirmation) {
            Button("Cancelar", role: .cancel) {}
            Button("Remover", role: .destructive) {
                if let movie = movieToDelete {
                    interactor?.handleRemoveFavorite(
                        request: Favorites.RemoveFavorite.Request(movieId: movie.id))
                }
            }
        } message: {
            Text("Tem certeza que deseja remover este filme dos seus favoritos?")
        }
    }

    private func confirmRemoval(_ movie: FavoriteMovie) {
        movieToDelete = movie
        showingDeleteConfirmation = true
    }

    private func shareList() {
        #if canImport(UIKit)
        let movieTitles = viewState.favorites.map { "• \($0.title)" }.joined(separator: "\n")
        let shareText =
            "Confira meus filmes favoritos no app!\n\n\(movieTitles)\n\nBaixe o app para ver mais recomendações."
        let activityVC = UIActivityViewController(
            activityItems: [shareText], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootVC = windowScene.windows.first?.rootViewController
        {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
        #endif
        interactor?.handleShareFavorites(request: Favorites.ShareFavorites.Request())
    }

    private func clearAllFavorites() {
        interactor?.handleClearFavorites(request: Favorites.ClearFavorites.Request())
    }

    public final class ViewState: ObservableObject, FavoritesDisplaying {
        @Published var favorites: [FavoriteMovie] = []
        private var isInitialLoad = true

        public func displayFavorites(viewModel: Favorites.LoadFavorites.ViewModel) {
            if isInitialLoad {
                favorites = viewModel.movies
                isInitialLoad = false
            } else {
                withAnimation(.easeInOut(duration: 0.3)) {
                    favorites = viewModel.movies
                }
            }
        }

        public func displayRemovedFavorite(viewModel: Favorites.RemoveFavorite.ViewModel) {
            withAnimation(.easeInOut(duration: 0.3)) {
                favorites.removeAll { $0.id == viewModel.removedMovieId }
            }
        }

        public func displayClearedFavorites(viewModel: Favorites.ClearFavorites.ViewModel) {
            withAnimation(.easeInOut(duration: 0.5)) {
                favorites.removeAll()
            }
        }

        public func displaySharedFavorites(viewModel: Favorites.ShareFavorites.ViewModel) {
            let movieTitles = viewModel.movies.map { $0.title }
            print("Compartilhando lista de favoritos: \(movieTitles)")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(interactor: nil, viewState: .init())
    }
}
