//
//  CatalogService.swift
//  Catalog
//
//  Created by Rodrigo Dias on 05/07/25.
//
import Network

final class CatalogService {
    private let networkService: Networkable

    init(networkService: Networkable = NetworkService()) {
        self.networkService = networkService
    }
    
    func getPopularMovies() async throws -> MovieResponse {
        return try await networkService.sendRequest(endpoint: CatalogEndpoint.popular)
    }
}
