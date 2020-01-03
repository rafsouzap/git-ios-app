//
//  PullRequestListViewCell.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 02/01/20.
//  Copyright © 2020 Rafael de Paula. All rights reserved.
//

import UIKit

final class PullRequestListViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = UIColor(hexadecimal: 0x628FB8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = UIColor(hexadecimal: 0x6E6E6E)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 1
        label.textColor = UIColor(hexadecimal: 0x628FB8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
    // MARK: - Public methods
    func bind(model: PullRequestViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.body
        usernameLabel.text = model.author
        
        ImageLoader.shared.imageForUrl(urlString: model.avatarURL, completion: { image, url in
            guard let avatarImage = image else { return }
            self.avatarImageView.image = avatarImage
        })
    }
    
    // MARK: - Private methods
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0)
        ])
                
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            avatarImageView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: 0)
        ])
        
        let avatarImageViewWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        avatarImageViewWidth.priority = UILayoutPriority(999)
        avatarImageViewWidth.isActive = true
        
        let avatarImageViewHeight = avatarImageView.heightAnchor.constraint(equalToConstant: 40)
        avatarImageViewHeight.priority = UILayoutPriority(999)
        avatarImageViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 0)
        ])
        
        layoutIfNeeded()
    }
    
}
