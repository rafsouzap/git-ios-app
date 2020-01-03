//
//  AppRouter.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import UIKit

final class AppRouter {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let repositoryListRouter = RepositoryListRouter(window: window)
        repositoryListRouter.start()
    }
    
}
