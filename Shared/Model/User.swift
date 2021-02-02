//
//  User.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import Foundation


struct User: Codable {
    var email: String?
    var displayName: String?
    var profileImageUrl: String?

    init(email: String?, displayName: String?, profileImageUrl: String?) {
        self.email = email
        self.displayName = displayName
        self.profileImageUrl = profileImageUrl
    }
}
