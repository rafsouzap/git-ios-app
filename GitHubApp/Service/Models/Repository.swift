//
//  Repository.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

struct Repository: Codable {
    
    let id: Int
    let name: String
    let fullName: String
    let owner: User
    let htmlUrl: String
    let pullsUrl: String
    let description: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let forks: Int
    let openIssues: Int
    let watchers: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlUrl = "html_url"
        case pullsUrl = "pulls_url"
        case description = "description"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case forks
        case openIssues = "open_issues"
        case watchers
    }
    
}
