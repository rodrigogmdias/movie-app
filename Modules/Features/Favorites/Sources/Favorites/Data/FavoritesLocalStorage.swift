import Foundation
import SharedPreferences

public class FavoritesLocalStorage {
    private let sharedPreferences: SharedPreferences
    private let favoritesKey = "user_favorites"

    public init(sharedPreferences: SharedPreferences = SharedPreferences()) {
        self.sharedPreferences = sharedPreferences
    }

    public func addFavorite(movie: FavoriteMovie) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
            saveFavorites(favorites)
        }
    }

    public func removeFavorite(movieId: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(where: { $0.id == movieId }) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }

    public func isFavorite(movieId: Int) -> Bool {
        return getFavorites().contains(where: { $0.id == movieId })
    }

    public func getFavorites() -> [FavoriteMovie] {
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

    public func clearFavorites() {
        sharedPreferences.set(Data(), forKey: favoritesKey)
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
