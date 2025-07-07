public enum Favorites {
    public enum LoadFavorites {
        public struct Request {
            public init() {}
        }
        
        public struct Response {
            public let movies: [String]
            
            public init(movies: [String]) {
                self.movies = movies
            }
        }
        
        public struct ViewModel {
            public let movies: [String]
            
            public init(movies: [String]) {
                self.movies = movies
            }
        }
    }
    
    public enum RemoveFavorite {
        public struct Request {
            public let movie: String
            
            public init(movie: String) {
                self.movie = movie
            }
        }
        
        public struct Response {
            public let removedMovie: String
            
            public init(removedMovie: String) {
                self.removedMovie = removedMovie
            }
        }
        
        public struct ViewModel {
            public let removedMovie: String
            
            public init(removedMovie: String) {
                self.removedMovie = removedMovie
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
            public let movies: [String]
            
            public init(movies: [String]) {
                self.movies = movies
            }
        }
        
        public struct ViewModel {
            public let movies: [String]
            
            public init(movies: [String]) {
                self.movies = movies
            }
        }
    }
}
