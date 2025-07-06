import Foundation
import Testing

@testable import SharedPreferences

@Test func testSetAndGetString() {
    let userDefaults = UserDefaults(suiteName: "TestSuiteString")!
    let sharedPreferences = SharedPreferences(userDefaults: userDefaults)
    let key = "testStringKey"
    let value = "testStringValue"

    sharedPreferences.set(value, forKey: key)
    let retrievedValue: String? = sharedPreferences.get(forKey: key)

    #expect(retrievedValue == value)

    userDefaults.removePersistentDomain(forName: "TestSuiteString")
}

@Test func testRemoveValue() {
    let userDefaults = UserDefaults(suiteName: "TestSuiteRemove")!
    let sharedPreferences = SharedPreferences(userDefaults: userDefaults)
    let key = "testRemoveKey"
    let value = "testRemoveValue"

    sharedPreferences.set(value, forKey: key)
    var retrievedValue: String? = sharedPreferences.get(forKey: key)
    #expect(retrievedValue == value)

    sharedPreferences.removeValue(forKey: key)
    retrievedValue = sharedPreferences.get(forKey: key)

    #expect(retrievedValue == nil)

    userDefaults.removePersistentDomain(forName: "TestSuiteRemove")
}

@Test func testClear() {
    let userDefaults = UserDefaults(suiteName: "TestSuiteClear")!
    let sharedPreferences = SharedPreferences(userDefaults: userDefaults)
    let key1 = "testClearKey1"
    let value1 = "testClearValue1"
    let key2 = "testClearKey2"
    let value2 = "testClearValue2"

    sharedPreferences.set(value1, forKey: key1)
    sharedPreferences.set(value2, forKey: key2)

    var retrievedValue1: String? = sharedPreferences.get(forKey: key1)
    var retrievedValue2: String? = sharedPreferences.get(forKey: key2)
    #expect(retrievedValue1 == value1)
    #expect(retrievedValue2 == value2)

    sharedPreferences.clear()

    retrievedValue1 = sharedPreferences.get(forKey: key1)
    retrievedValue2 = sharedPreferences.get(forKey: key2)

    #expect(retrievedValue1 == nil)
    #expect(retrievedValue2 == nil)

    userDefaults.removePersistentDomain(forName: "TestSuiteClear")
}
