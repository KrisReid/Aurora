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
    @Published var groupUsers = [User]()
    @Published var currentUser = User(id: "", name: "", mobileNumber: "", imageUrl: "", isCurrentUser: true, groups: [])
    
    
    init() {
        fetchCurrentUser()
        fetchCurrentUsersGroupChats()
    }
    
    func fetchCurrentUser() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }
            try? self.currentUser = document.data(as: User.self) ?? User(id: "", name: "", mobileNumber: "", imageUrl: "", isCurrentUser: false, groups: [])
        }
            
//        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
//            if let document = document, document.exists {
//                try? self.currentUser = document.data(as: User.self) ?? User(id: "", name: "", mobileNumber: "", imageUrl: "", isCurrentUser: false, groups: [])
//            } else {
//                print("Document does not exist")
//            }
//        }

    }
    
    
    func fetchCurrentUsersGroupChats() {
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        Firestore.firestore().collection("groups").whereField("members", arrayContains: uid).addSnapshotListener { (documentSnapshot, error) in
            guard let documents = documentSnapshot?.documents else { return }
//            let groups = documents.compactMap { (queryDocumentSnapshot) -> Group? in
//                return try? queryDocumentSnapshot.data(as: Group.self)
//            }


            self.groups = documents.map { (queryDocumentSnapshot) -> Group in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let createdBy = data["createdBy"] as? String ?? ""
                let members = data["members"] as? [String] ?? [""]
                let createdOn = (data["createdOn"] as? Timestamp)?.dateValue() ?? Date()

                //get users which aren't me and where the group is within the group array
                print("00000000000")

                self.fetchUserGroups(uid: uid, id: id)

                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn)
            }
            
        }
    }
    
    private func fetchUserGroups(uid: String, id: String) {
//        Firestore.firestore().collection("users").whereField("groups", isEqualTo: [id]).whereField("id", isNotEqualTo: uid).addSnapshotListener { (querySnapshot, error) in
        Firestore.firestore().collection("users").whereField("groups", isEqualTo: [id]).whereField("id", isNotEqualTo: uid).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { return }
            self.groupUsers.append(contentsOf: documents.compactMap({ (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }))
//            self.groupUsers = documents.compactMap { (queryDocumentSnapshot) -> User? in
//                return try? queryDocumentSnapshot.data(as: User.self)
//            }
        }
    }
}
