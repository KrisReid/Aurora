//
//  User.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import Foundation


struct User: Codable {
    
    var name: String
    var mobileNumber: String
    var imageUrl: String

    init(name: String, mobileNumber: String, imageUrl: String) {
        self.name = name
        self.mobileNumber = mobileNumber
        self.imageUrl = imageUrl
    }
}

