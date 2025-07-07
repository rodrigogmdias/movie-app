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
    @State private var hasAppeared = false

    public init(interactor: FavoritesInteracting?, viewState: ViewState) {
        self.interactor = interactor
        self.viewState = viewState
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Seus Favoritos ❤️")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)

                            Text("\(viewState.favorites.count) filmes salvos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button(action: {
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .animation(.easeInOut(duration: 0.3), value: viewState.favorites.count)

                    if viewState.favorites.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "heart.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)

                            Text("Nenhum filme favorito ainda")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Explore o catálogo e adicione seus filmes favoritos aqui!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)

                            Button(action: {
                                NotificationCenter.default.post(
                                    name: NSNotification.Name("GoToHome"), object: nil)
                            }) {
                                Text("Explorar Catálogo")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 40)
                        }
                        .padding(.vertical, 60)
                        .transition(hasAppeared ? .asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ) : .identity)
                    } else {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible()), count: 2),
                            spacing: 16
                        ) {
                            ForEach(viewState.favorites, id: \.self) { movie in
                                favoriteMovieCard(movie: movie)
                                    .transition(.asymmetric(
                                        insertion: .scale.combined(with: .opacity),
                                        removal: .scale.combined(with: .opacity)
                                    ))
                            }
                        }
                        .padding(.horizontal)
                        .animation(.easeInOut(duration: 0.3), value: viewState.favorites)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Ações Rápidas")
                                .font(.headline)
                                .padding(.horizontal)

                            VStack(spacing: 8) {
                                quickActionButton(
                                    icon: "square.and.arrow.up",
                                    title: "Compartilhar Lista",
                                    action: shareList
                                )

                                quickActionButton(
                                    icon: "trash",
                                    title: "Limpar Favoritos",
                                    action: clearAllFavorites,
                                    isDestructive: true
                                )
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                }        }
        .onAppear {
            interactor?.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
            hasAppeared = true
        }
        .refreshable {
            interactor?.handleLoadFavorites(request: Favorites.LoadFavorites.Request())
        }
        }
        .alert("Remover dos Favoritos", isPresented: $showingDeleteConfirmation) {
            Button("Cancelar", role: .cancel) {}
            Button("Remover", role: .destructive) {
                if let item = itemToDelete {
                    interactor?.handleRemoveFavorite(request: Favorites.RemoveFavorite.Request(movie: item))
                }
            }
        } message: {
            Text("Tem certeza que deseja remover este filme dos seus favoritos?")
        }
    }

    @ViewBuilder
    private func favoriteMovieCard(movie: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 200)
                .overlay(
                    VStack {
                        Image(systemName: "film")
                            .font(.system(size: 40))
                            .foregroundColor(.white)

                        Text(movie)
                            .font(.caption)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 4)
                    }
                )
                .cornerRadius(12)
                .overlay(
                    Button(action: {
                        confirmRemoval(movie)
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundColor(.red)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 30, height: 30)
                            )
                    }
                    .padding(8),
                    alignment: .topTrailing
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(movie)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)

                    Text("4.5")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text("2023")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    @ViewBuilder
    private func quickActionButton(
        icon: String,
        title: String,
        action: @escaping () -> Void,
        isDestructive: Bool = false
    ) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(isDestructive ? .red : .blue)

                Text(title)
                    .font(.subheadline)
                    .foregroundColor(isDestructive ? .red : .primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
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
