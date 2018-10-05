//
//  VerifyPhoneViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/26.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController , UITextFieldDelegate{
    
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
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+233"
        label.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 25)
        label.textAlignment = .right
        label.clipsToBounds = true
        return label
    }()
    
    lazy var phoneNumberField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "123 4567 890"
        txtField.keyboardType = .phonePad
        txtField.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 25)
        txtField.autocorrectionType = .no
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.delegate = self
        return txtField
    }()
    
    lazy var sendCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Background"), for: .normal)
        button.setTitle("Send Code", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.titleLabel?.font = OptimizedFont.font(fontName: FontNames.OpenSansSemiBold, fontSize: 16)
        button.addTarget(self, action: #selector(handleSendCode), for: .touchUpInside)
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
        view.backgroundColor = .white
        setUpViews()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.phoneNumberField.becomeFirstResponder()
    }
    
    
    @objc func handleSendCode(){
        
        if (phoneNumberField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Phone number field empty")
            return
        }
        
        if  (phoneNumberField.text?.utf8.count)! < 10 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Phone number invalid")
            return
        }
        
        phoneNumberField.resignFirstResponder()
        
        let signUpVC = EnterCodeViewController()
        signUpVC.phoneNumber = phoneNumberField.text!
        navigationController?.pushViewController(signUpVC, animated: true)
        
        
        
    }
    
    @objc func handleBackButton(){
        
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumberField.resignFirstResponder()
    }
    
    var maximumLength = 11
    let phoneDigits =  "0123456789"
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.phoneNumberField {
            
            self.maximumLength = 11
            
            if string != "" && !phoneDigits.contains(string){
                print("other digits not allow")
                return false
            }else{
                
                guard let text = textField.text else { return true }
                let newLength = text.utf8.count + string.utf8.count - range.length
                return newLength <= maximumLength
                
            }
            
            
        }
        
        
        guard let text = textField.text else { return true }
        let newLength = text.utf8.count + string.utf8.count - range.length
        return newLength <= maximumLength
    }
    
    
    
    
    func setUpViews(){
        
        view.addSubview(customNavContainerView)
        customNavContainerView.addSubview(backButton)
        customNavContainerView.addSubview(navTitleLabel)
        
        view.addSubview(phoneNumberField)
        view.addSubview(countryCodeLabel)
        view.addSubview(sendCodeButton)
        
        
        
        
        phoneNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40).isActive = true
        phoneNumberField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        phoneNumberField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        phoneNumberField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        
        sendCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendCodeButton.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor, constant: 70).isActive = true
        sendCodeButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sendCodeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        countryCodeLabel.rightAnchor.constraint(equalTo: phoneNumberField.leftAnchor).isActive = true
        countryCodeLabel.centerYAnchor.constraint(equalTo: phoneNumberField.centerYAnchor).isActive = true
        countryCodeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        countryCodeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navTitleLabel.rightAnchor.constraint(equalTo: customNavContainerView.rightAnchor, constant: -53).isActive = true
        navTitleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 8).isActive = true
        navTitleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        navTitleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        
        if isCurvedDevice {
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
        if isCurvedDevice {
            customNavContainerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }else{
            customNavContainerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        }
    }

}
