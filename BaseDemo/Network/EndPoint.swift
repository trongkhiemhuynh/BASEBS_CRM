//
//  EndPoint.swift
//  BaseDemo
//
//  Created by BASEBS on 8/7/20.
//  Copyright © 2020 BASEBS. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL : URL {get}
    var path : String {get}
    var httpMethod : HTTPMethod {get}
    var task : HTTPTask {get}
    var headers : HTTPHeaders? {get}
}

public enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
}

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters : Parameters, urlParameters : Parameters)
    case requestParemetersAndHeaders(bodyParameters : Parameters, urlParameters : Parameters, additionHeaders : HTTPHeaders)
}

public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String : Any]
