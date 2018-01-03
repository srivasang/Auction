//
//  OAuthResponse.swift
//  Auction
//
//  Created by mac3 on 1/3/18.
//  Copyright © 2018 PACE. All rights reserved.
//

import UIKit
import ObjectMapper

class OAuthResponse: NSObject, Mappable {
    
    // MARK: - Properties
    var accessToken: String?
    var expiresIn: Double?
    var refreshToken: String?
    var scope: String?
    var tokenType: String?
    
    // MARK: - Initialization
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
        refreshToken <- map["refresh_token"]
        scope <- map["scope"]
        tokenType <- map["token_type"]
    }
    
    // MARK: - Custom Methods
    func getAuthorization() -> String {
        return "\(self.tokenType ?? "") \(self.accessToken ?? "")"
    }
    
}
