//
//  RepositoryListViewController.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 22/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import UIKit

final class RepositoryListViewController: UIViewController {

    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refresh
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepositoryListViewCell.self, forCellReuseIdentifier: RepositoryListViewCell.identifier)
        tableView.insertSubview(refreshControl, at: 0)
        return tableView
    }()
    
    var presenter: RepositoryListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupUI()
        self.loadRepositories()
        
        self.title = "Repositories"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
        
}

// MARK: - UITableViewDataSource
extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = self.presenter else {
            return 0
        }
        return presenter.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryListViewCell.identifier, for: indexPath) as? RepositoryListViewCell else {
            fatalError("Couldn't dequeue \(RepositoryListViewCell.identifier)")
        }

        guard let presenter = self.presenter else {
            fatalError("Present can't be nil")
        }
        
        let repository = presenter.repositories[indexPath.row]
        cell.bind(model: repository)

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let presenter = self.presenter else {
            fatalError("Present can't be nil")
        }

        if indexPath.row > 0 && indexPath.row == presenter.repositories.count - 1 {
            presenter.loadMoreRepositories()
        }
    }

}

// MARK: - UITableViewDelegate
extension RepositoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = self.presenter else {
            fatalError("Present can't be nil")
        }
        
        presenter.showPullRequests(index: indexPath.row)
    }
    
}

// MARK: - RepositoryListViewProtocol
extension RepositoryListViewController: RepositoryListViewProtocol {
    
    func showLoading() {
        self.showActivityIndicator()
    }
    
    func hideLoading() {
        self.hideActivityIndicator()
    }
    
    func reloadTableView() {
        UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
           self.tableView.reloadData()
       })
    }
    
    func showAlertError(title: String, message: String, buttonTitle: String) {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Public methods
extension RepositoryListViewController {
    
    @objc func refreshTableView() {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        
        guard let presenter = self.presenter else {
            fatalError("Presenter can't be nil")
        }
        
        presenter.loadRepositories()
    }
    
}

// MARK: - Private methods
extension RepositoryListViewController {
    
    fileprivate func loadRepositories() {
        guard let presenter = self.presenter else {
            fatalError("Presenter can't be nil")
        }
        presenter.loadRepositories()
    }
    
    fileprivate func setupUI() {
        view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}
