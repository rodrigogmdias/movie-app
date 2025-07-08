import Network

final class CatalogService: Sendable {
    private let networkService: Networkable

    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }

    func getPopularMovies() async throws -> MovieResponse {
        return try await networkService.sendRequest(endpoint: CatalogEndpoint.popular)
    }

    func searchMovies(query: String, page: Int = 1) async throws -> MovieResponse {
        return try await networkService.sendRequest(
            endpoint: CatalogEndpoint.search(query: query, page: page))
    }
}
