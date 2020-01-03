//
//  Owner.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let login: String
    let id: Int
    let avatarURL: String
    let gravatarID: String

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
    }
    
}
