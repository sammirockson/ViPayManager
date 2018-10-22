//
//  ChatsTableViewCell.swift
//  GhPay
//
//  Created by Rockson on 08/09/2017.
//  Copyright © 2017 RockzAppStudio. All rights reserved.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.all
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let profileRingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.all
        return imageView
    }()
    
    let itemsContainerView: UIView = {
       let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = .white
        return cView
    }()
    
    let usernameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        label.textColor = .black
        label.alpha = 0.8
        label.text = "Samuel Rockson"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 12)
        label.text = "2:42PM"
        label.textAlignment = .right
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Last message says that all the stuffs seem to be working well...."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    override func layoutSubviews() {
       super.layoutSubviews()
        
        setUpViews()
    }
    
    
    func setUpViews(){
        
        self.addSubview(profileImageView)
        self.addSubview(profileRingImageView)
        self.addSubview(itemsContainerView)
        
        itemsContainerView.addSubview(timeStampLabel)
        itemsContainerView.addSubview(usernameLabel)
        itemsContainerView.addSubview(lastMessageLabel)
        
        
        lastMessageLabel.rightAnchor.constraint(equalTo: itemsContainerView.rightAnchor, constant: -30.all).isActive = true
        lastMessageLabel.leftAnchor.constraint(equalTo: itemsContainerView.leftAnchor).isActive = true
        lastMessageLabel.bottomAnchor.constraint(equalTo: itemsContainerView.bottomAnchor, constant: -4.all).isActive = true
        lastMessageLabel.heightAnchor.constraint(equalToConstant: 20.all).isActive = true
        
        
        usernameLabel.leftAnchor.constraint(equalTo: itemsContainerView.leftAnchor).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: timeStampLabel.leftAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20.all).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: itemsContainerView.topAnchor, constant: 4.all).isActive = true
        
        timeStampLabel.rightAnchor.constraint(equalTo: itemsContainerView.rightAnchor).isActive = true
        timeStampLabel.topAnchor.constraint(equalTo: itemsContainerView.topAnchor).isActive = true
        timeStampLabel.widthAnchor.constraint(equalToConstant: 100.all).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: 20.all).isActive = true
        
        itemsContainerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.all).isActive = true
        itemsContainerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8.all).isActive = true
        itemsContainerView.heightAnchor.constraint(equalToConstant: 50.all).isActive = true
        itemsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        profileRingImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.all).isActive = true
        profileRingImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileRingImageView.widthAnchor.constraint(equalToConstant: 40.all).isActive = true
        profileRingImageView.heightAnchor.constraint(equalToConstant: 40.all).isActive = true
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.all).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40.all).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40.all).isActive = true
        
        
    }

}
