//
//  Network.swift
//  ViPay
//
//  Created by Rock on 2018/8/24.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import Foundation
import Parse

class Network: NSObject {
    
    static let sharedInstance = Network()
    
    func initParse(){
        
        let config = ParseClientConfiguration {
            $0.applicationId = "KI007W5oO01RNq7nER0vRfzNtsA5oEw8X5Xh0IxK"
            $0.clientKey = "oG9NKjP2wWC467pu0iaj8ys2DhRTM7xPYaMo33h8"
            $0.server = "https://parseapi.back4app.com"
        }
        
        Parse.initialize(with: config)
        
    }
    
    
}
