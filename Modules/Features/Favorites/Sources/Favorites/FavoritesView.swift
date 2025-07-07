import SwiftUI

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
    @State private var itemToDelete: String?

    public init(interactor: FavoritesInteracting?, viewState: ViewState) {
        self.interactor = interactor
        self.viewState = viewState
    }

    public var body: some View {
        NavigationView {
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
                if let item = itemToDelete {
                    interactor?.handleRemoveFavorite(
                        request: Favorites.RemoveFavorite.Request(movie: item))
                }
            }
        } message: {
            Text("Tem certeza que deseja remover este filme dos seus favoritos?")
        }
    }

    private func confirmRemoval(_ movie: String) {
        itemToDelete = movie
        showingDeleteConfirmation = true
    }

    private func removeFromFavorites(_ movie: String) {
        interactor?.handleRemoveFavorite(request: Favorites.RemoveFavorite.Request(movie: movie))
        itemToDelete = nil
    }

    private func shareList() {
        interactor?.handleShareFavorites(request: Favorites.ShareFavorites.Request())
    }

    private func clearAllFavorites() {
        interactor?.handleClearFavorites(request: Favorites.ClearFavorites.Request())
    }

    public final class ViewState: ObservableObject, FavoritesDisplaying {
        @Published var favorites: [String] = []
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
                favorites.removeAll { $0 == viewModel.removedMovie }
            }
        }

        public func displayClearedFavorites(viewModel: Favorites.ClearFavorites.ViewModel) {
            withAnimation(.easeInOut(duration: 0.5)) {
                favorites.removeAll()
            }
        }

        public func displaySharedFavorites(viewModel: Favorites.ShareFavorites.ViewModel) {
            print("Compartilhando lista de favoritos: \(viewModel.movies)")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(interactor: nil, viewState: .init())
    }
}
