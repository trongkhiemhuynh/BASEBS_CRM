//
//  NetworkManager.swift
//  BaseDemo
//
//  Created by BASEBS on 8/11/20.
//  Copyright © 2020 BASEBS. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let APIKey = ""
    private let router = Router<BaseApi>()
}

enum NetworkEnvironment {
    case production
    case stagging
    case qa
}
