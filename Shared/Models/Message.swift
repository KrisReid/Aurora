//
//  Message.swift
//  Aurora
//
//  Created by Kris Reid on 27/02/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Message : Identifiable, Codable, Hashable {
//    @DocumentID var id: String? = UUID().uuidString
    var id: String
    var content: String
    var user: User
//    var timeDate: Date
    var timeDate: Timestamp
}
