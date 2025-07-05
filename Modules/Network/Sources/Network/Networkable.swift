import Combine
import Foundation

public protocol Networkable {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
    func sendRequest<T: Decodable>(
        endpoint: Endpoint, resultHandler: @escaping @Sendable (Result<T, NetworkError>) -> Void)
    func sendRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<
        T, NetworkError
    >
}
