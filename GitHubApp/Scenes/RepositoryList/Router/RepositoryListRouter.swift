//
//  RepositoryListRouter.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 22/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation
import UIKit

final class RepositoryListRouter {
 
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = RepositoryListViewController()
        
        let presenter = RepositoryListPresenter(view: viewController, router: self)
        viewController.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
 
    func showPullRequest(from owner: String, repository: String) {
        let viewController = PullRequestListViewController()
        
        let presenter = PullRequestListPresenter(view: viewController, owner: owner, repository: repository)
        viewController.presenter = presenter
        
        if let topViewController = UIApplication.shared.topMostViewController() {
            topViewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
