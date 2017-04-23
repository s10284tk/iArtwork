//
//  DeviceData.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation

internal struct DeviceData {
    
    private struct UserDefaultsKey {
        static let imageSize = "size"
        static let country = "country"
    }
    
    private static let userDefaults = UserDefaults.standard
    
    static var imageSizeRawValue: Int {
        get {
            return userDefaults.integer(forKey: UserDefaultsKey.imageSize)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.imageSize)
        }
    }
    
    static var countryRawValue: Int {
        get {
            return userDefaults.integer(forKey: UserDefaultsKey.country)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKey.country)
        }
    }
}
