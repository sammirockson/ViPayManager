//
//  OrdersHeaderCollectionReusableView.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/25.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class OrdersHeaderCollectionReusableView: UICollectionReusableView {
    
    let backgroundImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "Background")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let totalSalesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Amount (GhC)"
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 12)
        label.textColor = .white
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "57,500.00"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 30)
        label.textColor = .white
        return label
    }()
    
    let widthdrawButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setTitle("Withdraw", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 12)
        return button
    }()
    
    let widthdrawTypeView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        return v
    }()
    
    let widthdrawTypeLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textAlignment = .center
        v.text = "Withdraw via MTN Mobile Money"
        v.font = UIFont(name: FontNames.OpenSansRegular, size: 12)
        v.textColor = .white
        v.clipsToBounds = true
        return v
    }()
    
//    let coverUpView: UIView = {
//        let v = UIView()
//        v.backgroundColor = UIColor.groupTableViewBackground
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.clipsToBounds = true
//        return v
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(backgroundImageView)
        self.addSubview(totalSalesTitle)
        self.addSubview(widthdrawButton)
        self.addSubview(amountLabel)
        self.addSubview(widthdrawTypeView)
        
//        self.addSubview(coverUpView)
        widthdrawTypeView.addSubview(widthdrawTypeLabel)
        
        MyConstraints.sharedInstance.pinConstraints(motherView: widthdrawTypeView, viewToPin: widthdrawTypeLabel, leftMargin: 0, rightMargin: 0, topMargin: 0, bottomMargin: 0)
        
//        coverUpView.topAnchor.constraint(equalTo: widthdrawTypeView.bottomAnchor, constant: -8).isActive = true
//        coverUpView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        coverUpView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        coverUpView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        widthdrawTypeView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0).isActive = true
        widthdrawTypeView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        widthdrawTypeView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        widthdrawTypeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        widthdrawButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        widthdrawButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        widthdrawButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        widthdrawButton.topAnchor.constraint(equalTo: totalSalesTitle.bottomAnchor, constant: 15).isActive = true
        
        amountLabel.centerYAnchor.constraint(equalTo: widthdrawButton.centerYAnchor).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: widthdrawButton.leftAnchor, constant: -8).isActive = true
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: totalSalesTitle, leftMargin: 15, rightMargin: nil, topMargin: 30, bottomMargin: nil, height: 20, width: 100)
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: backgroundImageView, leftMargin: 0, rightMargin: 0, topMargin: -300, bottomMargin: nil, height: 500, width: nil)
        
    }
    
}
