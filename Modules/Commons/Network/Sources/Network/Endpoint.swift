import Foundation
import Session

public protocol Endpoint {
    var host: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var pathParams: [String: String]? { get }
    var authToken: String? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return ""
    }
    var authToken: String? {
        return SessionManager.shared.sessionToken
    }

    var header: [String: String]? {
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]

        if let token = authToken {
            headers["Authorization"] = "Bearer \(token)"
        }

        return headers
    }
}
