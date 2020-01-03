//
//  URLSessionRequestClient.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class URLSessionRequestClient: RequestClientProtocol {
    
    func request(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        guard var components = URLComponents(string: url) else {
            failure(RequestError.invalidUrl)
            return
        }
        
        if let queryParameters = urlParameters {
            components.queryItems = queryParameters.compactMap { key, value in
                URLQueryItem(name: key, value: value)
            }
            
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.verb
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let jsonBody = parameters, let httpBody = try? JSONSerialization.data(withJSONObject: jsonBody) {
            request.httpBody = httpBody
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                
                guard let data = data else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }
        task.resume()
    }
    
    func downloadImage(url: String, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void) {
        guard let _url = URL(string: url) else {
            failure(RequestError.invalidUrl)
            return
        }
        
        URLSession.shared.dataTask(with: _url, completionHandler: { (data, response, error)in
            DispatchQueue.global(qos: .background).async {
                guard let response = response as? HTTPURLResponse else {
                    failure(RequestError.invalidResponse)
                    return
                }
                
                guard 200 ... 300 ~= response.statusCode else {
                    failure(RequestError(code: response.statusCode))
                    return
                }
                
                guard let mimeType = response.mimeType, mimeType.hasPrefix("image") else {
                    failure(RequestError.notFound)
                    return
                }
                
                guard let data = data else {
                    failure(RequestError.notMapped)
                    return
                }
                success(data)
            }
        }).resume()
    }
    
}
