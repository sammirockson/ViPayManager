//
//  OrdersCollectionViewCell.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/25.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse

class OrdersCollectionViewCell: UICollectionViewCell {
    
    var order: PFObject!
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 4
        v.backgroundColor = .white
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.shadowColor = RGB.sharedInstance.requiredColor(r: 0, g: 165, b: 255, alpha: 0.3).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 0.75)
        v.layer.shadowRadius = 3
        v.layer.shadowOpacity = 0.1
        return v
    }()
    
    let acceptOrderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Background"), for: .normal)
        button.setTitle("Accept", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()
    
    let declineOrderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Decline", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        button.setTitleColor(defaultAppColor, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.layer.borderWidth = 0.1
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
    
   
    
    func setUpViews(){
        
        let frame = self.frame
        
        self.addSubview(containerView)
        self.addSubview(acceptOrderButton)
        self.addSubview(declineOrderButton)
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: declineOrderButton, leftMargin: 0, rightMargin: nil, topMargin: nil, bottomMargin: -20.all, height: 50.all, width: frame.width / 3)
        
        
        MyConstraints.sharedInstance.pinWithHeight(motherView: self, viewToPin: acceptOrderButton, leftMargin: nil, rightMargin: 0, topMargin: nil, bottomMargin: -20.all, height: 50.all, width: ((frame.width / 3) * 2) - 8)
        
        MyConstraints.sharedInstance.pinConstraints(motherView: self, viewToPin: containerView, leftMargin: 0, rightMargin: 0, topMargin: 0, bottomMargin: -80.all)
        
    }
    
}
