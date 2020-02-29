//
// UserDefaultsStorable.swift
// Copyright © 2020 Matt Nunes-Spraggs
//


import Foundation

protocol UserDefaultsStorable {
    
    static func register(_ defaultValue: Self, in defaults: UserDefaults, with key: String)
    static func load(from defaults: UserDefaults, with key: String) -> Self?
    static func store(_ value: Self?, in defaults: UserDefaults, with key: String)
    
}

extension UserDefaultsStorable where Self: RawRepresentable, RawValue: UserDefaultsStorable {
    
    static func register(_ defaultValue: Self, in defaults: UserDefaults, with key: String) {
        defaults.register(defaults: [key: defaultValue.rawValue])
    }
    
    static func load(from defaults: UserDefaults, with key: String) -> Self? {
        guard let rawValue = RawValue.load(from: defaults, with: key) else {
            return nil
        }
        return self.init(rawValue: rawValue)
    }
    
    static func store(_ value: Self?, in defaults: UserDefaults, with key: String) {
        defaults.set(value?.rawValue, forKey: key)
    }
    
}

extension UserDefaultsStorable {
    
    static func register(_ defaultValue: Self, in defaults: UserDefaults, with key: String) {
        defaults.register(defaults: [key: defaultValue])
    }
    
    static func load(from defaults: UserDefaults, with key: String) -> Self? {
        return defaults.value(forKey: key) as? Self
    }
    
    static func store(_ value: Self?, in defaults: UserDefaults, with key: String) {
        defaults.set(value, forKey: key)
    }
    
}

extension Data: UserDefaultsStorable {}
extension Float: UserDefaultsStorable {}
extension String: UserDefaultsStorable {}
extension Int: UserDefaultsStorable {}
