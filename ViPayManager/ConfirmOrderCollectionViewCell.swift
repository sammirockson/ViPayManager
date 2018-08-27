//
//  ConfirmOrderCollectionViewCell.swift
//  ViPay
//
//  Created by Rock on 2018/8/24.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

let deepOrange = UIColor(red: 212/255, green: 66/255, blue: 5/255, alpha: 1)


class ConfirmOrderCollectionViewCell: UICollectionViewCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "Background")
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "x1   Ghc 89.5"
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .right
        return label
    }()
    
    lazy var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
    lazy var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
    
    
    lazy var customViewCell: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        swipeLeft.direction = .left
        swipeRight.direction = .right
        v.addGestureRecognizer(swipeLeft)
        v.addGestureRecognizer(swipeRight)
        return v
    }()

    let revealButton: UIView = {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = deepOrange
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()
    
    let trashCanImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.image = #imageLiteral(resourceName: "delete")
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var vc: ConfirmOrderViewController?
    var isSwiped = false
    
    @objc func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        
        let visibleCells = self.vc?.collectionView.visibleCells
        if (visibleCells?.count)!  > 0 {
            for cell in visibleCells! {
                
                let indexPath = self.vc?.collectionView.indexPath(for: cell)
                let currentIndexPath = self.vc?.collectionView.indexPath(for: self)
                
                if indexPath?.item == currentIndexPath?.item  {
                    //current cell
                    
                    self.checkAndSwipe(gesture: gesture)
                    
                    
                }else{
                    
                    self.swipeCloseAllOtherCells(cell: cell as! ConfirmOrderCollectionViewCell)
                    
                    
                }
                
            }
        }
        
        
    }
    
    
    func swipeCloseAllOtherCells(cell: ConfirmOrderCollectionViewCell){
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cell.xConstraint?.constant = 0
            cell.layoutIfNeeded()
            
        }) { (completed) in
            
        }
        
        
    }
    
    func checkAndSwipe(gesture: UISwipeGestureRecognizer){
        
        switch gesture.direction {
        case .left:
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.xConstraint?.constant = -80
                self.layoutIfNeeded()
                
            }) { (completed) in
                
            }
        case .right:
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.xConstraint?.constant = 0
                self.layoutIfNeeded()
                
            }) { (completed) in
                
            }
            
        default:
            print("Hello world!")
        }
        print("Hello world")
        
    }
    
    
    
    var xConstraint: NSLayoutConstraint?

    
    func setUpViews(){
        
        self.addSubview(customViewCell)
        
        customViewCell.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        xConstraint = customViewCell.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        xConstraint?.isActive = true
        customViewCell.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        customViewCell.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
        
        customViewCell.addSubview(thumbnailImageView)
        customViewCell.addSubview(priceLabel)

        priceLabel.rightAnchor.constraint(equalTo: customViewCell.rightAnchor, constant: -15).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 8).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: customViewCell.centerYAnchor).isActive = true

        thumbnailImageView.leftAnchor.constraint(equalTo: customViewCell.leftAnchor, constant: 15).isActive = true
        thumbnailImageView.centerYAnchor.constraint(equalTo: customViewCell.centerYAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}
