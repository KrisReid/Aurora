//
//  Chat.swift
//  Aurora
//
//  Created by Kris Reid on 28/02/2021.
//

import Foundation


struct Chat: Codable, Hashable {
    var reciever: User
    var groupId: String
    var lastMessage: String
}
