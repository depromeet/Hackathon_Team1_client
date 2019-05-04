//
//  SettingsProvider.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

extension UserDefaults {
    // Basic values
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    // Enums
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }
}

class SettingsProvider {
    
    static let shared = SettingsProvider()
    
    var isUserLoggedIn: Bool {
        get {
            return UserDefaults.standard[#function] ?? false
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    var userProfileUrl: String {
        get {
            return UserDefaults.standard[#function] ?? ""
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    var userNickname: String {
        get {
            return UserDefaults.standard[#function] ?? ""
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
}

