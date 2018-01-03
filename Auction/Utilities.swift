//
//  Utilities.swift
//  Auction
//
//  Created by mac3 on 1/3/18.
//  Copyright © 2018 PACE. All rights reserved.
//

import Foundation

class Utilities: NSObject {
    // MARK: - Properties
    static let sharedInstance = Utilities()
    var oauthResponse: OAuthResponse?
    var userId: String?
    
    // MARK: - Initialization
    private override init() {
        super.init()
    }
    
}
