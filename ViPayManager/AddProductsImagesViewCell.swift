//
//  AddProductsImagesViewCell.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/28.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class AddProductsImagesViewCell: UICollectionViewCell {
    
    lazy var thumbnailImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "backgrounGradientImage")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(thumbnailImageView)
        MyConstraints.sharedInstance.pinConstraints(motherView: self, viewToPin: thumbnailImageView, leftMargin: 0, rightMargin: 0, topMargin: 0, bottomMargin: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
