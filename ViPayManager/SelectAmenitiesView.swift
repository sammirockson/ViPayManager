//
//  SelectAmenitiesView.swift
//  ViPayManager
//
//  Created by Rock on 2018/10/5.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

protocol SelectedAmenitiesDelegate: class {
    func selectedItems(items: [String])
}

class SelectAmenitiesView: UIView {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    fileprivate let identifier = "identifier"
    var itemsArray = [AttachmentItems]()
    
   fileprivate var selectedItems = [String]()
    weak var delegate: SelectedAmenitiesDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(AttachmetItemsCollectionViewCell.self, forCellWithReuseIdentifier: identifier)

        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension SelectAmenitiesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: (self.frame.width - 20) / 4, height: self.frame.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! AttachmetItemsCollectionViewCell
        //        self.loopThrough(index: indexPath.item)
        
        let selecteItem = self.itemsArray[indexPath.item]
        if !self.selectedItems.contains(selecteItem.title){
            self.selectedItems.append(selecteItem.title)
            cell.backgroundColor = defaultAppColor.withAlphaComponent(0.8)
            cell.titleLabel.textColor = .white
            
        }else{
            for item in  self.selectedItems {
                if item == selecteItem.title {
                    if let index = selectedItems.index(of: item) {
                        self.selectedItems.remove(at: index)
                        cell.backgroundColor = .white
                        cell.titleLabel.textColor = .black
                        
                    }
                }
            }
        }
        
        print(self.selectedItems)
        self.delegate?.selectedItems(items: self.selectedItems)

    }
    
    
}
