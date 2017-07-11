//
//  ActivityIndicator+StartStop.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/07/11.
//  Copyright © 2017年 piyo. All rights reserved.
//

import Foundation
import UIKit

internal struct ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    private init() { }
    
    func start() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stop() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
