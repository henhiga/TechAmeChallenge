//
//  PullCell.swift
//  TechAmeChallenge
//
//  Created by Henrique on 22/11/24.
//

import Foundation
import UIKit

class PullCell: UITableViewCell{
    static let identifier = "PullCell"
    private(set) var pull: Pull!
    
    private let pullNameLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "Name"
        air.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let pullBodyLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "body"
        air.numberOfLines = 2
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let pullProfileNameLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .left
        air.text = "body"
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    private let pullProfileImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test_img")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 15
        return img
    }()
    
    private let pullDateLabel: UILabel = {
        let air = UILabel()
        air.textAlignment = .center
        air.text = "date"
        air.translatesAutoresizingMaskIntoConstraints = false
        return air
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pull: Pull){
        self.pull = pull
        self.pullNameLabel.text = pull.title
        self.pullBodyLabel.text = pull.body
        self.pullProfileNameLabel.text = pull.user.login
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: pull.updated_at) {
            self.pullDateLabel.text = date.formatted(date: .abbreviated, time: .shortened)
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imgUrl = URL(string: pull.user.avatar_url),
               let imageData = try? Data(contentsOf: imgUrl),
               let avatarImg = UIImage(data:imageData){
                DispatchQueue.main.async{
                    self?.pullProfileImg.image = avatarImg
                }
            }
        }
    }
    
    func setupUI(){
        self.addSubview(pullNameLabel)
        self.addSubview(pullBodyLabel)
        self.addSubview(pullProfileImg)
        self.addSubview(pullProfileNameLabel)
        self.addSubview(pullDateLabel)
        
        NSLayoutConstraint.activate([
            pullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            pullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            pullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            pullBodyLabel.leadingAnchor.constraint(equalTo: pullNameLabel.leadingAnchor),
            pullBodyLabel.topAnchor.constraint(equalTo: pullNameLabel.bottomAnchor, constant:  8),
            pullBodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            pullProfileImg.leadingAnchor.constraint(equalTo: pullNameLabel.leadingAnchor),
            pullProfileImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            pullProfileImg.heightAnchor.constraint(equalToConstant: 30),
            pullProfileImg.widthAnchor.constraint(equalToConstant: 30),
            
            pullProfileNameLabel.centerYAnchor.constraint(equalTo: pullProfileImg.centerYAnchor),
            pullProfileNameLabel.leadingAnchor.constraint(equalTo: pullProfileImg.trailingAnchor, constant: 5),
            
            pullDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            pullDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
            
        ])
    }
    
}
