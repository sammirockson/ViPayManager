//
//  SelectSizeCollectionViewCell.swift
//  ViPayManager
//
//  Created by Rock on 2018/9/3.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class SelectSizeCollectionViewCell: UICollectionViewCell {
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 14)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews(){
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
    }
    
}
