//
//  PullRequestViewModel.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class PullRequestViewModel {
    
    let title: String
    let body: String
    let author: String
    let createdAt: String
    let url: String
    let avatarURL: String
    
    init(pullRequest: PullRequest) {
        self.title = pullRequest.title
        self.body = pullRequest.body
        self.author = pullRequest.user.login
        self.createdAt = pullRequest.createdAt.toString(style: .long)
        self.url = pullRequest.url
        self.avatarURL = pullRequest.user.avatarURL
    }
    
}
