//
//  ChatsViewModel.swift
//  Aurora
//
//  Created by Kris Reid on 15/02/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift


class ChatsViewModel: ObservableObject {
    
    @Published var groups = [Group]()
    
    
    init() {
        fetchCurrentUsersGroupChats()
    }
    
    
    func fetchCurrentUsersGroupChats() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        Firestore.firestore().collection("groups").whereField("members", arrayContains: uid).addSnapshotListener { (documentSnapshot, error) in
            guard let documents = documentSnapshot?.documents else { return }
            self.groups = documents.compactMap { (queryDocumentSnapshot) -> Group? in
                return try? queryDocumentSnapshot.data(as: Group.self)
            }
        }
    }
    
    
}
