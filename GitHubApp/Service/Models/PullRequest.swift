//
//  PullRequest.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

struct PullRequest: Codable {
    
    let url: String
    let id: Int
    let nodeID: String
    let htmlURL: String
    let diffURL: String
    let patchURL: String
    let issueURL: String
    let number: Int
    let state: String
    let locked: Bool
    let title: String
    let user: User
    let body: String
    let authorAssociation: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case nodeID = "node_id"
        case htmlURL = "html_url"
        case diffURL = "diff_url"
        case patchURL = "patch_url"
        case issueURL = "issue_url"
        case number
        case state
        case locked
        case title
        case user
        case body
        case authorAssociation = "author_association"
        case createdAt = "created_at"
    }
    
}
