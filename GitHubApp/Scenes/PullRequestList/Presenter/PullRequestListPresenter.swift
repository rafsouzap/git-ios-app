//
//  PullRequestListPresenter.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

final class PullRequestListPresenter {
    
    fileprivate unowned var view: PullRequestListViewProtocol
    fileprivate let service: GitHubService
    fileprivate(set) var pullRequests: [PullRequestViewModel] = []
    fileprivate(set) var owner: String
    fileprivate(set) var repository: String
    
    init(view: PullRequestListViewProtocol, owner: String, repository: String) {
        self.view = view
        self.service = GitHubService()
        self.owner = owner
        self.repository = repository
    }
    
}

// MARK: - Public methods
extension PullRequestListPresenter {

    func loadPullRequests() {
        self.view.showLoading()
        
        self.service.getPullRequests(owner: self.owner, repository: self.repository, success: { result in
            let pulls = result.compactMap { PullRequestViewModel(pullRequest: $0) }
            self.pullRequests = pulls
            
            DispatchQueue.main.async {
                self.view.hideLoading()
                
                if self.pullRequests.count > 0 {
                    self.view.reloadTableView()
                } else {
                    self.view.showEmptyMessage()
                }
            }
        }, failure: { fail in
            DispatchQueue.main.async {
                self.view.hideLoading()
                self.view.showAlertError(title: "Erro", message: fail.description, buttonTitle: "OK")
            }
        })
    }

}
