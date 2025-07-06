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
}
