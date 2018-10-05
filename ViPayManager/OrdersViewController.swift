//
//  OrdersViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/25.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse

class OrdersViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let customNavContainerView: UIImageView = {
        let v = UIImageView()
//        v.image = #imageLiteral(resourceName: "Background")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.groupTableViewBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var orders = [PFObject]()
    
    fileprivate let identifier = "identifier"
    fileprivate let headerId = "headerId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        collectionView.register(OrdersCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(OrdersHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
   
    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        customNavContainerView.image = UIImage()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //-44.0
        
        if targetContentOffset.pointee.y < 10.0 {
            customNavContainerView.image = UIImage()
            customNavContainerView.backgroundColor = UIColor.clear
        }else{
            customNavContainerView.image = #imageLiteral(resourceName: "Background")
        }
        
    }
    
    func setUpViews(){
        
        view.addSubview(collectionView)
        view.addSubview(customNavContainerView)

        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        customNavContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customNavContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        customNavContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        if isCurvedDevice {
            customNavContainerView.heightAnchor.constraint(equalToConstant: 70.all).isActive = true
        }else{
            customNavContainerView.heightAnchor.constraint(equalToConstant: 64.all).isActive = true
        }
    }
    
    
   
    
    @objc func handleAcceptDetails(){
        
        let confVC = ConfirmOrderViewController()
        confVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(confVC, animated: true)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! OrdersCollectionViewCell
        cell.backgroundColor = UIColor.clear
//        cell.acceptOrderButton.addTarget(self, action: #selector(handleAcceptDetails), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView: OrdersHeaderCollectionReusableView?
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as? OrdersHeaderCollectionReusableView
        headerView?.backgroundColor = UIColor.groupTableViewBackground
        return headerView!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40.all, height: 400.all)
    }

}
