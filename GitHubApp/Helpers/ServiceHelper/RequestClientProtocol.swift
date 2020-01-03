//
//  RequestClientProtocol.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

protocol RequestClientProtocol {
    func request(method: RequestMethod, url: String, urlParameters: [String: String]?, parameters: [String: Any]?, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
    func downloadImage(url: String, success: @escaping (Data) -> Void, failure: @escaping (RequestError) -> Void)
}
