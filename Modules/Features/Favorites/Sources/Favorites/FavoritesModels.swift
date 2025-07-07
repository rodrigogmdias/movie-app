public enum Favorites {
    public enum LoadFavorites {
        public struct Request {
            public init() {}
        }

        public struct Response {
            public let movies: [FavoriteMovie]

            public init(movies: [FavoriteMovie]) {
                self.movies = movies
            }
        }

        public struct ViewModel {
            public let movies: [FavoriteMovie]

            public init(movies: [FavoriteMovie]) {
                self.movies = movies
            }
        }
    }

    public enum RemoveFavorite {
        public struct Request {
            public let movieId: Int

            public init(movieId: Int) {
                self.movieId = movieId
            }
        }

        public struct Response {
            public let removedMovieId: Int

            public init(removedMovieId: Int) {
                self.removedMovieId = removedMovieId
            }
        }

        public struct ViewModel {
            public let removedMovieId: Int

            public init(removedMovieId: Int) {
                self.removedMovieId = removedMovieId
            }
        }
    }

    public enum ClearFavorites {
        public struct Request {
            public init() {}
        }

        public struct Response {
            public init() {}
        }

        public struct ViewModel {
            public init() {}
        }
    }

    public enum ShareFavorites {
        public struct Request {
            public init() {}
        }

        public struct Response {
            public let movies: [FavoriteMovie]

            public init(movies: [FavoriteMovie]) {
                self.movies = movies
            }
        }

        public struct ViewModel {
            public let movies: [FavoriteMovie]

            public init(movies: [FavoriteMovie]) {
                self.movies = movies
            }
        }
    }
}
