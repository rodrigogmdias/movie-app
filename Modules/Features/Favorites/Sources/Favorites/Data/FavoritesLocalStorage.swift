import SharedPreferences

class FavoritesLocalStorage {
    private let sharedPreferences: SharedPreferences
    private let favoritesKey = "user_favorites"

    init(sharedPreferences: SharedPreferences = SharedPreferences()) {
        self.sharedPreferences = sharedPreferences
    }

    func removeFavorite(movieId: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: movieId) {
            favorites.remove(at: index)
            sharedPreferences.set(favorites, forKey: favoritesKey)
        }
    }
}
