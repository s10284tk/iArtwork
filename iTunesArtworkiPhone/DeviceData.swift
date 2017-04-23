//
//  DeviceData.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation

internal struct DeviceData {
    
    struct UserDefaultsKey {
        static let imageSize = "size"
        static let country = "country"
    }
    
    static var imageSizeRawValue: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.imageSize)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.imageSize)
        }
    }
    
    static var countryRawValue: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.country)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.country)
        }
    }
}
