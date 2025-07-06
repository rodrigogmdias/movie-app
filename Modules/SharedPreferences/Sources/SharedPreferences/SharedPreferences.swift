import Foundation

class SharedPreferences {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func set<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func get<T>(forKey key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }

    func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func clear() {
        let dictionary = userDefaults.dictionaryRepresentation()
        for key in dictionary.keys {
            userDefaults.removeObject(forKey: key)
        }
    }
}
