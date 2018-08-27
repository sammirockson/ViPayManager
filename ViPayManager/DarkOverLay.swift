//
//  DarkOverLay.swift
//  cryptowallet
//
//  Created by Rock on 2018/5/31.
//  Copyright © 2018 Cybermiles. All rights reserved.
//

import UIKit


struct DarkOverLay {
    
    static let sharedInstance = DarkOverLay()

    let coloredBackground: UIView = {
        let v = UIView()
        v.backgroundColor = RGB.sharedInstance.requiredColor(r: 4, g: 33, b: 75, alpha: 1.0)
        return v
    }()
    
     func show(){
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            keyWindow.addSubview(coloredBackground)
            coloredBackground.frame = keyWindow.frame
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.coloredBackground.alpha = 0.70
                
            }) { (completed) in
                
                
            }
            
        }
        
      
        
    }
    
    func dismiss(){
       
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.coloredBackground.alpha = 0
            
        }) { (completed) in
            
            
            
            self.coloredBackground.removeFromSuperview()

         
        }
        
    }
}
