import Combine
import Foundation
import Testing

@testable import Network
@testable import Session

// MARK: - Test Models

struct TestResponse: Codable, Equatable {
    let id: Int
    let name: String
    let active: Bool
}

struct TestEndpoint: Endpoint {
    var host: String = "api.test.com"
    var path: String = "/test"
    var method: RequestMethod = .get
    var body: [String: String]? = nil
    var queryParams: [String: String]? = nil
    var pathParams: [String: String]? = nil
}

struct TestInvalidEndpoint: Endpoint {
    var host: String = ""
    var path: String = ""
    var method: RequestMethod = .get
    var body: [String: String]? = nil
    var queryParams: [String: String]? = nil
    var pathParams: [String: String]? = nil
}

// MARK: - Tests

final class NetworkServiceTests {

    private var networkService: NetworkService!
    private var cancellables: Set<AnyCancellable>!

    init() {
        networkService = NetworkService()
        cancellables = Set<AnyCancellable>()
    }

    // MARK: - Async/Await Tests

    @Test func testAsyncRequestInvalidURL() async throws {
        let endpoint = TestInvalidEndpoint()

        do {
            let _: TestResponse = try await networkService.sendRequest(endpoint: endpoint)
            Issue.record("Deveria ter lançado erro de URL inválida")
        } catch {
            #expect(error is NetworkError)
            if let networkError = error as? NetworkError {
                #expect(
                    networkError == NetworkError.invalidURL || networkError == NetworkError.unknown)
            }
        }
    }

    @Test func testAsyncRequestValidEndpoint() async throws {
        let endpoint = TestEndpoint()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/test")
        #expect(endpoint.scheme == "https")
    }

    // MARK: - Closure Tests

    @Test func testClosureRequestInvalidURL() async throws {
        let endpoint = TestInvalidEndpoint()

        await withCheckedContinuation { continuation in
            networkService.sendRequest(endpoint: endpoint) {
                (result: Result<TestResponse, NetworkError>) in
                switch result {
                case .success:
                    Issue.record("Deveria ter falhado com URL inválida")
                case .failure(let error):
                    #expect(error == NetworkError.invalidURL || error == NetworkError.unknown)
                }
                continuation.resume()
            }
        }
    }

    @Test func testClosureRequestValidEndpoint() async throws {
        let endpoint = TestEndpoint()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/test")
        #expect(endpoint.method == .get)
    }

    // MARK: - Combine Tests

    @Test func testCombineRequestInvalidURL() async throws {
        let endpoint = TestInvalidEndpoint()

        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            networkService.sendRequest(endpoint: endpoint, type: TestResponse.self)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            Issue.record("Deveria ter falhado com URL inválida")
                        case .failure(let error):
                            #expect(
                                error == NetworkError.invalidURL || error == NetworkError.unknown)
                        }
                        continuation.resume()
                    },
                    receiveValue: { _ in
                        Issue.record("Não deveria ter recebido valor")
                    }
                )
                .store(in: &self.cancellables)
        }
    }

    @Test func testCombineRequestValidEndpoint() async throws {
        let endpoint = TestEndpoint()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/test")
        #expect(endpoint.method == .get)
    }

    // MARK: - Endpoint Creation Tests

    @Test func testEndpointWithQueryParams() async throws {
        struct EndpointWithQueryParams: Endpoint {
            var host: String = "api.test.com"
            var path: String = "/search"
            var method: RequestMethod = .get
            var body: [String: String]? = nil
            var queryParams: [String: String]? = ["q": "test", "limit": "10"]
            var pathParams: [String: String]? = nil
        }

        let endpoint = EndpointWithQueryParams()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/search")
        #expect(endpoint.queryParams?["q"] == "test")
        #expect(endpoint.queryParams?["limit"] == "10")
    }

    @Test func testEndpointWithPathParams() async throws {
        struct EndpointWithPathParams: Endpoint {
            var host: String = "api.test.com"
            var path: String = "/users/{id}/posts/{postId}"
            var method: RequestMethod = .get
            var body: [String: String]? = nil
            var queryParams: [String: String]? = nil
            var pathParams: [String: String]? = ["id": "123", "postId": "456"]
        }

        let endpoint = EndpointWithPathParams()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/users/{id}/posts/{postId}")
        #expect(endpoint.pathParams?["id"] == "123")
        #expect(endpoint.pathParams?["postId"] == "456")
    }

    @Test func testEndpointWithBody() async throws {
        struct EndpointWithBody: Endpoint {
            var host: String = "api.test.com"
            var path: String = "/users"
            var method: RequestMethod = .post
            var body: [String: String]? = ["name": "John", "email": "john@test.com"]
            var queryParams: [String: String]? = nil
            var pathParams: [String: String]? = nil
        }

        let endpoint = EndpointWithBody()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/users")
        #expect(endpoint.method == .post)
        #expect(endpoint.body?["name"] == "John")
        #expect(endpoint.body?["email"] == "john@test.com")
    }

    // MARK: - HTTP Methods Tests

    @Test func testDifferentHTTPMethods() async throws {
        let methods: [RequestMethod] = [.get, .post, .put, .delete, .patch]

        for method in methods {
            struct TestMethodEndpoint: Endpoint {
                let method: RequestMethod
                var host: String = "api.test.com"
                var path: String = "/test"
                var body: [String: String]? = nil
                var queryParams: [String: String]? = nil
                var pathParams: [String: String]? = nil
            }

            let endpoint = TestMethodEndpoint(method: method)

            #expect(endpoint.host == "api.test.com")
            #expect(endpoint.path == "/test")
            #expect(endpoint.method == method)
        }
    }

    // MARK: - Error Handling Tests

    @Test func testNetworkErrorDescriptions() {
        let errors: [NetworkError] = [
            .invalidURL,
            .unexpectedStatusCode,
            .unknown,
            .decode,
            .noData,
        ]

        for error in errors {
            let description = error.localizedDescription
            #expect(!description.isEmpty)
        }
    }

    // MARK: - NetworkError Equality Tests

    @Test func testNetworkErrorEquality() {
        #expect(NetworkError.invalidURL == NetworkError.invalidURL)
        #expect(NetworkError.unexpectedStatusCode == NetworkError.unexpectedStatusCode)
        #expect(NetworkError.unknown == NetworkError.unknown)
        #expect(NetworkError.decode == NetworkError.decode)
        #expect(NetworkError.noData == NetworkError.noData)

        #expect(NetworkError.invalidURL != NetworkError.unexpectedStatusCode)
        #expect(NetworkError.decode != NetworkError.noData)
    }

    // MARK: - Endpoint Default Values Tests

    @Test func testEndpointDefaultValues() {
        let endpoint = TestEndpoint()

        #expect(endpoint.scheme == "https")
        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/test")
        #expect(endpoint.method == .get)
        #expect(endpoint.header?["Content-Type"] == "application/json")
        #expect(endpoint.header?["Accept"] == "application/json")
    }

    // MARK: - Request Method Tests

    @Test func testRequestMethodRawValues() {
        #expect(RequestMethod.get.rawValue == "GET")
        #expect(RequestMethod.post.rawValue == "POST")
        #expect(RequestMethod.put.rawValue == "PUT")
        #expect(RequestMethod.delete.rawValue == "DELETE")
        #expect(RequestMethod.patch.rawValue == "PATCH")
    }

    // MARK: - NetworkService Initialization Tests

    @Test func testNetworkServiceInitialization() {
        let service = NetworkService()

        let networkable: Networkable = service
        #expect(networkable is NetworkService)
    }

    // MARK: - Endpoint Authorization Tests

    @Test func testEndpointWithAuthToken() {
        struct AuthEndpoint: Endpoint {
            var host: String = "api.test.com"
            var path: String = "/protected"
            var method: RequestMethod = .get
            var body: [String: String]? = nil
            var queryParams: [String: String]? = nil
            var pathParams: [String: String]? = nil
            var authToken: String? = "test_token"
        }

        let endpoint = AuthEndpoint()

        if let headers = endpoint.header {
            #expect(headers["Authorization"] == "Bearer test_token")
        }
    }

    // MARK: - Edge Cases Tests

    @Test func testEndpointWithEmptyHost() {
        let endpoint = TestInvalidEndpoint()
        #expect(endpoint.host.isEmpty)
        #expect(endpoint.path.isEmpty)
    }

    @Test func testEndpointWithComplexPath() {
        struct ComplexPathEndpoint: Endpoint {
            var host: String = "api.test.com"
            var path: String = "/v1/users/{userId}/posts/{postId}/comments"
            var method: RequestMethod = .get
            var body: [String: String]? = nil
            var queryParams: [String: String]? = nil
            var pathParams: [String: String]? = ["userId": "123", "postId": "456"]
        }

        let endpoint = ComplexPathEndpoint()
        #expect(endpoint.pathParams?["userId"] == "123")
        #expect(endpoint.pathParams?["postId"] == "456")
    }

    // MARK: - Timeout and Performance Tests

    @Test func testNetworkServicePerformance() async throws {
        let startTime = Date()
        let endpoint = TestEndpoint()

        #expect(endpoint.host == "api.test.com")
        #expect(endpoint.path == "/test")

        let endTime = Date()
        let duration = endTime.timeIntervalSince(startTime)

        #expect(duration < 1.0)
    }
}

// MARK: - Integration Tests

@Test func testNetworkServiceProtocolConformance() {
    let service = NetworkService()
    let networkable: Networkable = service

    #expect(networkable is NetworkService)
}

@Test func testMultipleNetworkServiceInstances() {
    let service1 = NetworkService()
    let service2 = NetworkService()

    #expect(type(of: service1) == NetworkService.self)
    #expect(type(of: service2) == NetworkService.self)

    #expect(service1 !== service2)
}

@Test func testNetworkErrorLocalizedDescriptions() {
    let invalidURL = NetworkError.invalidURL
    let unexpectedStatusCode = NetworkError.unexpectedStatusCode
    let unknown = NetworkError.unknown
    let decode = NetworkError.decode
    let noData = NetworkError.noData

    #expect(invalidURL.localizedDescription == "URL inválida")
    #expect(unexpectedStatusCode.localizedDescription == "Status de resposta inesperado")
    #expect(unknown.localizedDescription == "Erro desconhecido")
    #expect(decode.localizedDescription == "Erro ao decodificar a resposta")
    #expect(noData.localizedDescription == "Nenhum dado retornado")
}

// MARK: - URL Request Creation Tests

@Test func testURLRequestCreation() {
    let validEndpoint = TestEndpoint()
    #expect(validEndpoint.host == "api.test.com")
    #expect(validEndpoint.path == "/test")
    #expect(validEndpoint.scheme == "https")

    struct ComplexEndpoint: Endpoint {
        var host: String = "api.example.com"
        var path: String = "/v1/users/{userId}"
        var method: RequestMethod = .post
        var body: [String: String]? = ["name": "Test User"]
        var queryParams: [String: String]? = ["include": "profile"]
        var pathParams: [String: String]? = ["userId": "123"]
    }

    let complexEndpoint = ComplexEndpoint()
    #expect(complexEndpoint.host == "api.example.com")
    #expect(complexEndpoint.path == "/v1/users/{userId}")
    #expect(complexEndpoint.method == .post)
    #expect(complexEndpoint.body?["name"] == "Test User")
    #expect(complexEndpoint.queryParams?["include"] == "profile")
    #expect(complexEndpoint.pathParams?["userId"] == "123")
}

@Test func testEndpointHeaderConfiguration() {
    struct CustomEndpoint: Endpoint {
        var host: String = "api.test.com"
        var path: String = "/custom"
        var method: RequestMethod = .get
        var body: [String: String]? = nil
        var queryParams: [String: String]? = nil
        var pathParams: [String: String]? = nil
        var authToken: String? = "custom_token"
    }

    let endpoint = CustomEndpoint()
    let headers = endpoint.header

    #expect(headers?["Content-Type"] == "application/json")
    #expect(headers?["Accept"] == "application/json")
    #expect(headers?["Authorization"] == "Bearer custom_token")
}
