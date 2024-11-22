//
//  RepoCell.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation
import UIKit

class RepoCell: UITableViewCell {
    static let identifier = "RepoCell"
    private(set) var repo: Repo!
    
    private let repoNameLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "Name"
        air.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let repoDescLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "Desc"
        air.numberOfLines = 2
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let userNameLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "UserName"
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let repoStarsLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "Stars"
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let repoForksLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "Forks"
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    
    private let repoForkImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "fork")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private let repoStarImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "star.fill")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .systemYellow
        return img
    }()
    
    private let userProfileImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test_img")
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 25
        return img
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with repo: Repo){
        self.repo = repo
        self.repoNameLabel.text = self.repo.name
        self.repoDescLabel.text = self.repo.description
        self.userNameLabel.text = self.repo.owner.login
        self.repoStarsLabel.text = self.repo.stargazers_count.formatted()
        self.repoForksLabel.text = self.repo.forks_count.formatted()
        
        DispatchQueue.global().async { [weak self] in
            if let imgUrl = URL(string: repo.owner.avatar_url),
               let imageData = try? Data(contentsOf: imgUrl),
               let avatarImg = UIImage(data:imageData){
                DispatchQueue.main.async{
                    self?.userProfileImg.image = avatarImg
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.repoNameLabel.text = nil
        self.repoDescLabel.text = nil
        self.userNameLabel.text = nil
        self.repoStarsLabel.text = nil
        self.repoForksLabel.text = nil
        self.userProfileImg.image = nil
    }
    
    private func setupUI(){
        self.addSubview(repoNameLabel)
        self.addSubview(repoDescLabel)
        self.addSubview(userNameLabel)
        self.addSubview(repoStarsLabel)
        self.addSubview(repoForksLabel)
        self.addSubview(repoForkImg)
        self.addSubview(repoStarImg)
        self.addSubview(userProfileImg)
        
        NSLayoutConstraint.activate([
            repoNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            repoNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            repoNameLabel.widthAnchor.constraint(equalToConstant: 240),
            
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 20),
            userNameLabel.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),

            userProfileImg.bottomAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: -4),
            userProfileImg.centerXAnchor.constraint(equalTo: userNameLabel.centerXAnchor),
            userProfileImg.widthAnchor.constraint(equalToConstant: 50),
            userProfileImg.heightAnchor.constraint(equalToConstant: 50),
            
            repoDescLabel.leadingAnchor.constraint(equalTo: repoNameLabel.leadingAnchor),
            repoDescLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 0),
            repoDescLabel.widthAnchor.constraint(equalToConstant: 240),
            
            repoForkImg.leadingAnchor.constraint(equalTo: repoNameLabel.leadingAnchor),
            repoForkImg.topAnchor.constraint(equalTo: repoDescLabel.bottomAnchor, constant: 15),
            repoForkImg.widthAnchor.constraint(equalToConstant: 12),
            repoForkImg.heightAnchor.constraint(equalToConstant: 18),
            
            repoForksLabel.leadingAnchor.constraint(equalTo: repoForkImg.trailingAnchor,constant: 3),
            repoForksLabel.topAnchor.constraint(equalTo: repoDescLabel.bottomAnchor, constant: 15),
            
            repoStarImg.leadingAnchor.constraint(equalTo: repoForksLabel.trailingAnchor,constant: 10),
            repoStarImg.topAnchor.constraint(equalTo: repoDescLabel.bottomAnchor, constant: 15),
            repoStarImg.widthAnchor.constraint(equalToConstant: 20),
            repoStarImg.heightAnchor.constraint(equalToConstant: 20),
            
            
            repoStarsLabel.leadingAnchor.constraint(equalTo: repoStarImg.trailingAnchor, constant: 3),
            repoStarsLabel.topAnchor.constraint(equalTo: repoForksLabel.topAnchor),
            
            
            
        ])
    }
    
    
    
}

