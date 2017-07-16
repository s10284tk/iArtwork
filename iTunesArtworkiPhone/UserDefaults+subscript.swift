//
//  UserDefaults+subscript.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation

/// アプリで利用するUserDefaultのキー一覧を定義する。
internal class UserDefaultsKeys {
    
    /// 国
    static let country = UserDefaultsKey<Int>("country")
    
    /// 画像サイズ
    static let imageSize = UserDefaultsKey<Int>("imageSize")
    
}

internal final class UserDefaultsKey<Value: UserDefaultsValueType>: UserDefaultsKeys {
    
    let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
}

extension UserDefaults {
    
    subscript<T>(key: UserDefaultsKey<T>) -> T? where T: UserDefaultsValueType {
        set {
            set(newValue, forKey: key.key)
            synchronize()
        }
        get {
            return object(forKey: key.key) as? T
        }
    }
    
}

internal protocol UserDefaultsValueType {}

extension String: UserDefaultsValueType {}
extension Int: UserDefaultsValueType {}
extension Float: UserDefaultsValueType {}
extension Double: UserDefaultsValueType {}
extension Bool: UserDefaultsValueType {}
extension Date: UserDefaultsValueType {}
extension Data: UserDefaultsValueType {}


