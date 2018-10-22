//
//  AddProductsViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/28.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import SnapKit
import Parse

class Product: NSObject {
    var price: String = ""
    var searchTag: String = ""
    var descrip: String = ""
    var category: String = ""
    var shop: PFUser!
    var name: String = ""
    var images: [UIImage]!
}

class AddProductsViewController: UIViewController, UITextFieldDelegate, SelectedItemDelegate {
    func dismiss() {
        self.handleDismiss()
    }
    
    func selectedItem(item: String) {
        self.categoryTitleLabel.text = item
    }
    
    
    
    let customNavContainerView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "Background")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "iconArrowBack"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    lazy var displayImagesContainerView: ProductsImagesContainerView = {
        let v = ProductsImagesContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.motherVC = self
        return v
    }()
    
    lazy var priceContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 8
        return v
    }()
    
    lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
        label.text = "Price"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var priceTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.placeholder = "E.g 5"
        label.keyboardType = .decimalPad
        return label
    }()
    
    lazy var descriptionContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 8
        return v
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
        label.text = "Product description"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var descripTextView: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 16)
        label.text = ""
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = true
        label.autocorrectionType = .no
        return label
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
    
    lazy var searchTagsContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 8
        return v
    }()
    
    lazy var searchTagsTextField: UITextField = {
        let label = UITextField()
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.placeholder = "Search tags e.g milk, bag, iPhone X"
        return label
    }()
    
    lazy var categoryContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 8
        return v
    }()
    
    let categoryTitle = "Food Category"
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
        label.text = categoryTitle
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectFoodCategory)))
        return label
    }()
    
    let dropDownImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "drop-down")
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var frame = view.frame

    lazy var foodCategoryView: FoodCategoryContainerView = {
        let v = FoodCategoryContainerView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: 300))
        v.backgroundColor = .blue
        v.delegate = self
        return v
    }()
    
    lazy var coverView: UIView = {
        let v = UIView(frame: view.bounds)
        v.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        v.alpha = 0
        return v
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setUpViews()
        
        view.addSubview(coverView)
        view.addSubview(foodCategoryView)


    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    @objc func handleNextButtonTapped(){
        
        
        if categoryTitleLabel.text! == categoryTitle {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please select category")
            return
        }
        
        if (searchTagsTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please enter search tag. It helps users find your product.")
            return
        }
        
        if (priceTextField.text?.isEmpty)!{
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please enter price. Don't want money?")
            return
        }
        
        if descripTextView.text.isEmpty {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please add product description.")
            return
        }
        
        let images = self.displayImagesContainerView.arrayOfImages
        if images.count == 1 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Please select product images.")
            return
        }
        
        let category = self.categoryTitle
        let price = self.priceTextField.text!
        let tags = self.searchTagsTextField.text!
        let desc = self.descripTextView.text!
        let shop = PFUser.current()
        
        let prod = Product()
        prod.shop = shop
        prod.searchTag = tags
        prod.descrip = desc
        prod.category = category
        prod.price = price
        prod.images = images
        prod.name = "No Nmae at the moment"
        
        let nextVC = SelectSizeViewController()
        nextVC.product = prod
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func handleDismiss(){
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.foodCategoryView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 300)
            self.view.layoutIfNeeded()
            self.coverView.alpha = 0
            
        }) { (completed) in
            
            
        }
        
    }
    
    @objc func handleSelectFoodCategory(){
        
        self.view.addSubview(foodCategoryView)
        
        
        coverView.isUserInteractionEnabled = true
        self.coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.coverView.alpha = 1
            self.foodCategoryView.frame = CGRect(x: 0, y: self.frame.height - 300, width: self.frame.width, height: 300)
            self.view.layoutIfNeeded()

        }) { (completed) in
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @objc func handleBackButtonTapped(){
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text
        
        if (text?.contains("."))! && string == "." || text?.utf8.count == 0 && string == "."{
            return false
        }else{
            
            let maxLength = 10
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
    
    func setUpViews(){
        
        view.addSubview(customNavContainerView)
        customNavContainerView.addSubview(backButton)
        customNavContainerView.addSubview(postButton)
        
        view.addSubview(displayImagesContainerView)
        
        view.addSubview(priceContainerView)
        priceContainerView.addSubview(priceTitleLabel)
        priceContainerView.addSubview(priceTextField)
        
        view.addSubview(searchTagsContainerView)
        searchTagsContainerView.addSubview(searchTagsTextField)
        
        searchTagsTextField.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        
        searchTagsContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        searchTagsContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        searchTagsContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchTagsContainerView.topAnchor.constraint(equalTo: priceContainerView.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(categoryContainerView)
        categoryContainerView.addSubview(dropDownImageView)
        categoryContainerView.addSubview(categoryTitleLabel)
        
        categoryTitleLabel.rightAnchor.constraint(equalTo: dropDownImageView.leftAnchor, constant: -8).isActive = true
        categoryTitleLabel.leftAnchor.constraint(equalTo: categoryContainerView.leftAnchor, constant: 8).isActive = true
        categoryTitleLabel.heightAnchor.constraint(equalToConstant: 46).isActive = true
        categoryTitleLabel.topAnchor.constraint(equalTo: categoryContainerView.topAnchor, constant: 4).isActive = true
        
        
        dropDownImageView.rightAnchor.constraint(equalTo: categoryContainerView.rightAnchor, constant: -10).isActive = true
        dropDownImageView.centerYAnchor.constraint(equalTo: categoryContainerView.centerYAnchor).isActive = true
        dropDownImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dropDownImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        categoryContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        categoryContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        categoryContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        categoryContainerView.topAnchor.constraint(equalTo: searchTagsContainerView.bottomAnchor, constant: 10).isActive = true
        
        view.addSubview(descriptionContainerView)
        descriptionContainerView.addSubview(descriptionTitleLabel)
        descriptionContainerView.addSubview(descripTextView)
        
        
       
        
        
        descripTextView.leftAnchor.constraint(equalTo: descriptionContainerView.leftAnchor, constant: 4).isActive = true
        descripTextView.rightAnchor.constraint(equalTo: descriptionContainerView.rightAnchor, constant: -4).isActive = true
        descripTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 0).isActive = true
        descripTextView.bottomAnchor.constraint(equalTo: descriptionContainerView.bottomAnchor, constant: -4).isActive = true
        
        descriptionTitleLabel.leftAnchor.constraint(equalTo: descriptionContainerView.leftAnchor, constant: 8).isActive = true
        descriptionTitleLabel.rightAnchor.constraint(equalTo: descriptionContainerView.rightAnchor, constant: -8).isActive = true
        descriptionTitleLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor, constant: 4).isActive = true
        descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        descriptionContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        descriptionContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        descriptionContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionContainerView.topAnchor.constraint(equalTo: categoryContainerView.bottomAnchor, constant: 10).isActive = true
        
        
        priceTextField.leftAnchor.constraint(equalTo: priceContainerView.leftAnchor, constant: 8).isActive = true
        priceTextField.rightAnchor.constraint(equalTo: priceContainerView.rightAnchor).isActive = true
        priceTextField.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 0).isActive = true
        priceTextField.bottomAnchor.constraint(equalTo: priceContainerView.bottomAnchor, constant: -4).isActive = true
        
        
        priceTitleLabel.leftAnchor.constraint(equalTo: priceContainerView.leftAnchor, constant: 8).isActive = true
        priceTitleLabel.rightAnchor.constraint(equalTo: priceContainerView.rightAnchor, constant: -8).isActive = true
        priceTitleLabel.topAnchor.constraint(equalTo: priceContainerView.topAnchor, constant: 4).isActive = true
        priceTitleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        priceContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        priceContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        priceContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        priceContainerView.topAnchor.constraint(equalTo: displayImagesContainerView.bottomAnchor, constant: 10).isActive = true
        
        displayImagesContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        displayImagesContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        displayImagesContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        displayImagesContainerView.topAnchor.constraint(equalTo: customNavContainerView.bottomAnchor, constant: 20).isActive = true
        
        
        
        
        
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


extension AddProductsViewController {
    
    
}
