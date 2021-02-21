//
//  User.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct User: Codable, Hashable {
    
    var name: String
    var mobileNumber: String
    var imageUrl: String
    var isCurrentUser: Bool
    var groups: [String]

    init(name: String, mobileNumber: String, imageUrl: String, isCurrentUser: Bool, groups: [String]) {
        self.name = name
        self.mobileNumber = mobileNumber
        self.imageUrl = imageUrl
        self.isCurrentUser = isCurrentUser
        self.groups = groups
    }
}


struct Group: Codable, Hashable {
    var id: String
    var createdOn: Timestamp
    var createdBy: String
    var members: [String]
}
