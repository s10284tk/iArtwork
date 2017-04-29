//
//  Country.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation

internal enum Country {
    case japan
    case usa
    
    static var currentCountry: Country {
        return Country.country(DeviceData.countryRawValue)
    }
    
    private static func country(_ rawValue: Int) -> Country {
        switch rawValue {
        case 0:
            return .japan
            
        case 1:
            return .usa
            
        default:
            assertionFailure("ここには来ないはず")
            return .japan
        }
    }
    
    var rawValue: Int {
        switch self {
        case .japan:
            return 0
            
        case .usa:
            return 1
        }
    }
    
    var title: String {
        switch self {
        case .japan:
            return NSLocalizedString("japan", comment: "")
            
        case .usa:
            return NSLocalizedString("usa", comment: "")
        }
    }
    
    var requestParameter: String {
        switch self {
        case .japan:
            return "jp"
        case .usa:
            return "us"
        }
    }
}
