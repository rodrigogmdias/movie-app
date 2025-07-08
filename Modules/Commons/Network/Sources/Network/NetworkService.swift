import Combine
import Foundation

@available(macOS 10.15, *)
public final class NetworkService: Networkable {

    public init() {}

    // MARK: - Async/Await Implementation
    public func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            throw NetworkError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
                .dataTask(with: urlRequest) { data, response, _ in
                    guard response is HTTPURLResponse else {
                        continuation.resume(throwing: NetworkError.invalidURL)
                        return
                    }

                    guard let response = response as? HTTPURLResponse,
                        200...299 ~= response.statusCode
                    else {
                        continuation.resume(throwing: NetworkError.unexpectedStatusCode)
                        return
                    }

                    guard let data = data else {
                        continuation.resume(throwing: NetworkError.noData)
                        return
                    }

                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        continuation.resume(throwing: NetworkError.decode)
                        return
                    }

                    continuation.resume(returning: decodedResponse)
                }
            task.resume()
        }
    }

    // MARK: - Closure Implementation
    public func sendRequest<T: Decodable>(
        endpoint: Endpoint, resultHandler: @escaping @Sendable (Result<T, NetworkError>) -> Void
    ) {
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            resultHandler(.failure(.invalidURL))
            return
        }

        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                resultHandler(.failure(.unknown))
                return
            }

            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode
            else {
                resultHandler(.failure(.unexpectedStatusCode))
                return
            }

            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }

            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                resultHandler(.failure(.decode))
                return
            }

            resultHandler(.success(decodedResponse))
        }
        urlTask.resume()
    }

    // MARK: - Combine Implementation
    public func sendRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<
        T, NetworkError
    > {
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode
                else {
                    throw NetworkError.unexpectedStatusCode
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if error is DecodingError {
                    return NetworkError.decode
                } else if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private Helper Methods
extension NetworkService {
    private func createRequest(endPoint: Endpoint) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path

        if let queryParams = endPoint.queryParams, !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        var finalPath = endPoint.path
        if let pathParams = endPoint.pathParams {
            for (key, value) in pathParams {
                finalPath = finalPath.replacingOccurrences(of: "{\(key)}", with: value)
            }
            urlComponents.path = finalPath
        }

        guard let url = urlComponents.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header

        if let body = endPoint.body, !body.isEmpty {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                return nil
            }
        }

        return request
    }
}
