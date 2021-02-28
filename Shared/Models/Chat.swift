//
//  Chat.swift
//  Aurora
//
//  Created by Kris Reid on 28/02/2021.
//

import Foundation


struct Chat: Codable, Hashable {
    
    var userId: String
    var userName: String
    var userMobileNumber: String
    var userImageUrl: String
    var UserisCurrentUser: Bool
    var groupId: String
    
}
