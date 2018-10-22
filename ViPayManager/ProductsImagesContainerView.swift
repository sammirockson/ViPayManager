//
//  ProductsImagesContainerView.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/28.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import OpalImagePicker

class ProductsImagesContainerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, OpalImagePickerControllerDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var motherVC: AddProductsViewController?
    var restoVC: RestaurantsFoodsViewController?
    
    var arrayOfImages = [UIImage]()
    
    private let identifier = "identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        
        collectionView.register(AddProductsImagesViewCell.self, forCellWithReuseIdentifier: identifier)
        arrayOfImages.append(UIImage(named: "addFile")!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        self.motherVC?.dismiss(animated: true, completion: nil)
    }
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        if images.count > 0 {
            self.arrayOfImages.removeAll(keepingCapacity: true)
            self.arrayOfImages = images
        }
        picker.dismiss(animated: true, completion: {
            if self.arrayOfImages.count > 0 {
                self.collectionView.reloadData()
            }
        })

    }
    
    func setUpViews(){
      
        self.addSubview(collectionView)
        
        MyConstraints.sharedInstance.pinConstraints(motherView: self, viewToPin: collectionView, leftMargin: 10, rightMargin: 10, topMargin: 0, bottomMargin: 0)
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AddProductsImagesViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        let image = self.arrayOfImages[indexPath.item]
        cell.thumbnailImageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 4
        if self.restoVC != nil {
            restoVC?.present(imagePicker, animated: true, completion: nil)
        }else{
            motherVC?.present(imagePicker, animated: true, completion: nil)
        }
    }
}
