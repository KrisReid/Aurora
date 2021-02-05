//
//  User.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import Foundation


struct User: Codable {
    
    var name: String?
    var mobile: String?
    var image: String?

    init(name: String?, mobile: String?, image: String?) {
        self.name = name
        self.mobile = mobile
        self.image = image
    }
}

