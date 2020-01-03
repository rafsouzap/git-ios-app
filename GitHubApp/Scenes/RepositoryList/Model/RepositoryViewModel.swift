//
//  RepositoryViewModel.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class RepositoryViewModel {
    
    let name: String
    let description: String
    let forks: String
    let stars: String
    let owner: String
    let avatarUrl: String
    
    init(repository: Repository) {
        self.name = repository.name
        self.description = repository.description
        self.forks = "\(repository.forks)"
        self.stars = "\(repository.stargazersCount)"
        self.owner = repository.owner.login
        self.avatarUrl = repository.owner.avatarURL
    }
    
}
