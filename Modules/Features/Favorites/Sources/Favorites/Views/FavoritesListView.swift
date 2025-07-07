import SwiftUI

struct FavoritesListView: View {
    let movies: [String]
    let onRemoveMovie: (String) -> Void
    let onShareList: () -> Void
    let onClearAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 2),
                spacing: 16
            ) {
                ForEach(movies, id: \.self) { movie in
                    FavoriteMovieCard(movie: movie, onRemove: onRemoveMovie)
                        .transition(
                            .asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .scale.combined(with: .opacity)
                            ))
                }
            }
            .padding(.horizontal)
            .animation(.easeInOut(duration: 0.3), value: movies)

            FavoritesActionsView(
                onShareList: onShareList,
                onClearAll: onClearAll
            )
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView(
            movies: ["Filme 1", "Filme 2", "Filme 3"],
            onRemoveMovie: { _ in },
            onShareList: {},
            onClearAll: {}
        )
    }
}
