//
//  RequestClient.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class RequestClient {
    static let shared: RequestClientProtocol = URLSessionRequestClient()
}
