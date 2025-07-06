protocol MovieDetailDisplaying: AnyObject {
    func displayOnLoad(viewModel: MovieDetail.OnLoad.ViewModel)
}

@MainActor
public class MovieDetailPresenter: MovieDetailPresenting {
    weak var display: MovieDetailDisplaying?

    func handleOnLoad(request: MovieDetail.OnLoad.Response) async {
        let movie = request.movie
        let credits = request.credits

        display?.displayOnLoad(
            viewModel: .init(
                synopsis: movie.overview,
                rating: movie.voteAverage,
                duration: String(movie.runtime ?? 0) + " min",
                genres: movie.genres?.map { $0.name ?? "Unknown" } ?? [],
                releaseDate: movie.releaseDate,
                director: credits.director?.name,
                cast: credits.mainCast.compactMap { cast in
                    guard let id = cast.id else { return nil }
                    return MovieDetail.OnLoad.CastMember(
                        id: id,
                        name: cast.name ?? "Unknown",
                        character: cast.character,
                        profileURL: cast.profileURL()
                    )
                }
            ))
    }
}
