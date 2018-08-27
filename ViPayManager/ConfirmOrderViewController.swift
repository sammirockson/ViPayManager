//
//  ConfirmOrderViewController.swift
//  ViPay
//
//  Created by Rock on 2018/8/24.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class ConfirmOrderViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    let backgroundImage: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "backgrounGradientImage")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let customNavContainerView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "iconArrowBack"), for: .normal)
        btn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let bottomItemsContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var payLabel: UIButton = {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.backgroundColor = defaultAppColor
        label.setTitle("Order Served", for: .normal)
        label.setTitleColor(defaultAppColor, for: .normal)
        label.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 18)
        label.isUserInteractionEnabled = true
        label.backgroundColor = .white
//        label.isEnabled = false
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePayOrder)))
        return label
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ghc 240"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        label.numberOfLines = 1
        label.textColor = defaultAppColor
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    private let identifier = "identifier"
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        view.backgroundColor = .white
        collectionView.register(ConfirmOrderCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(ConfirmOrderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
        if let cells = self.collectionView.visibleCells as? [ConfirmOrderCollectionViewCell]{
            
            for cell in cells {
                
                cell.swipeCloseAllOtherCells(cell: cell)
                
                
                
            }
        }
        
    }
    
 
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if let cells = self.collectionView.visibleCells as? [ConfirmOrderCollectionViewCell]{
            
            for cell in cells {
                
                cell.swipeCloseAllOtherCells(cell: cell)
                
                
                
            }
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {

        customNavContainerView.image = UIImage()

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        //-44.0

        if targetContentOffset.pointee.y < 10.0 {

            customNavContainerView.image = UIImage()


        }else{

            customNavContainerView.image = #imageLiteral(resourceName: "Background")

        }

    }

    
    
    
    @objc func handleBackButton(){
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func setUpViews(){
        
        view.addSubview(backgroundImage)
        view.addSubview(customNavContainerView)
        view.addSubview(collectionView)
        view.addSubview(backButton)
        
        view.addSubview(bottomItemsContainerView)
//        bottomItemsContainerView.addSubview(totalPriceLabel)
        bottomItemsContainerView.addSubview(payLabel)

        
//        totalPriceLabel.leftAnchor.constraint(equalTo: bottomItemsContainerView.leftAnchor, constant: 20).isActive = true
//        totalPriceLabel.rightAnchor.constraint(equalTo: payLabel.leftAnchor, constant: -5).isActive = true
//        totalPriceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        totalPriceLabel.centerYAnchor.constraint(equalTo: bottomItemsContainerView.centerYAnchor).isActive = true
        
        payLabel.bottomAnchor.constraint(equalTo: bottomItemsContainerView.bottomAnchor, constant: 0).isActive = true
        payLabel.rightAnchor.constraint(equalTo: bottomItemsContainerView.rightAnchor,constant: 0).isActive = true
        payLabel.widthAnchor.constraint(equalTo: bottomItemsContainerView.widthAnchor).isActive = true
        payLabel.heightAnchor.constraint(equalTo: bottomItemsContainerView.heightAnchor).isActive = true

        
        bottomItemsContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomItemsContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomItemsContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomItemsContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        if UIDevice.current.isIphoneX {
            
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true
            
            
        }else{
            
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
            
        }
        backButton.leftAnchor.constraint(equalTo: customNavContainerView.leftAnchor, constant: 15).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        customNavContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customNavContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        customNavContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        if UIDevice.current.isIphoneX {
            
            customNavContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            
        }else{
            
            customNavContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
        }
        
    }
    
    
    @objc func handleSwipeToDeleteTapped(gesture: UITapGestureRecognizer){
        
            let sender = gesture.view
            
            let point = sender?.convert((sender?.bounds.origin)!, to: self.collectionView)
            if let indexPath = self.collectionView.indexPathForItem(at: point!) {
                
                if let cell = collectionView.cellForItem(at: indexPath) as? ConfirmOrderCollectionViewCell{
                    
                    cell.swipeCloseAllOtherCells(cell: cell)
                    
                    
                    //Remove item and reload collectionview
                    
                    
                }
                
                
            }
            
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ConfirmOrderCollectionViewCell
        cell.backgroundColor = .clear
        cell.vc = self
        cell.trashCanImageView.isUserInteractionEnabled = true
        cell.trashCanImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSwipeToDeleteTapped)))
        cell.revealButton.isUserInteractionEnabled = true
        cell.revealButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSwipeToDeleteTapped)))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView: ConfirmOrderCollectionReusableView?
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as? ConfirmOrderCollectionReusableView
        headerView?.backgroundColor = .clear
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 16, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}
