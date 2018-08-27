//
//  ShopViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/25.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

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
    
    private let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpViews()
        
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: identifier)

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
    
    @objc func handleSwitched(){
        
        if self.closeOpenSwitch.isOn {
            
            self.shopStatusLabel.text = "Open"
            
        }else{
            
            self.shopStatusLabel.text = "Closed"

        }
        
    }
    
    @objc func handleAddProduct(){
        
        print("add product")
    }
    
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
        
//        if UIDevice.current.isIphoneX {
//
//            closeOpenSwitch.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
//
//        }else{
//
//
//        }
        
        closeOpenSwitch.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true

        closeOpenSwitch.leftAnchor.constraint(equalTo: customNavContainerView.leftAnchor, constant: 15).isActive = true
        closeOpenSwitch.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeOpenSwitch.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        if UIDevice.current.isIphoneX {
            
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
        if UIDevice.current.isIphoneX {
            
            customNavContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            
        }else{
            
            customNavContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
        }
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ShopCollectionViewCell
        cell.backgroundColor = .white
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }

}
