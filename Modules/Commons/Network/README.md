# Network Layer

Esta é uma camada de network robusta e reutilizável para iOS, implementada seguindo as melhores práticas de Swift e baseada no artigo [How to create a Network Layer for your iOS App](https://swiftpublished.com/article/create-network-layer).

## Características

- ✅ **Três abordagens de networking**: Async/Await, Combine e Closures
- ✅ **Suporte a autenticação**: Header de token automático
- ✅ **Tratamento de erros**: Enum com casos específicos
- ✅ **Parâmetros flexíveis**: Query params e path params
- ✅ **Thread-safe**: Compatível com Swift Concurrency
- ✅ **Testável**: Baseado em protocolos para fácil mocking

## Estrutura

```
Network/
├── Sources/Network/
│   ├── Endpoint.swift              # Protocolo para definir endpoints
│   ├── NetworkError.swift          # Enum de erros específicos
│   ├── Networkable.swift           # Protocolo principal de networking
│   ├── NetworkService.swift        # Implementação concreta
│   ├── RequestMethod.swift         # Enum de métodos HTTP
│   ├── NetworkExtensions.swift     # Extensões úteis
│   ├── TokenManager.swift          # Gerenciador global de tokens
│   └── NetworkUsageExample.swift   # Exemplos de uso
└── Tests/NetworkTests/
    └── NetworkTests.swift
```

## Como usar

### 1. Definir um Endpoint

```swift
enum MovieEndpoint {
    case popular
    case details(id: Int)
    case search(query: String)
}

extension MovieEndpoint: Endpoint {
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .details(let id):
            return "/3/movie/\(id)"
        case .search:
            return "/3/search/movie"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryParams: [String: String]? {
        switch self {
        case .popular, .details:
            return ["api_key": "YOUR_API_KEY"]
        case .search(let query):
            return ["api_key": "YOUR_API_KEY", "query": query]
        }
    }
    
    var authToken: String? {
        // Retorna seu token de autenticação aqui
        return "your_auth_token_here"
    }
}
```

### 2. Criar modelos de dados

```swift
struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
```

### 3. Usar a camada de network

#### Async/Await
```swift
let networkService = NetworkService()

do {
    let response: MovieResponse = try await networkService.sendRequest(
        endpoint: MovieEndpoint.popular
    )
    print("Filmes populares: \(response.results)")
} catch {
    print("Erro: \(error)")
}
```

#### Combine
```swift
let networkService = NetworkService()

networkService.sendRequest(endpoint: MovieEndpoint.popular, type: MovieResponse.self)
    .receive(on: DispatchQueue.main)
    .sink(
        receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print("Erro: \(error)")
            }
        },
        receiveValue: { response in
            print("Filmes populares: \(response.results)")
        }
    )
    .store(in: &cancellables)
```

#### Closures
```swift
let networkService = NetworkService()

networkService.sendRequest(endpoint: MovieEndpoint.popular) { (result: Result<MovieResponse, NetworkError>) in
    switch result {
    case .success(let response):
        print("Filmes populares: \(response.results)")
    case .failure(let error):
        print("Erro: \(error)")
    }
}
```

## Recursos avançados

### Headers customizados
O protocolo `Endpoint` já inclui um header padrão com suporte a token:

```swift
var header: [String: String]? {
    var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    if let token = authToken {
        headers["Authorization"] = "Bearer \(token)"
    }
    
    return headers
}
```

### Gerenciamento de Token Global
Para facilitar o uso de tokens de autenticação em toda a aplicação, você pode usar o `TokenManager`:

```swift
// Configurar o token global na inicialização do app
TokenManager.shared.setAuthToken("seu_token_de_autenticacao")

// Agora todos os endpoints usarão este token automaticamente
let networkService = NetworkService()
let profile: UserProfile = try await networkService.sendRequest(endpoint: APIEndpoint.profile)

// Limpar o token quando o usuário fazer logout
TokenManager.shared.clearAuthToken()
```

### Prioridade de Tokens
O sistema de tokens funciona com a seguinte prioridade:
1. **Token específico do endpoint** (propriedade `authToken` do endpoint)
2. **Token global** (definido no `TokenManager.shared`)
3. **Nenhum token** (header de Authorization não será incluído)

### Parâmetros de path
Para endpoints com parâmetros na URL:

```swift
var path: String {
    return "/users/{userId}/posts/{postId}"
}

var pathParams: [String: String]? {
    return ["userId": "123", "postId": "456"]
}
```

### Body para requisições POST/PUT
```swift
var body: [String: String]? {
    return ["name": "João", "email": "joao@email.com"]
}
```

## Tratamento de erros

A camada de network define os seguintes tipos de erro:

```swift
public enum NetworkError: Error, Sendable {
    case invalidURL       // URL inválida
    case unexpectedStatusCode  // Status code fora do range 200-299
    case unknown         // Erro desconhecido
    case decode         // Erro de decodificação JSON
    case noData         // Nenhum dado retornado
}
```

## Testes

Para testar sua aplicação, você pode criar um mock do `Networkable`:

```swift
class MockNetworkService: Networkable {
    var mockResponse: Any?
    var mockError: NetworkError?
    
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        if let error = mockError {
            throw error
        }
        
        if let response = mockResponse as? T {
            return response
        }
        
        throw NetworkError.decode
    }
    
    // Implementar outros métodos...
}
```

## Dependências

- Foundation
- Combine

## Compatibilidade

- iOS 13.0+
- Swift 5.5+
- Xcode 13.0+
