//
//  OptimizedFont.swift
//  Tracre
//
//  Created by Rock on 2018/8/27.
//  Copyright © 2018 Tracre. All rights reserved.
//

import UIKit


class OptimizedFont {
    
   static func font(fontName: String, fontSize: CGFloat) -> UIFont {

        var calculatedFont = UIFont(name: fontName, size: fontSize)
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFont = UIFont(name: fontName, size: fontSize * 0.7)
            break
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFont = UIFont(name: fontName, size: fontSize * 0.8)
            break
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFont = UIFont(name: fontName, size: fontSize * 0.9)
            break
        
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            calculatedFont = UIFont(name: fontName, size: fontSize)
            break
        case 812.0: //iPhone X   5.65 inch
            calculatedFont = UIFont(name: fontName, size: fontSize)
        default:
            print("not an iPhone")
            break
        }
        
        return calculatedFont!
    }
    
    
}
