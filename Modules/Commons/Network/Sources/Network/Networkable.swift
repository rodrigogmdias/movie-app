import Combine
import Foundation

@available(macOS 10.15, *)
public protocol Networkable: Sendable {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
    func sendRequest<T: Decodable>(
        endpoint: Endpoint, resultHandler: @escaping @Sendable (Result<T, NetworkError>) -> Void)
    func sendRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<
        T, NetworkError
    >
}
