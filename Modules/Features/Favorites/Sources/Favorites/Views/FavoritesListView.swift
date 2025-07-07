import SwiftUI

struct FavoritesListView: View {
    let movies: [FavoriteMovie]
    let onRemoveMovie: (FavoriteMovie) -> Void
    let onShareList: () -> Void
    let onClearAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 2),
                spacing: 16
            ) {
                ForEach(movies) { movie in
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
            movies: [
                FavoriteMovie(id: 1, title: "Filme 1", coverImageUrl: nil),
                FavoriteMovie(id: 2, title: "Filme 2", coverImageUrl: nil),
                FavoriteMovie(id: 3, title: "Filme 3", coverImageUrl: nil),
            ],
            onRemoveMovie: { _ in },
            onShareList: {},
            onClearAll: {}
        )
    }
}
