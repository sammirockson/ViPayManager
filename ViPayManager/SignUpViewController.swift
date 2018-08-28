//
//  SignUpViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/26.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

let lightBlueColor = UIColor(red:0.01, green:0.47, blue:0.64, alpha:1)
let deepOrangeColor = UIColor(red:0.83, green:0.26, blue:0.02, alpha:1)
let lightGrayColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)



class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var backgroundImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "backgrounGradientImage")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        return v
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var profileImageView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "placeholder")
        v.layer.cornerRadius = 60
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeProfileImage)))
        return v
    }()
    
    let companyContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var companyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Business name"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimateCompany)))
        return label
    }()
    
    lazy var companyTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        return label
    }()
    
    let emailContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Email"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimateEmail)))
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.keyboardType = .emailAddress
        return label
    }()
    
    let passwordContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()

    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.alpha = 0.65
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.text = "Password"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimatePassword)))
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        label.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
        label.delegate = self
        label.autocorrectionType = .no
        label.returnKeyType = .done
        label.isSecureTextEntry = true
        return label
    }()
    
    
    let uploadDocsContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = lightGrayColor
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
  
    lazy var fileImageview: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "file")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
         v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUploadDocs)))
        return v
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Background"), for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Background"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansRegular, size: 12)
        label.text = "Please, tap to upload a copy of your company registration document. We will verify the document before your account will activated."
        label.isUserInteractionEnabled = true
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
  
    var phoneNumber: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        UIApplication.shared.statusBarStyle = .lightContent
        setUpViews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    @objc func dismissKeyboard(){
        
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func handleBackButtonTapped(){
        
        navigationController?.popViewController(animated: true)
        
    }
    
    var isValidEmail = false
    
    @objc func handleSignUp(){
        
        self.isValidEmail = false
        
        if (companyTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Business name field is empty")
            return
        }
        
        if (companyTextField.text?.utf8.count)! < 4 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Business name is too short")
            return
        }
        
        if (emailTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Email field is empty")
            return
        }
        
        if (emailTextField.text?.utf8.count)! < 4 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Email address is too short")
            return
        }
        
        
        
        for em in (emailTextField.text?.characters)! {
            
            if em == "@" {
                
                self.isValidEmail = true
            }
            
        }
        
        if isValidEmail == false {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Email address is not valid")
            return
        }
        
        if (passwordTextField.text?.isEmpty)! {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Password field cannot be empty")
            return
        }
        
        if  (passwordTextField.text?.utf8.count)! < 7 {
            Alerts.shareInstance.alertDisplay(vc: self, reason: "Password should be more than 5 characters")
            return
        }
        
        let businessName = companyTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let phoneNumber = self.phoneNumber!
        
        let imageData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.5)
        let imageFile = PFFile(name: "file.jpg", data: imageData!)!
        
        
        let user = PFUser()
        user.username = businessName
        user.password = password
        user.email = email
        user.setObject(true, forKey: "isBusiness")
        user.setObject(false, forKey: "isActivated")
        user.setObject(imageFile, forKey: "profileImageFile")
        user.setObject(phoneNumber, forKey: "mobile")
        user.setObject("+233", forKey: "countryCode")
        user.setObject(false, forKey: "isOpen")



        
        if fileImageview.image == #imageLiteral(resourceName: "file") {
            
            //No file was selected
            
            let imagePlace = #imageLiteral(resourceName: "filePlaceholder")
            let imageDat = UIImageJPEGRepresentation(imagePlace, 1.0)
            let pFile = PFFile(name: "file.jpg", data: imageDat!)!
            
            user.setObject(pFile, forKey: "companyDoc")
            user.setObject(false, forKey: "isDocAttached")


            
            
        }else{
            
            let imageDat = UIImageJPEGRepresentation(fileImageview.image!, 1.0)
            let pFile = PFFile(name: "file.jpg", data: imageDat!)!
            user.setObject(pFile, forKey: "companyDoc")
            user.setObject(true, forKey: "isDocAttached")

        }

        
        DarkOverLay.sharedInstance.show()
        SVProgressHUD.show(withStatus: "Signing up...")
        
        user.signUpInBackground { (success, error) in
            if error == nil {
                
                DispatchQueue.main.async {
                    
                    DarkOverLay.sharedInstance.dismiss()
                    SVProgressHUD.dismiss()
                    
                    let tabVC = CustomTabBarController()
                    self.navigationController?.pushViewController(tabVC, animated: true)
                    
                    
                }
                
            }else{
              
                DispatchQueue.main.async {
                    
                    DarkOverLay.sharedInstance.dismiss()
                    SVProgressHUD.dismiss()
                    
                    CustomAlerts.sharedInstance.showAlert(message: (error?.localizedDescription)!, image: #imageLiteral(resourceName: "iconWarning"))
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2), execute: {
                        CustomAlerts.sharedInstance.dismiss()
                    })
                    
                }
                
            }
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    @objc func handleUploadDocs(){
        
        self.isDocumentPick = true
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func handleChangeProfileImage(){
        
       self.isDocumentPick = false
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    
    var isDocumentPick = false
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if isDocumentPick == true {
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                self.fileImageview.image = image
            }
            
            if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
                
                self.fileImageview.image = editedImage
                
            }
            
            
        }else{
           
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                self.profileImageView.image = image
            }
            
            if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
                
                self.profileImageView.image = editedImage
                
            }
            
        }
      
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case companyTextField:
            
            if textField.text?.utf8.count == 0 {
                
                self.animateBack(constraint: self.companyHeightConstraint!, titleLabel: companyTitleLabel)

            }
            
        case emailTextField:
            
            if textField.text?.utf8.count == 0 {
                
                self.animateBack(constraint: self.emailHeightConstraint!, titleLabel: emailLabel)
                
            }
            
        case passwordTextField:
            
            if textField.text?.utf8.count == 0 {
                
                self.animateBack(constraint: self.passwordHeightConstraint!, titleLabel: passwordLabel)
                
            }
            
        default:
            print("Hello world")
        }
    }
    
    @objc func handleAnimateCompany(){
        
        self.animateInputItems(textField: companyTextField, constraint: companyHeightConstraint!, titleLabel: companyTitleLabel)
        
    }
    
    @objc func handleAnimateEmail(){
        
        self.animateInputItems(textField: emailTextField, constraint: emailHeightConstraint!, titleLabel: emailLabel)

    }
    
    @objc func handleAnimatePassword(){
        
        self.animateInputItems(textField: passwordTextField, constraint: passwordHeightConstraint!, titleLabel: passwordLabel)

        
    }
    
    
    func animateBack(constraint: NSLayoutConstraint, titleLabel: UILabel){
        
        UIView.animate(withDuration: 0.75, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            constraint.constant = 42
            titleLabel.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
            titleLabel.textColor = RGB.sharedInstance.requiredColor(r: 12, g: 0, b: 51, alpha: 1.0)
            titleLabel.alpha = 0.65
            self.view.layoutIfNeeded()
            
            
        }) { (completed) in
            
           
            
        }
        
    }
    
    
    func animateInputItems(textField: UITextField, constraint: NSLayoutConstraint, titleLabel: UILabel){
        
        UIView.animate(withDuration: 0.75, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            constraint.constant = 20
            titleLabel.font = UIFont(name: FontNames.OpenSansSemiBold, size: 12)
            textField.becomeFirstResponder()
            self.view.layoutIfNeeded()
            
            
        }) { (completed) in
         
            
        }
        
    }
    
    var companyHeightConstraint: NSLayoutConstraint?
    var emailHeightConstraint: NSLayoutConstraint?
    var passwordHeightConstraint: NSLayoutConstraint?

    
    func setUpViews(){
        
        let frame = view.frame
        
        view.addSubview(backgroundImageView)
        view.addSubview(containerView)
        view.addSubview(profileImageView)
        
        view.addSubview(signUpButton)
        view.addSubview(backButton)
        
        if UIDevice.current.isIphoneX {
            
            backButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 60).isActive = true

        }else{
            
            backButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 40).isActive = true

        }
        backButton.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: (frame.width / 2) - 31).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        if UIDevice.current.isIphoneX {

            signUpButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 60).isActive = true

        }else{
            
            signUpButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 40).isActive = true

        }
        signUpButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: (frame.width / 2) - 31).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerView.addSubview(companyContainerView)
        companyContainerView.addSubview(companyTitleLabel)
        companyContainerView.addSubview(companyTextField)

        
        
        containerView.addSubview(emailContainerView)
        emailContainerView.addSubview(emailLabel)
        emailContainerView.addSubview(emailTextField)
        
        containerView.addSubview(passwordContainerView)
        passwordContainerView.addSubview(passwordLabel)
        passwordContainerView.addSubview(passwordTextField)
        
        containerView.addSubview(uploadDocsContainerView)
        uploadDocsContainerView.addSubview(fileImageview)
        uploadDocsContainerView.addSubview(noteLabel)
        
        
        noteLabel.rightAnchor.constraint(equalTo: uploadDocsContainerView.rightAnchor, constant: -4).isActive = true
        noteLabel.leftAnchor.constraint(equalTo: fileImageview.rightAnchor, constant: 8).isActive = true
        noteLabel.topAnchor.constraint(equalTo: uploadDocsContainerView.topAnchor).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: uploadDocsContainerView.bottomAnchor).isActive = true
        
        fileImageview.centerYAnchor.constraint(equalTo: uploadDocsContainerView.centerYAnchor).isActive = true
        fileImageview.leftAnchor.constraint(equalTo: uploadDocsContainerView.leftAnchor, constant: 8).isActive = true
        fileImageview.widthAnchor.constraint(equalToConstant: 50).isActive = true
        fileImageview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    
        
        uploadDocsContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        uploadDocsContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        uploadDocsContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        uploadDocsContainerView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 8).isActive = true
        
        
        passwordTextField.leftAnchor.constraint(equalTo: passwordContainerView.leftAnchor, constant: 8).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: passwordContainerView.rightAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -4).isActive = true
        
        passwordLabel.leftAnchor.constraint(equalTo: passwordContainerView.leftAnchor, constant: 8).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: passwordContainerView.rightAnchor, constant: -8).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: 4).isActive = true
        passwordHeightConstraint =  passwordLabel.heightAnchor.constraint(equalToConstant: 42)
        passwordHeightConstraint?.isActive = true
        
        passwordContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        passwordContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordContainerView.topAnchor.constraint(equalTo: emailContainerView.bottomAnchor, constant: 8).isActive = true
        
        
        emailTextField.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor, constant: 8).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: emailContainerView.rightAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 0).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: emailContainerView.bottomAnchor, constant: -4).isActive = true
        
        
        emailLabel.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor, constant: 8).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: emailContainerView.rightAnchor, constant: -8).isActive = true
        emailLabel.topAnchor.constraint(equalTo: emailContainerView.topAnchor, constant: 4).isActive = true
        emailHeightConstraint =  emailLabel.heightAnchor.constraint(equalToConstant: 42)
        emailHeightConstraint?.isActive = true
        
        emailContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        emailContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        emailContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailContainerView.topAnchor.constraint(equalTo: companyContainerView.bottomAnchor, constant: 8).isActive = true
        
        
        
        
        
        companyContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        companyContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        companyContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        companyContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 78).isActive = true
        
      
        companyTextField.leftAnchor.constraint(equalTo: companyContainerView.leftAnchor, constant: 8).isActive = true
        companyTextField.rightAnchor.constraint(equalTo: companyContainerView.rightAnchor).isActive = true
        companyTextField.topAnchor.constraint(equalTo: companyTitleLabel.bottomAnchor, constant: 0).isActive = true
        companyTextField.bottomAnchor.constraint(equalTo: companyContainerView.bottomAnchor, constant: -4).isActive = true
        
        
        companyTitleLabel.leftAnchor.constraint(equalTo: companyContainerView.leftAnchor, constant: 8).isActive = true
        companyTitleLabel.rightAnchor.constraint(equalTo: companyContainerView.rightAnchor, constant: -8).isActive = true
        companyTitleLabel.topAnchor.constraint(equalTo: companyContainerView.topAnchor, constant: 4).isActive = true
        companyHeightConstraint =  companyTitleLabel.heightAnchor.constraint(equalToConstant: 42)
        companyHeightConstraint?.isActive = true
        
        profileImageView.centerYAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true 
        
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        
        MyConstraints.sharedInstance.pinConstraints(motherView: view, viewToPin: backgroundImageView, leftMargin: 0, rightMargin: 0, topMargin: 0, bottomMargin: 0)
    }
    


}
