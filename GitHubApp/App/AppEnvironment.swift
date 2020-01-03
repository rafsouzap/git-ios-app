//
//  AppEnvironment.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

enum AppEnvironment {
    case baseServiceAPI
    
    var value: String {
        switch self {
        case .baseServiceAPI: return "https://api.github.com/"
        }
    }
}
