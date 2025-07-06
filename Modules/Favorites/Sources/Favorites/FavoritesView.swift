import SwiftUI

protocol FavoritesInteracting {
}

public struct FavoritesView: View {
    @State private var favorites: [String] = [
        "Vingadores: Ultimato",
        "Coringa",
        "Parasita",
        "1917",
        "Era uma Vez em... Hollywood",
        "Pantera Negra",
        "Oppenheimer",
        "Barbie",
    ]

    @State private var showingDeleteConfirmation = false
    @State private var itemToDelete: String?

    public init() {}

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

                            Text("\(favorites.count) filmes salvos")
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

                    if favorites.isEmpty {
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
                    } else {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible()), count: 2),
                            spacing: 16
                        ) {
                            ForEach(favorites, id: \.self) { movie in
                                favoriteMovieCard(movie: movie)
                            }
                        }
                        .padding(.horizontal)

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
                }
            }
            .refreshable {
            }
        }
        .alert("Remover dos Favoritos", isPresented: $showingDeleteConfirmation) {
            Button("Cancelar", role: .cancel) {}
            Button("Remover", role: .destructive) {
                if let item = itemToDelete {
                    removeFromFavorites(item)
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
        withAnimation {
            favorites.removeAll { $0 == movie }
        }
        itemToDelete = nil
    }

    private func shareList() {
        print("Compartilhando lista de favoritos")
    }

    private func clearAllFavorites() {
        withAnimation {
            favorites.removeAll()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
