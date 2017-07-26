//
//  Constants.swift
//  Contacts
//
//  Created by Roland Beke on 25.7.17.
//  Copyright © 2017 Roland Beke. All rights reserved.
//

import UIKit

enum Constants {
    
    private static let api = "http://private-36f1e-contactstest.apiary-mock.com/contacts"
    
    static let ordersUrl = api + ""
    static let addUrl = api + ""
    static let mailDomain = "@somewhere.com"
    
    static func detailUrl(id: String) -> String {
        
        return api + "/" + id + "/order"
    }
}
