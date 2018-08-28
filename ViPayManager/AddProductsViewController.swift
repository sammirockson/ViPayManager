//
//  AddProductsViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/28.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class AddProductsViewController: UIViewController {
    
    
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
//        label.delegate = self
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
        label.setTitle("Post", for: .normal)
        label.isUserInteractionEnabled = true
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
    
    lazy var categoryContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 8
        return v
    }()
    
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansRegular, fontSize: 14)
        label.text = "Food Category"
        label.isUserInteractionEnabled = true
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setUpViews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
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
    
    func setUpViews(){
        
        view.addSubview(customNavContainerView)
        customNavContainerView.addSubview(backButton)
        customNavContainerView.addSubview(postButton)
        
        view.addSubview(displayImagesContainerView)
        
        view.addSubview(priceContainerView)
        priceContainerView.addSubview(priceTitleLabel)
        priceContainerView.addSubview(priceTextField)
        
        view.addSubview(searchTagsContainerView)
        
        
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
        if UIDevice.current.isIphoneX {
            
            postButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true
            
        }else{
            
            postButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
            
        }
        postButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        
        backButton.leftAnchor.constraint(equalTo: customNavContainerView.leftAnchor, constant: 15).isActive = true
        if UIDevice.current.isIphoneX {
            
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true

        }else{
            
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true

        }
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        customNavContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customNavContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        customNavContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        if UIDevice.current.isIphoneX {
            
            customNavContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
            
        }else{
            
            customNavContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
        }
        
    }

    

}
