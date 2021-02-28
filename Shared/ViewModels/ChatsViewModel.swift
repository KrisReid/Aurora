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
    @Published var groupUsers = [Chat]()
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
    }
    
    
    func fetchCurrentUsersGroupChats() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        Firestore.firestore().collection("groups").whereField("members", arrayContains: uid).addSnapshotListener { (documentSnapshot, error) in
            guard let documents = documentSnapshot?.documents else { return }
            
            self.groups = documents.map { (queryDocumentSnapshot) -> Group in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let createdBy = data["createdBy"] as? String ?? ""
                let members = data["members"] as? [String] ?? [""]
                let createdOn = (data["createdOn"] as? Timestamp)?.dateValue() ?? Date()

                //get users which aren't me and where the group is within the group array
                self.fetchGroupUser(uid: uid, id: id)

                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn)
            }
            
        }
    }
    
    
    private func fetchGroupUser(uid: String, id: String) {
        Firestore.firestore().collection("users").whereField("groups", isEqualTo: [id]).whereField("id", isNotEqualTo: uid).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else { return }
            
            self.groupUsers.append(contentsOf: documents.map({ (queryDocumentSnapshot) -> Chat in
                let data = queryDocumentSnapshot.data()
                let userId = data["id"] as? String ?? ""
                let userName = data["name"] as? String ?? ""
                let userMobileNumber = data["mobileNumber"] as? String ?? ""
                let userImageUrl = data["imageUrl"] as? String ?? ""
                let UserisCurrentUser = data["isCurrentUser"] as? Bool ?? true
                
                return Chat(userId: userId, userName: userName, userMobileNumber: userMobileNumber, userImageUrl: userImageUrl, UserisCurrentUser: UserisCurrentUser, groupId: id)
            }))
        }
    }
    
}

