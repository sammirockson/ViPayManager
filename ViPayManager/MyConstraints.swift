//
//  MyConstraints.swift
//  ViPay
//
//  Created by Rock on 2018/8/24.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class MyConstraints: NSObject {
    
    static let sharedInstance = MyConstraints()
    
    func pinConstraints(motherView: UIView, viewToPin: UIView, leftMargin: CGFloat, rightMargin: CGFloat, topMargin: CGFloat, bottomMargin: CGFloat){
        viewToPin.rightAnchor.constraint(equalTo: motherView.rightAnchor, constant: rightMargin).isActive = true
        viewToPin.leftAnchor.constraint(equalTo: motherView.leftAnchor, constant: leftMargin).isActive = true
        viewToPin.topAnchor.constraint(equalTo: motherView.topAnchor, constant: topMargin).isActive = true
        viewToPin.bottomAnchor.constraint(equalTo: motherView.bottomAnchor, constant: bottomMargin).isActive = true
        
    }
    
    func pinWithHeight(motherView: UIView, viewToPin: UIView, leftMargin: CGFloat?, rightMargin: CGFloat?, topMargin: CGFloat?, bottomMargin: CGFloat?, height: CGFloat?, width: CGFloat?){
        
        if topMargin != nil {
            
            viewToPin.topAnchor.constraint(equalTo: motherView.topAnchor, constant: topMargin!).isActive = true

        }
        
        if rightMargin != nil {
            
            viewToPin.rightAnchor.constraint(equalTo: motherView.rightAnchor, constant: rightMargin!).isActive = true

        }
        
        if leftMargin != nil {
            
            viewToPin.leftAnchor.constraint(equalTo: motherView.leftAnchor, constant: leftMargin!).isActive = true

            
        }
        
        if bottomMargin != nil {
            
            viewToPin.bottomAnchor.constraint(equalTo: motherView.bottomAnchor, constant: bottomMargin!).isActive = true

        }
        
        if height != nil {
            
            viewToPin.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
        
        if width != nil {
            
            viewToPin.widthAnchor.constraint(equalToConstant: width!).isActive = true 
        }
        
    }
    
    
   
}
