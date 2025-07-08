import Network

enum CatalogEndpoint {
    case popular
    case topRated
    case search(query: String, page: Int)
}

extension CatalogEndpoint: Endpoint {
    var scheme: String {
        return "https"
    }

    var header: [String: String]? {
        return nil
    }

    var authToken: String? {
        return nil
    }

    var host: String {
        return "api.themoviedb.org"
    }

    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .search:
            return "/3/search/movie"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var queryParams: [String: String]? {
        switch self {
        case .popular:
            return [
                "api_key": "052969f23bc6cb32135ec7d21bdea2ed",
                "language": "pt-BR",
            ]
        case .topRated:
            return [
                "api_key": "052969f23bc6cb32135ec7d21bdea2ed",
                "language": "pt-BR",
            ]
        case .search(let query, let page):
            return [
                "api_key": "052969f23bc6cb32135ec7d21bdea2ed",
                "language": "pt-BR",
                "query": query,
                "page": "\(page)",
            ]
        }
    }

    var body: [String: String]? {
        return nil
    }

    var pathParams: [String: String]? {
        return nil
    }
}
