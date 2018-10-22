//
//  BusinessChatTableViewCell.swift
//  ViPay
//
//  Created by Rock on 2018/10/6.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class BusinessChatTableViewCell: UITableViewCell {
    
    
    let containerView: UIView = {
     let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        return v
    }()
    
    let productInfoView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.borderColor = defaultAppColor.cgColor
        v.layer.borderWidth = 0.1
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageMessage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "love")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let label = UITextView()
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 13)
        label.alpha = 0.8
        label.isEditable = false
        label.isSelectable = false
        label.isScrollEnabled = false
        label.text = ""
        label.backgroundColor = .clear
        return label
    }()
    
    let messageTextView: UITextView = {
        let label = UITextView()
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 15)
        label.alpha = 0.8
        label.isEditable = false
        label.isSelectable = false
        label.isScrollEnabled = false
        label.text = ""
        label.backgroundColor = .clear
        return label
    }()
    
  
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 16)
        label.textColor = RGB.sharedInstance.requiredColor(r: 255, g: 59, b: 5, alpha: 1.0)
        label.alpha = 0.8
        label.text = "Ghc45.89"
        return label
    }()
    
    let outgoingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17.all
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let incomingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17.all
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let resendMessage: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.layer.cornerRadius = 15.all
        v.clipsToBounds = true
        v.isHidden = true
        return v
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var leftConstraint: NSLayoutConstraint?
    var rightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    
    func setUpViews(){
        
        self.addSubview(incomingImageView)
        self.addSubview(outgoingImageView)
        self.addSubview(containerView)
        
        incomingImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8.all)
            make.top.equalToSuperview().offset(8.all)
            make.width.equalTo(34.all)
            make.height.equalTo(34.all)
        }
        
        outgoingImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8.all)
            make.top.equalToSuperview().offset(8.all)
            make.width.equalTo(34.all)
            make.height.equalTo(34.all)
        }
        
        rightConstraint = containerView.rightAnchor.constraint(equalTo: outgoingImageView.leftAnchor, constant: -8.all)
        rightConstraint?.isActive = true
        leftConstraint = containerView.leftAnchor.constraint(equalTo: incomingImageView.rightAnchor, constant: 8.all)
        leftConstraint?.isActive = false
        
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        widthConstraint = containerView.widthAnchor.constraint(equalToConstant: 180.all)
        widthConstraint?.isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.all).isActive = true
        
        
        containerView.addSubview(imageMessage)
        imageMessage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(resendMessage)
        resendMessage.snp.makeConstraints { (make) in
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(30.all)
            make.height.equalTo(30.all)
            make.right.equalTo(containerView.snp.left).offset(-8.all)
        }
        
        containerView.addSubview(messageTextView)
        messageTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8.all, bottom: 0, right: 4.all))
        }
        
        containerView.addSubview(productInfoView)
        productInfoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        productInfoView.addSubview(productImageView)
        productImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(180.all)
        }
        
        productInfoView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-8.all)
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(5.all)
            make.height.equalTo(24.all)
        }

        productInfoView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(productImageView.snp.bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalTo(priceLabel.snp.top)
        }

       
        
    }

}
