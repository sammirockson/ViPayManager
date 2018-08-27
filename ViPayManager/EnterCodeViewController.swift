//
//  EnterCodeViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/26.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class EnterCodeViewController: UIViewController {
    
    let customNavContainerView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "Background")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    let navTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Verify Mobile Number"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    lazy var phoneNumberField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "123456"
        txtField.keyboardType = .phonePad
        txtField.font = UIFont(name: FontNames.OpenSansSemiBold, size: 25)
        txtField.autocorrectionType = .no
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.textAlignment = .center
        return txtField
    }()
    
    lazy var sendCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Background"), for: .normal)
        button.setTitle("Verify", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        button.addTarget(self, action: #selector(handleVerifyCode), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "iconArrowBack"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        view.backgroundColor = .white

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleBackButton(){
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        phoneNumberField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumberField.resignFirstResponder()
    }
    
    @objc func handleVerifyCode(){
        
        navigationController?.pushViewController(SignUpViewController(), animated: true)
        
    }
    
    func setUpViews(){
        
        view.addSubview(customNavContainerView)
        customNavContainerView.addSubview(backButton)
        customNavContainerView.addSubview(navTitleLabel)
        
        view.addSubview(sendCodeButton)
        view.addSubview(phoneNumberField)
        
        
        phoneNumberField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        phoneNumberField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        phoneNumberField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        phoneNumberField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        
        sendCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendCodeButton.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 70).isActive = true
        sendCodeButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sendCodeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
      
        
        navTitleLabel.rightAnchor.constraint(equalTo: customNavContainerView.rightAnchor, constant: -53).isActive = true
        navTitleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 8).isActive = true
        navTitleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        navTitleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        
        if UIDevice.current.isIphoneX {
            
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 15).isActive = true
            
        }else{
            
            backButton.centerYAnchor.constraint(equalTo: customNavContainerView.centerYAnchor, constant: 10).isActive = true
            
        }
        backButton.leftAnchor.constraint(equalTo: customNavContainerView.leftAnchor, constant: 15).isActive = true
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
