//
//  NetworkRouter.swift
//  BaseDemo
//
//  Created by BASEBS on 8/11/20.
//  Copyright © 2020 BASEBS. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void

protocol NetworkRouter : class {
    associatedtype EndPoint = EndPointType
    
    func request(_ route : EndPoint, completion : @escaping NetworkRouterCompletion)
    
    func cancel()
}

class Router<EndPoint : EndPointType> : NetworkRouter {
    
    private var task : URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let session = URLSession.shared
        
        
        do {
            let request = try self.buildRequest(from: route)
            
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters , let urlParameters) :
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParemetersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
                
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
                self.addAdditionalHeaders(additionHeaders, request: &request)
            }
            return request
        } catch {
            throw error
        }
        
        
    }
    
    fileprivate func configureParameters(bodyParameters : Parameters?, urlParameters : Parameters?, request : inout URLRequest) throws {
        
        do {
            
            if let bodyParameter = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameter)
            }
            
            if let urlParameter = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameter)
            }
            
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ addtionalHeaders : HTTPHeaders?, request : inout URLRequest) {
        
        guard let headers = addtionalHeaders else {
            return
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
