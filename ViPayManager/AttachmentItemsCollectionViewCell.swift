//
//  AttachmentItemsCollectionViewCell.swift
//  Trendine
//
//  Created by Rockson on 06/05/2017.
//  Copyright © 2017 RockzAppStudio. All rights reserved.
//

import UIKit
import SnapKit

class AttachmetItemsCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFill
        imageV.layer.cornerRadius = 5
        imageV.clipsToBounds = true 
        return imageV
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.textColor = .black
        label.alpha = 0.8
        label.text = "Camera"
        label.textAlignment = .center
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
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20.all)
            make.top.equalTo(imageView.snp.bottom).offset(12.all)
            make.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(64.all)
            make.height.equalTo(64.all)
            make.centerY.equalToSuperview().offset(-15.all)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
}
