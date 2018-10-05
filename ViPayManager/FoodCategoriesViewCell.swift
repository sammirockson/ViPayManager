//
//  FoodCategoriesViewCell.swift
//  ViPayManager
//
//  Created by Rock on 2018/9/2.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import SnapKit

class FoodCategoriesViewCell: UICollectionViewCell {
    
    let bottomThinLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.85, alpha: 0.5)
        return v
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wanna see how its gonna look like"
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
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
       
        self.addSubview(bottomThinLine)
        
        bottomThinLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(20)
        }
        
    }
    
}
