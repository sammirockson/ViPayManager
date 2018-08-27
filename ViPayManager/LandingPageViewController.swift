//
//  LandingPageViewController.swift
//  ViPayManager
//
//  Created by Rock on 2018/8/26.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Background"), for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handlePopToSignUpVC), for: .touchUpInside)
        return button
    }()
    
    let declineOrderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 18)
        button.setTitleColor(defaultAppColor, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.layer.borderWidth = 0.1
        button.backgroundColor = .white
        button.layer.borderColor = defaultAppColor.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        UIApplication.shared.statusBarStyle = .lightContent
        setUpViews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handlePopToSignUpVC(){
        
        
        let vc = VerifyPhoneViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpViews(){
        
        view.addSubview(signUpButton)
        view.addSubview(declineOrderButton)
        
        
        declineOrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80).isActive = true
        declineOrderButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        declineOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if #available(iOS 11.0, *) {
            declineOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        } else {
            // Fallback on earlier versions
            declineOrderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
            
        }
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if #available(iOS 11.0, *) {
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        } else {
            // Fallback on earlier versions
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true

        }
        
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }

}
