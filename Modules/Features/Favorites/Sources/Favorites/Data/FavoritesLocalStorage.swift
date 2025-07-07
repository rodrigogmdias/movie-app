import SharedPreferences

class FavoritesLocalStorage {
    private let sharedPreferences: SharedPreferences
    private let favoritesKey = "user_favorites"

    init(sharedPreferences: SharedPreferences = SharedPreferences()) {
        self.sharedPreferences = sharedPreferences
    }

    func addFavorite(movieId: Int) {
        var favorites = getFavorites()
        if !favorites.contains(movieId) {
            favorites.append(movieId)
            sharedPreferences.set(favorites, forKey: favoritesKey)
        }
    }

    func removeFavorite(movieId: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: movieId) {
            favorites.remove(at: index)
            sharedPreferences.set(favorites, forKey: favoritesKey)
        }
    }

    func isFavorite(movieId: Int) -> Bool {
        return getFavorites().contains(movieId)
    }

    func getFavorites() -> [Int] {
        return sharedPreferences.get(forKey: favoritesKey) ?? []
    }
}
