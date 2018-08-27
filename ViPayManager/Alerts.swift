//
//  Alerts.swift
//  cryptowallet
//
//  Created by Rock on 2018/5/29.
//  Copyright © 2018 Cybermiles. All rights reserved.
//

import UIKit


struct Alerts {
    
    static let shareInstance = Alerts()
    
    func alertDisplay(vc: UIViewController, reason: String){
        
        let alert = UIAlertController(title: "", message: reason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
}
