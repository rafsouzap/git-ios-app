//
//  RepositoryListViewProtocol.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 23/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

protocol RepositoryListViewProtocol: class {
    func showLoading()
    func hideLoading()
    func reloadTableView()
    func showAlertError(title: String, message: String, buttonTitle: String)
}
