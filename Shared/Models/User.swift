//
//  User.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import SwiftUI


struct User: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var mobileNumber: String
    var imageUrl: String
    var fcmToken: String
    var groups: [String]

    init(id: String, name: String, mobileNumber: String, imageUrl: String, fcmToken: String, groups: [String]) {
        self.id = id
        self.name = name
        self.mobileNumber = mobileNumber
        self.imageUrl = imageUrl
        self.fcmToken = fcmToken
        self.groups = groups
    }
}


struct Group: Codable, Hashable {
    var id: String
    var createdBy: String
    var members: [String]
    var createdOn: Date
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: createdOn)
    }
}
