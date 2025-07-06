import Network

final class MovieDetailService: Sendable {
    private let networkService: Networkable

    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }

    func getMovie(id: Int) async throws -> MovieDetailResponse {
        return try await networkService.sendRequest(
            endpoint: MovieDetailEndpoint.movieDetail(id: id))
    }

    func getMovieCredits(id: Int) async throws -> MovieDetailCreditsResponse {
        return try await networkService.sendRequest(
            endpoint: MovieDetailEndpoint.movieCredits(id: id))
    }
}
