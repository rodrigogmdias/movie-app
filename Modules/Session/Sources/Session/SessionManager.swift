import Foundation

public final class SessionManager: @unchecked Sendable {
    public static let shared = SessionManager()

    private var _sessionToken: String?
    private let queue = DispatchQueue(label: "com.movie.sessionmanager", attributes: .concurrent)

    private init() {}

    /// Define o token de sessão global
    public func setSessionToken(_ token: String?) {
        queue.async(flags: .barrier) { [weak self] in
            self?._sessionToken = token
        }
    }

    /// Obtém o token de sessão atual
    public var sessionToken: String? {
        return queue.sync {
            return _sessionToken
        }
    }

    /// Remove o token de sessão
    public func clearSessionToken() {
        setSessionToken(nil)
    }

    /// Verifica se existe um token de sessão válido
    public var hasValidSession: Bool {
        return sessionToken != nil && !sessionToken!.isEmpty
    }
}
