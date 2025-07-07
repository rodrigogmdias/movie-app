import Foundation
import SharedPreferences

class MovieDetailLocalStorage {
    private let sharedPreferences: SharedPreferences
    private let favoritesKey = "user_favorites"

    init(sharedPreferences: SharedPreferences = SharedPreferences()) {
        self.sharedPreferences = sharedPreferences
    }

    func addFavorite(movie: FavoriteMovie) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(movieId: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(where: { $0.id == movieId }) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }

    func isFavorite(movieId: Int) -> Bool {
        return getFavorites().contains(where: { $0.id == movieId })
    }

    func getFavorites() -> [FavoriteMovie] {
        guard let data: Data = sharedPreferences.get(forKey: favoritesKey) else {
            return []
        }

        do {
            let favorites = try JSONDecoder().decode([FavoriteMovie].self, from: data)
            return favorites
        } catch {
            print("Error decoding favorites: \(error)")
            return []
        }
    }

    private func saveFavorites(_ favorites: [FavoriteMovie]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            sharedPreferences.set(data, forKey: favoritesKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }
}
