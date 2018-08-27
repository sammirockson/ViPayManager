//
//  CustomTabBarController.swift
//  GhPay
//
//  Created by Rockson on 07/09/2017.
//  Copyright © 2017 RockzAppStudio. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let homeVC = OrdersViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem.title = "Order"
        homeVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "HomeSelected")
        homeVC.tabBarItem.image = #imageLiteral(resourceName: "HomeUnselected")
        homeVC.tabBarItem.tag = 1

        let shoppingVC = ShopViewController()
        let shoppingNav = UINavigationController(rootViewController: shoppingVC)
        shoppingVC.tabBarItem.title = "Shop"
        shoppingVC.tabBarItem.image = #imageLiteral(resourceName: "shopUnselected")
        shoppingVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "shopSelected")


        
        
        viewControllers = [homeNav,shoppingNav]
        
        
        

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

  
}
