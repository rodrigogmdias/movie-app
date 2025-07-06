import Network

final class CatalogService: Sendable {
    private let networkService: Networkable

    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }

    func getPopularMovies() async throws -> MovieResponse {
        return try await networkService.sendRequest(endpoint: CatalogEndpoint.popular)
    }
}
