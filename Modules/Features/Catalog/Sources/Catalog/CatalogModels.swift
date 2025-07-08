enum Catalog {
    enum OnAppear {
        struct Request {}
    }

    enum DidLoadPopularMovies {
        struct Request {}

        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            enum Status {
                case loading
                case loaded
                case failure(Error)
            }

            let movies: [Movie]
            let status: Status
        }
    }

    enum DidLoadTopRatedMovies {
        struct Request {}

        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            enum Status {
                case loading
                case loaded
                case failure(Error)
            }

            let movies: [Movie]
            let status: Status
        }
    }

    enum SearchMovies {
        struct Request {
            let query: String
            let page: Int
            let isAppending: Bool
        }

        struct Response {
            let movies: [Movie]
            let page: Int
            let totalPages: Int
            let isAppending: Bool
        }

        struct ViewModel {
            enum Status {
                case idle
                case loading
                case loaded
                case failure(Error)
            }

            let movies: [Movie]
            let status: Status
            let canLoadMore: Bool
            let isAppending: Bool
        }
    }
}
