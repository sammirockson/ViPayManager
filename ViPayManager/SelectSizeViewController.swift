//
//  SelectSizeViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/9/2.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import SnapKit
import Parse
import SVProgressHUD

class SelectSizeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let customNavContainerView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "Background")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select item size(s)"
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "iconArrowBack"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var postButton: UIButton = {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitleColor(.white, for: .normal)
        label.titleLabel?.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 18)
        label.setTitle("Next", for: .normal)
        label.isUserInteractionEnabled = true
        label.addTarget(self, action: #selector(handleNextButtonTapped), for: .touchUpInside)
        return label
    }()
    
    let sizeContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.groupTableViewBackground
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    fileprivate let identifier = "identifier"
    var product: Product!
    
    var items = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        setUpViews()
        collectionView.register(SelectSizeCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        var a = 0
        
        while a < 100 {
            a = a + 1
            self.items.append(a)
            
        }
        
        self.collectionView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleBackButtonTapped(){
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @objc func handleNextButtonTapped(){
        
        let sizes = self.selectedItemsArray
        
        let products = PFObject(className: "Products")
        products.setObject(self.product.shop, forKey: "shop")
        products.setObject(self.product.descrip, forKey: "description")
        products.setObject(self.product.price, forKey: "price")
        products.setObject(self.product.name, forKey: "name")
        products.setObject(self.product.searchTag, forKey: "searchTags")
        products.setObject(self.product.category, forKey: "category")
        products.setObject(sizes, forKey: "size")
        
        let imagesArray = product.images
        
        switch imagesArray?.count {
        case 1:
            
            products.setObject(takeImageAndReturnPFFile(image: (imagesArray?.first)!), forKey: "fileOne")
            
        case 2:
            
            let imageOne = imagesArray?.first
            products.setObject(takeImageAndReturnPFFile(image: imageOne!), forKey: "fileOne")

            let imageTwo = imagesArray![1]
            products.setObject(takeImageAndReturnPFFile(image: imageTwo), forKey: "fileTwo")

        case 3:
            
            let imageOne = imagesArray?.first
            products.setObject(takeImageAndReturnPFFile(image: imageOne!), forKey: "fileOne")
            
            let imageTwo = imagesArray![1]
            products.setObject(takeImageAndReturnPFFile(image: imageTwo), forKey: "fileTwo")
            
            let imageThree = imagesArray![2]
            products.setObject(takeImageAndReturnPFFile(image: imageThree), forKey: "fileThree")
            
        case 4:
            
            let imageOne = imagesArray?.first
            products.setObject(takeImageAndReturnPFFile(image: imageOne!), forKey: "fileOne")
            
            let imageTwo = imagesArray![1]
            products.setObject(takeImageAndReturnPFFile(image: imageTwo), forKey: "fileTwo")
            
            let imageThree = imagesArray![2]
            products.setObject(takeImageAndReturnPFFile(image: imageThree), forKey: "fileThree")
            
            let imageFour = imagesArray![3]
            products.setObject(takeImageAndReturnPFFile(image: imageFour), forKey: "fileFour")
            
        default:
            print("Hello world")
        }
        
        
        DarkOverLay.sharedInstance.show()
        SVProgressHUD.show(withStatus: "Posting...")
        
        products.saveInBackground { (success, error) in
            
            DispatchQueue.main.async {
                DarkOverLay.sharedInstance.dismiss()
                SVProgressHUD.dismiss()
            }
            
            if error != nil {
                
                DispatchQueue.main.async {
                    CustomAlerts.sharedInstance.showAlert(message: (error?.localizedDescription)!, image: #imageLiteral(resourceName: "iconWarning"))
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2), execute: {
                        CustomAlerts.sharedInstance.dismiss()
                    })
                }
            }
        }
        
        
    }
    
    func takeImageAndReturnPFFile(image: UIImage)->PFFile{
        let imageData = image.jpegData(compressionQuality: 1.0)
        let imageFile = PFFile(name: "file.jpg", data: imageData!)!
        return imageFile
    }
    
    var selectedItemsArray = [Int]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SelectSizeCollectionViewCell
       let item = self.items[indexPath.item]
         cell.titleLabel.text = "\(item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 6, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectSizeCollectionViewCell
        if cell.titleLabel.backgroundColor != defaultAppColor {
            
            cell.titleLabel.backgroundColor = defaultAppColor
            cell.titleLabel.textColor = .white

        }else{
            
            cell.titleLabel.backgroundColor = .white
            cell.titleLabel.textColor = .black


        }
        
        let selectedItem = self.items[indexPath.item]
      
        if selectedItemsArray.contains(selectedItem) {
            
            for item in self.selectedItemsArray {
                
                if item == selectedItem {
                    
                   let index = selectedItemsArray.index(of: item)
                    selectedItemsArray.remove(at: index!)
                }
            }
            
            
        }else{
            
            self.selectedItemsArray.append(selectedItem)
            
        }
        print(selectedItemsArray)
    }
    
    func setUpViews(){
        
        view.addSubview(customNavContainerView)
        customNavContainerView.addSubview(backButton)
        customNavContainerView.addSubview(postButton)
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(backButton.snp.right).offset(8)
            make.right.equalTo(postButton.snp.left).offset(-8)
            make.centerY.equalTo(backButton)
            make.height.equalTo(30)
        }
        
        view.addSubview(sizeContainerView)
        sizeContainerView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        sizeContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavContainerView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
        
        
        postButton.rightAnchor.constraint(equalTo: customNavContainerView.rightAnchor, constant: -15).isActive = true
        if isCurvedDevice {
            postButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true
        }else{
            postButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
        }
        postButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        backButton.leftAnchor.constraint(equalTo: customNavContainerView.leftAnchor, constant: 15).isActive = true
        if isCurvedDevice {
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true
        }else{
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
        }
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
