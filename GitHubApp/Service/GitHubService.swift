//
//  GitHubService.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class GitHubService {
    
    func getRepositories(page: Int, success: @escaping ([Repository]) -> Void, failure: @escaping (_ error: RequestError) -> Void) {
        let apiUrl = AppEnvironment.baseServiceAPI.value.appending("search/repositories")
        let parameters = ["q": "language:Java",
                          "sort": "stars",
                          "page": "\(page)"]
        
        RequestClient.shared.request(method: .get, url: apiUrl, urlParameters: parameters, parameters: nil, success: { result in
            do {
                let repositories = try JSONDecoder().decode(Repositories.self, from: result)
                success(repositories.items)
            } catch {
                failure(RequestError.notMapped)
            }
        }, failure: { fail in
            failure(fail)
        })
    }
    
    func getPullRequests(owner: String, repository: String, success: @escaping ([PullRequest]) -> Void, failure: @escaping (_ error: RequestError) -> Void) {
        let apiUrl = AppEnvironment.baseServiceAPI.value.appending("repos/\(owner)/\(repository)/pulls")
        
        RequestClient.shared.request(method: .get, url: apiUrl, urlParameters: nil, parameters: nil, success: { result in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let pullRequests = try decoder.decode([PullRequest].self, from: result)
                success(pullRequests)
            } catch {
                failure(RequestError.notMapped)
            }
        }, failure: { fail in
            failure(fail)
        })
    }
    
}
