//
//  PullRequestListViewController.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import UIKit

final class PullRequestListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PullRequestListViewCell.self, forCellReuseIdentifier: PullRequestListViewCell.identifier)
        return tableView
    }()
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(hexadecimal: 0x628FB8)
        label.text = "No Pull Requests created"
        label.accessibilityLanguage = "en-US"
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var presenter: PullRequestListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupUI()
        self.loadPullRequests()
    }
    
}

// MARK: - UITableViewDataSource
extension PullRequestListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = self.presenter else {
            return 0
        }
        return presenter.pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestListViewCell.identifier, for: indexPath) as? PullRequestListViewCell else {
            fatalError("Couldn't dequeue \(PullRequestListViewCell.identifier)")
        }

        guard let presenter = self.presenter else {
            fatalError("Present can't be nil")
        }
        
        let pullRequest = presenter.pullRequests[indexPath.row]
        cell.bind(model: pullRequest)
        
        return cell
    }

}

// MARK: - PullRequestListViewProtocol
extension PullRequestListViewController: PullRequestListViewProtocol {
    
    func showLoading() {
        self.showActivityIndicator()
    }
    
    func hideLoading() {
        self.hideActivityIndicator()
    }
    
    func showEmptyMessage() {
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.alpha = 0
            self.emptyMessageLabel.alpha = 1
        }, completion: nil)
    }
    
    func reloadTableView() {
        UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
           self.tableView.reloadData()
       })
    }
    
    func showAlertError(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Private methods
extension PullRequestListViewController {
    
    fileprivate func loadPullRequests() {
        guard let presenter = self.presenter else {
            fatalError("Presenter can't be nil")
        }
        presenter.loadPullRequests()
        
        self.title = presenter.repository
    }
    
    fileprivate func setupUI() {
        view.addSubview(self.tableView)
        view.addSubview(self.emptyMessageLabel)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.emptyMessageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.emptyMessageLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.emptyMessageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.emptyMessageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}
