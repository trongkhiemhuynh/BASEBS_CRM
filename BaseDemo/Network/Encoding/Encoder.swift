//
//  Encoder.swift
//  BaseDemo
//
//  Created by BASEBS on 8/11/20.
//  Copyright © 2020 BASEBS. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(urlRequest : inout URLRequest, with parameters : Parameters) throws
}

public enum NetworkError : String, Error {
    
    case parametersNil = "Parameters were nil."
    case encodingFails = "Parameter encoding failed."
    case missingURL = "URL is nil."
    
}

public struct URLParameterEncoder : ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL}
        
        if var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponent.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponent.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponent.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
    
    
    
}

public struct JSONParameterEncoder : ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            urlRequest.httpBody = jsonData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        } catch {
            throw NetworkError.encodingFails
        }
    }
    
    
}
