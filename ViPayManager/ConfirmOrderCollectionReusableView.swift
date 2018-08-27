//
//  ConfirmOrderCollectionReusableView.swift
//  ViPay
//
//  Created by Rock on 2018/8/24.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
//import MarqueeLabel

class ConfirmOrderCollectionReusableView: UICollectionReusableView {
    
    let restoAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "110 street, Bantama, Kumasi. The address should be more"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 18)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let nameAndPhoneTextView: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Samuel, 15650149550"
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 16)
        label.textColor = .white
        label.dataDetectorTypes = .all
        label.isEditable = false
        label.isSelectable = false
        label.backgroundColor = .clear
        return label
    }()
    
    let ETAContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let etaLabel: UILabel = {
        let label = UILabel()
        label.text = "Est. Time of Arrival"
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    let etaValueLabel: UILabel = {
        let label = UILabel()
        label.text = "4:45 PM"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .right
        label.textColor = defaultAppColor
        return label
    }()
    
    
    let deliveryFeeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery fee"
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    let deliveryFeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ghc 15"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .right
        label.textColor = defaultAppColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(restoAddressLabel)
        self.addSubview(nameAndPhoneTextView)
        self.addSubview(ETAContainerView)
        
        
        ETAContainerView.addSubview(etaLabel)
        ETAContainerView.addSubview(etaValueLabel)
        ETAContainerView.addSubview(deliveryFeeTitleLabel)
        ETAContainerView.addSubview(deliveryFeeLabel)
        
        
        deliveryFeeLabel.rightAnchor.constraint(equalTo: ETAContainerView.rightAnchor, constant: -15).isActive = true
        deliveryFeeLabel.leftAnchor.constraint(equalTo: deliveryFeeTitleLabel.rightAnchor, constant: 4).isActive = true
        deliveryFeeLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        deliveryFeeLabel.bottomAnchor.constraint(equalTo: ETAContainerView.bottomAnchor, constant: -8).isActive = true
        
        deliveryFeeTitleLabel.leftAnchor.constraint(equalTo: ETAContainerView.leftAnchor, constant: 15).isActive = true
        deliveryFeeTitleLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        deliveryFeeTitleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        deliveryFeeTitleLabel.bottomAnchor.constraint(equalTo: ETAContainerView.bottomAnchor, constant: -8).isActive = true
        
        etaValueLabel.rightAnchor.constraint(equalTo: ETAContainerView.rightAnchor, constant: -15).isActive = true
        etaValueLabel.leftAnchor.constraint(equalTo: etaLabel.rightAnchor, constant: 4).isActive = true
        etaValueLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        etaValueLabel.topAnchor.constraint(equalTo: ETAContainerView.topAnchor, constant: 8).isActive = true
        
        etaLabel.leftAnchor.constraint(equalTo: ETAContainerView.leftAnchor, constant: 15).isActive = true
        etaLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        etaLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        etaLabel.topAnchor.constraint(equalTo: ETAContainerView.topAnchor, constant: 8).isActive = true
        
        ETAContainerView.topAnchor.constraint(equalTo: nameAndPhoneTextView.bottomAnchor, constant: 8).isActive = true
        ETAContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        ETAContainerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        ETAContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        
        nameAndPhoneTextView.topAnchor.constraint(equalTo: restoAddressLabel.bottomAnchor, constant: 4).isActive = true
        nameAndPhoneTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameAndPhoneTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        nameAndPhoneTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        
        restoAddressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        restoAddressLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        restoAddressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        restoAddressLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    }
    
}
