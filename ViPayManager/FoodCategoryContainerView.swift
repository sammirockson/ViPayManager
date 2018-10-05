//
//  FoodCategoryContainerView.swift
//  ViPayManager
//
//  Created by Rock on 2018/9/2.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import SnapKit

enum FoodCategories {
    case Local
    case FastFood
    case Beverage
    case Drinks
    case Snacks
    case Fruits
    case Others
}

class FoodCategoryContainerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.groupTableViewBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    var motherVC: AddProductsViewController?
    
    let arrayOfFoodCategories = ["Local", "Fast Food", "Beverage", "Drinks", "Snacks", "Fruits", "Bakery", "Others"]
    
    fileprivate let identifier = "identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        collectionView.register(FoodCategoriesViewCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
    }
 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfFoodCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = self.arrayOfFoodCategories[indexPath.item]
        self.motherVC?.handleDismiss()
        self.motherVC?.categoryTitleLabel.text = title

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FoodCategoriesViewCell
        cell.titleLabel.text = self.arrayOfFoodCategories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
}
