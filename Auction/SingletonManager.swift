//
//  SingletonManager.swift
//  Auction
//
//  Created by mac3 on 1/9/18.
//  Copyright © 2018 PACE. All rights reserved.
//

class GlobalVariables {
    var myToken:String = "EmptyToken"
    class var sharedManager:GlobalVariables{
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}
