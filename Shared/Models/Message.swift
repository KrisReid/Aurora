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
    var id: String
    var content: String
    var userId: String
    var timeDate: Timestamp
}
