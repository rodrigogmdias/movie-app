protocol MovieDetailPresenting {
    func handleOnLoad(request: MovieDetail.OnLoad.Response) async
}

public class MovieDetailInteractor: MovieDetailInteracting {
    private let presenter: MovieDetailPresenting
    private let movieID: Int
    private let service = MovieDetailService()
    private let localStorage = MovieDetailLocalStorage()

    init(
        presenter: MovieDetailPresenting,
        movieID: Int
    ) {
        self.presenter = presenter
        self.movieID = movieID
    }

    public func handleOnLoad(request: MovieDetail.OnLoad.Request) async {
        do {
            let movie = try await service.getMovie(id: movieID)
            let credits = try await service.getMovieCredits(id: movieID)
            await presenter.handleOnLoad(request: .init(movie: movie, credits: credits))
        } catch {
            print("Error fetching movie details: \(error)")
        }
    }

    public func toggleFavorite(title: String, coverImageUrl: String?) {
        if localStorage.isFavorite(movieId: movieID) {
            localStorage.removeFavorite(movieId: movieID)
        } else {
            let favoriteMovie = FavoriteMovie(
                id: movieID,
                title: title,
                coverImageUrl: coverImageUrl
            )
            localStorage.addFavorite(movie: favoriteMovie)
        }
    }

    public func isFavorite() -> Bool {
        return localStorage.isFavorite(movieId: movieID)
    }
}
