//
//  Chat.swift
//  Aurora
//
//  Created by Kris Reid on 28/02/2021.
//

import Foundation


struct Chat: Codable, Hashable {
//    var reciever: User
    var userId: String
    var userName: String
    var userMobileNumber: String
    var userImageUrl: String
    var userFcmToken: String
    var groupId: String
    
}
