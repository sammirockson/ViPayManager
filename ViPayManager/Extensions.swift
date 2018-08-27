//
//  Extensions.swift
//  Tracre
//
//  Created by Adriana Elizondo on 12/09/2017.
//  Copyright © 2017 Tracre. All rights reserved.
//

import Foundation
import UIKit

enum ButtonStatus {
    case Enabled, Disabled, BlueDisabled
}


extension Date {
    
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
    
    
}

extension String
{
    func toDate( dateFormat format  : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: self)!
    }
    
}

extension UIDevice {
    
    var isIphoneX: Bool {
        if #available(iOS 11.0, *), isIphone {
            if isLandscape {
                if let leftPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left, leftPadding > 0 {
                    return true
                }
                if let rightPadding = UIApplication.shared.keyWindow?.safeAreaInsets.right, rightPadding > 0 {
                    return true
                }
            } else {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top, topPadding > 0 {
                    return true
                }
                if let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottomPadding > 0 {
                    return true
                }
            }
        }
        return false
    }
    
    var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(orientation) || UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }
    
    var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(orientation) || UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    }
    
    var isIphone: Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad
    }
}

extension UIButton{
    func style(with status: ButtonStatus, and title: String){
        self.setTitle(title, for: .normal)
        
        switch status {
        case .Enabled:
            self.backgroundColor = UIColor(displayP3Red: 19/255, green: 66/255, blue: 94/255, alpha: 1.0)
            self.contentHorizontalAlignment = .center
            self.contentEdgeInsets = UIEdgeInsets.zero
            setTitleColor(UIColor.white, for: .normal)
            self.isEnabled = true
        case .Disabled:
            self.backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
            self.setTitleColor(UIColor(displayP3Red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0), for: .normal)
            self.isEnabled = false
        case .BlueDisabled:
            self.backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
            self.setTitleColor(UIColor(displayP3Red: 19/255, green: 66/255, blue: 94/255, alpha: 1.0), for: .normal)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            self.contentHorizontalAlignment = .left
            self.isEnabled = false
        }
    }
}

extension String {
    /// firstLetter: Returns a string created with uppercased character of itself
    func firstLetter() -> String {
        return self.prefix(1).uppercased()
    }
}

extension UIViewController{
    func changeNetworkActivityIndicator(to visible: Bool){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
}

extension UIView{
    /// roundCorners: Sets a corner radius of 6 to the view
    func roundCorners(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
    }
    
    func roundCornersBack(){
        self.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
    }
    
    func roundBack(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    /// makeCircular: Sets the corner radius to half of the width of the view in order to make it circular
    func makeCircular(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
    /// loadXibView: Returns a UIView with a specified frame, loaded from an xib file with the same className of the view
    func loadXibView(with xibFrame: CGRect) -> UIView {
        let className = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        guard let xibView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return UIView()
        }
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        xibView.frame = xibFrame
        return xibView
    }
}


extension UIImage {
    /// 更改图片颜色
    public func imageWithTintColor(color : UIColor) -> UIImage{
        
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
}


