import Foundation

public final class SessionManager: @unchecked Sendable {
    public static let shared = SessionManager()

    private var _sessionToken: String?
    private let queue = DispatchQueue(label: "com.movie.sessionmanager", attributes: .concurrent)

    private init() {}

    public func setSessionToken(_ token: String?) {
        queue.async(flags: .barrier) { [weak self] in
            self?._sessionToken = token
        }
    }

    public var sessionToken: String? {
        return queue.sync {
            return _sessionToken
        }
    }

    public func clearSessionToken() {
        setSessionToken(nil)
    }

    public var hasValidSession: Bool {
        return sessionToken != nil && !sessionToken!.isEmpty
    }
}
