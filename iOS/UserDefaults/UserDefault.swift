//
// UserDefault.swift
// Copyright © 2020 Matt Nunes-Spraggs
//

import Foundation

@propertyWrapper
struct UserDefault<T: UserDefaultsStorable> {
    
    let key: String
    let defaultValue: T
    let defaults: UserDefaults
    
    init(_ key: String, `default` defaultValue: T, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = defaults
    }
    
    var wrappedValue: T {
        get { T.load(from: defaults, with: key) ?? defaultValue }
        set { T.store(newValue, in: defaults, with: key) }
    }
    
}
