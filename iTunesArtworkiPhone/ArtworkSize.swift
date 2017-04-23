//
//  ArtworkSize.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation

internal enum ArtworkSize {
    case medium
    case large
    
    static var currentSize: ArtworkSize {
        return ArtworkSize.artworkSize(DeviceData.imageSizeRawValue)
    }
    
    private static func artworkSize(_ rawValue: Int) -> ArtworkSize {
        switch rawValue {
        case 0:
            return .medium
            
        case 1:
            return .large
            
        default:
            assertionFailure("ここには来ないはず")
            return .medium
        }
    }
    
    var rawValue: Int {
        switch self {
        case .medium:
            return 0
            
        case .large:
            return 1
        }
    }
    
    var title: String {
        switch self {
        case .medium:
            return "Medium"
            
        case .large:
            return "Large"
        }
    }
}
