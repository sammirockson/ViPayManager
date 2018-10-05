//
//  SelectedMediaView.swift
//  ViPay
//
//  Created by Rock on 2018/9/8.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import SnapKit
import OpalImagePicker
import Photos

class SelectedMediaView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, OpalImagePickerControllerDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    var motherVC: CompleteHotelAddViewController!
    
    fileprivate let identifier = "identifier"
    var imagesArray: [UIImage] = {
        let imageA = #imageLiteral(resourceName: "addFile")
        return [imageA]
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(SelectedMediaViewCell.self, forCellWithReuseIdentifier: identifier)
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10.all, bottom: 0, right: 0))
        }
        
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        if images.count > 0 {
            self.imagesArray.removeAll(keepingCapacity: true)
            self.imagesArray = images
        }
        
        self.imagePicker.dismiss(animated: true, completion: {
            if self.imagesArray.count > 0 {
                self.collectionView.reloadData()
                
            }
        })
        
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SelectedMediaViewCell
        cell.layer.cornerRadius = 4
        cell.clipsToBounds = true
        
        cell.thumbnailImageView.image = self.imagesArray[indexPath.item]
        if cell.thumbnailImageView.image == #imageLiteral(resourceName: "addFile") {
            cell.thumbnailImageView.contentMode = .scaleAspectFit
        }else{
            cell.thumbnailImageView.contentMode = .scaleAspectFill
            cell.thumbnailImageView.clipsToBounds = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.all, height: 80.all)
    }
    
    let imagePicker = OpalImagePickerController()

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 4
        imagePicker.navigationBar.barTintColor = defaultAppColor
        imagePicker.selectionTintColor = defaultAppColor
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        motherVC?.present(imagePicker, animated: true, completion: nil)
    }

}
