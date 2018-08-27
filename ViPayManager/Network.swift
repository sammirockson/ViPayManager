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
            $0.applicationId = "ATyPSdKPwkaPOJHl6btDi4jFe0atz9h50wcdPo47"
            $0.clientKey = "HTag0BymffPPGGazDhcYPb1YYK6BpRvFAgA33pyk"
            $0.server = "https://parseapi.back4app.com"
        }
        
        Parse.initialize(with: config)
        
    }
    
    
}
