//
//  ShopCollectionViewCell.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/26.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse
import Kingfisher

class ShopCollectionViewCell: UICollectionViewCell {
    
    let bottomThinLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        return v
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Background")
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let foodNameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Banku and Tiliapia"
        v.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        v.clipsToBounds = true
        return v
    }()
    
    let searchTagsLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Banku ,  Tiliapia , Enotina Restuarant"
        v.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        v.clipsToBounds = true
        return v
    }()
    
    let priceLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Ghc 12.5"
        v.font = UIFont(name: FontNames.OpenSansSemiBold, size: 20)
        v.clipsToBounds = true
        v.textColor = defaultAppColor
        return v
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.layer.borderWidth = 0.2
        button.backgroundColor = .white
        button.layer.borderColor = defaultAppColor.cgColor
        return button
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        button.setTitleColor(defaultAppColor, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.layer.borderWidth = 0.2
        button.backgroundColor = .white
        button.layer.borderColor = defaultAppColor.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func processAndDisplay(object: PFObject){

        let fileOne = object.object(forKey: "fileOne") as? PFFile
        let stringURL = fileOne?.url
        let url = URL(string: stringURL!)
        thumbnailImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        let price = object.object(forKey: "price") as? String
        self.priceLabel.text = "Ghc \(price!)"
        
        let description = object.object(forKey: "description") as? String
        self.foodNameLabel.text = description
        
        let searchTags = object.object(forKey: "searchTags") as? String
        self.searchTagsLabel.text = searchTags
    }
    
    func setUpViews(){
        
        self.addSubview(bottomThinLine)
        self.addSubview(thumbnailImageView)
        self.addSubview(foodNameLabel)
        self.addSubview(searchTagsLabel)
        self.addSubview(priceLabel)

        self.addSubview(deleteButton)
        self.addSubview(editButton)
        
        editButton.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: -10).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: deleteButton, leftMargin: nil, rightMargin: -15, topMargin: nil, bottomMargin: -8, height: 34, width: 80)
        
        
        priceLabel.topAnchor.constraint(equalTo: searchTagsLabel.bottomAnchor, constant: 8).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 8).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        searchTagsLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 0).isActive = true
        searchTagsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        searchTagsLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 8).isActive = true
        searchTagsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: foodNameLabel, leftMargin: 73, rightMargin: -8, topMargin: 5, bottomMargin: nil, height: 30, width: nil)
        
       MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: thumbnailImageView, leftMargin: 15, rightMargin: nil, topMargin: 10, bottomMargin: nil, height: 50, width: 50)
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: bottomThinLine, leftMargin: 15, rightMargin: 0, topMargin: nil, bottomMargin: 0, height: 1, width: nil)
    }
    
}
