//
//  RepositoryListViewCell.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import UIKit

final class RepositoryListViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 1
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
        label.isAccessibilityElement = false
        return label
    }()
    
    private lazy var forksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = UIColor(hexadecimal: 0xDC9124)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = UIColor(hexadecimal: 0xDC9124)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 1
        label.textColor = UIColor(hexadecimal: 0x628FB8)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    private lazy var forksImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "IconFork")
        imageView.tintColor = UIColor(hexadecimal: 0xDC9124)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "IconStar")
        imageView.tintColor = UIColor(hexadecimal: 0xDC9124)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = false
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
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    // MARK: - Public methods
    func bind(model: RepositoryViewModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        forksLabel.text = model.forks
        starsLabel.text = model.stars
        ownerLabel.text = model.owner
        
        ImageLoader.shared.imageForUrl(urlString: model.avatarUrl, completion: { image, url in
            guard let avatarImage = image else { return }
            self.avatarImageView.image = avatarImage
        })
        
        self.setupAccesibility()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(forksLabel)
        contentView.addSubview(starsLabel)
        contentView.addSubview(ownerLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(forksImageView)
        contentView.addSubview(starImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            forksImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            forksImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            forksImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            forksImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            forksLabel.topAnchor.constraint(equalTo: forksImageView.topAnchor, constant: 0),
            forksLabel.bottomAnchor.constraint(equalTo: forksImageView.bottomAnchor, constant: 0),
            forksLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: forksImageView.topAnchor, constant: 0),
            starImageView.leadingAnchor.constraint(equalTo: forksLabel.trailingAnchor, constant: 16),
            starImageView.widthAnchor.constraint(equalToConstant: 24),
            starImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            starsLabel.topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 0),
            starsLabel.bottomAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 0),
            starsLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            ownerLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            ownerLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -12),
            ownerLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12)
        ])
        
        layoutIfNeeded()
    }
    
    private func setupAccesibility() {
        self.accessibilityLanguage = "en-US"
        self.accessibilityHint = "Double tap to list pull requests to this repository"
        
        forksLabel.accessibilityLabel = "\(forksLabel.text ?? "0") forks"
        starsLabel.accessibilityLabel = "\(starsLabel.text ?? "0") stars"
        ownerLabel.accessibilityLabel = "Created by \(ownerLabel.text ?? "")"
    }
    
}
