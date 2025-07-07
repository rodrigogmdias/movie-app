import Foundation

public class SharedPreferences {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func set<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    public func get<T>(forKey key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }

    public func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    public func clear() {
        let dictionary = userDefaults.dictionaryRepresentation()
        for key in dictionary.keys {
            userDefaults.removeObject(forKey: key)
        }
    }
}
