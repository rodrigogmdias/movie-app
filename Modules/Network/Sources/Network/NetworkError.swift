import Foundation

public enum NetworkError: Error, Sendable {
    case invalidURL
    case unexpectedStatusCode
    case unknown
    case decode
    case noData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .unexpectedStatusCode:
            return "Status de resposta inesperado"
        case .unknown:
            return "Erro desconhecido"
        case .decode:
            return "Erro ao decodificar a resposta"
        case .noData:
            return "Nenhum dado retornado"
        }
    }
}
