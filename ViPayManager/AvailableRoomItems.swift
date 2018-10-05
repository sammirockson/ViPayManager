//
//  AvailableRoomItems.swift
//  ViPay
//
//  Created by Rock on 2018/10/1.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit



class AvailableRoomItems: UIView {
    
   
    
    fileprivate let identifier = "identifier"
    var itemsArray = [AttachmentItems]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
       
    }
    
}

extension AvailableRoomItems: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AttachmetItemsCollectionViewCell
        cell.backgroundColor = .white
        let item = self.itemsArray[indexPath.item]
        cell.imageView.image = item.iconImage
        cell.titleLabel.text = item.title
        cell.imageView.snp.updateConstraints { (make) in
            make.width.equalTo(30.all)
            make.height.equalTo(30.all)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4, height: self.frame.height / 2)
    }
}
