import Network

enum MovieDetailEndpoint {
    case movieDetail(id: Int)
    case movieCredits(id: Int)
}

extension MovieDetailEndpoint: Endpoint {
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
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .movieCredits(let id):
            return "/3/movie/\(id)/credits"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var queryParams: [String: String]? {
        switch self {
        case .movieDetail, .movieCredits:
            return [
                "api_key": "052969f23bc6cb32135ec7d21bdea2ed",
                "language": "pt-BR"
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
