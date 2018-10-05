//
//  ShopViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/25.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let customNavContainerView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "Background")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var addProductImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "iconAdd")
        v.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddProduct)))
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.groupTableViewBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var closeOpenSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.isOn = true
        sw.addTarget(self, action: #selector(handleSwitched), for: .valueChanged)
        return sw
    }()
    
    let shopStatusLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Open"
        v.font = UIFont(name: FontNames.OpenSansSemiBold, size: 20)
        v.clipsToBounds = true
        v.textColor = .white
        return v
    }()
    
    var products = [PFObject]()
    weak var currentUser = PFUser.current()

    
    private let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpViews()
        
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
      
        let currentUser = PFUser.current()
        if let isOpen = currentUser?.object(forKey: "isOpen") as? Bool {
            
            if isOpen == true {
                self.closeOpenSwitch.setOn(true, animated: true)
            }else{
                self.closeOpenSwitch.setOn(false, animated: true)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    
    
    func fetchOrders(){
        if let type = PFUser.current()?.object(forKey: "businessType") as? Int {
            if let businessType = BusinessType.init(rawValue: type ) {
                
                switch businessType{
                case .shop:
                    self.queryInfo(className: "Products", ownerTitle: "shop")
                case .hotel:
                    print("Hello world")
                    self.queryInfo(className: "HotelService", ownerTitle: "company")
                case .restaurant:
                    print("Hello world")
                    
                case .carRentals:
                    print("Hello world")
                    
                case .service:
                    print("Hello world")
                    
                case .housing:
                    print("Hello world")
                }
            }
            
        }
       
        
        
    }
    
    func queryInfo(className: String, ownerTitle: String){
        
        let query = PFQuery(className: className)
        query.whereKey(ownerTitle, equalTo: currentUser!)
        query.cachePolicy = PFCachePolicy.cacheThenNetwork
        query.findObjectsInBackground { (results, error) in
            if error == nil {
                
                if (results?.count)! > 0 {
                    
                    self.products.removeAll(keepingCapacity: true)
                    self.products = results!
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                    }
                    
                }
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.updateShopInfo()
        self.fetchOrders()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        
      
    }
    
    
    
    func updateShopInfo(){
        
        let query = PFUser.query()
        query?.getObjectInBackground(withId: (currentUser?.objectId!)!, block: { (user, error) in
            
            if error == nil {
                
                DispatchQueue.main.async {
                    
                    if let isOpen = user?.object(forKey: "isOpen") as? Bool {
                        
                        if isOpen == true {
                            
                            self.closeOpenSwitch.setOn(true, animated: true)
                            
                        }else{
                            
                            self.closeOpenSwitch.setOn(false, animated: true)
                            
                        }
                    }
                    
                    
                }
                
            }
        })
    }
    
    @objc func handleSwitched(){
        
        if self.closeOpenSwitch.isOn {
            
            self.shopStatusLabel.text = "Open"
            self.updateShopStatus(status: true)
            
        }else{
            
            self.shopStatusLabel.text = "Closed"
            self.updateShopStatus(status: false)


        }
        
    }
    
    func updateShopStatus(status: Bool){
        
        let currentUser = PFUser.current()
        
        currentUser?.setObject(status, forKey: "isOpen")
        currentUser?.saveEventually({ (success, error) in
            if error == nil {
                
                print("shop updated successfully")
                
            }else{
                
                print("shop updated with error \(String(describing: error?.localizedDescription))")

            }
        })
        
        
    }
    
    @objc func handleAddProduct(){
        
        if let type = PFUser.current()?.object(forKey: "businessType") as? Int {
        if let businessType = BusinessType.init(rawValue: type ) {
            
            switch businessType{
            case .shop:
                let addProductsVC = AddProductsViewController()
                addProductsVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(addProductsVC, animated: true)
            case .hotel:
                let addProductsVC = AddHotelServiceViewController()
                addProductsVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(addProductsVC, animated: true)
            case .restaurant:
                print("Hello world")
            case .carRentals:
                print("Hello world")

            case .service:
                print("Hello world")
                
            case .housing:
                let addProductsVC = AddHouseViewController()
                addProductsVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(addProductsVC, animated: true)
            }
        }
            
        }
   
       
    }
    
   
    
    

}


extension ShopViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ShopCollectionViewCell
        cell.backgroundColor = .white
        let product = self.products[indexPath.item]
        cell.processAndDisplay(object: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
}

extension ShopViewController {
    func setUpViews(){
        
        view.addSubview(customNavContainerView)
        view.addSubview(collectionView)
        view.addSubview(addProductImageView)
        
        view.addSubview(closeOpenSwitch)
        view.addSubview(shopStatusLabel)
        
        shopStatusLabel.rightAnchor.constraint(equalTo: addProductImageView.leftAnchor, constant: -8).isActive = true
        shopStatusLabel.leftAnchor.constraint(equalTo: closeOpenSwitch.rightAnchor, constant: 30).isActive = true
        shopStatusLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shopStatusLabel.centerYAnchor.constraint(equalTo: addProductImageView.centerYAnchor).isActive = true
        
        
        
        closeOpenSwitch.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
        
        closeOpenSwitch.leftAnchor.constraint(equalTo: customNavContainerView.leftAnchor, constant: 15).isActive = true
        closeOpenSwitch.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeOpenSwitch.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        if isCurvedDevice {
            addProductImageView.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true
        }else{
            addProductImageView.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
        }
        addProductImageView.rightAnchor.constraint(equalTo: customNavContainerView.rightAnchor, constant: -15).isActive = true
        addProductImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        addProductImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: customNavContainerView.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        customNavContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customNavContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        customNavContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        if isCurvedDevice {
            customNavContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        }else{
            customNavContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
    }
    
}
