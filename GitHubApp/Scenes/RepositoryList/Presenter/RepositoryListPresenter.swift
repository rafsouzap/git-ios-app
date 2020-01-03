//
//  RepositoryListPresenter.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 21/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class RepositoryListPresenter {
    
    fileprivate unowned var view: RepositoryListViewProtocol
    fileprivate let service: GitHubService
    fileprivate(set) var repositories: [RepositoryViewModel] = []
    fileprivate var currentPage: Int = 1
    fileprivate var router: RepositoryListRouter
    
    init(view: RepositoryListViewProtocol, router: RepositoryListRouter) {
        self.view = view
        self.service = GitHubService()
        self.router = router
    }
    
}

// MARK: - Public methods
extension RepositoryListPresenter {

    func loadRepositories() {
        self.currentPage = 1
        self.getRepositories(reload: true)
    }
    
    func loadMoreRepositories() {
        self.currentPage += 1
        self.getRepositories(reload: false)
    }
    
    func showPullRequests(index: Int) {
        let repository = self.repositories[index]
        self.router.showPullRequest(from: repository.owner, repository: repository.name)
    }
    
}

// MARK: - Private methods
extension RepositoryListPresenter {
    
    fileprivate func getRepositories(reload: Bool = false) {
        self.view.showLoading()
        
        self.service.getRepositories(page: self.currentPage, success: { result in
            let repos = result.compactMap { RepositoryViewModel(repository: $0) }
            
            if reload {
                self.repositories = repos
            } else {
                self.repositories.append(contentsOf: repos)
            }
            
            DispatchQueue.main.async {
                self.view.hideLoading()
                self.view.reloadTableView()
            }
        }, failure: { fail in
            DispatchQueue.main.async {
                self.view.hideLoading()
                self.view.showAlertError(title: "Erro", message: fail.description, buttonTitle: "OK")
            }
        })
    }

}
