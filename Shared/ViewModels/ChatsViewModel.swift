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
    
    
    @Published var user = [User]()
    @Published var groups = [Group]()
    
    
    init() {
        fetchCurrentUsersGroupChats()
    }
    
    
    func fetchAllUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else { return }
            self.user = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
    
//    func fetchCurrentUsersGroupChats() {
//        //Users UID
//        let uid = Auth.auth().currentUser?.uid ?? ""
//
//        //Get a users groups they have access to
//        Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
//            guard let documents = documentSnapshot else { return }
//            let groups = documents.get("groups") as! [String]
//
//            //Get the groups the user has access to and store them
//            Firestore.firestore().collection("groups").whereField("id", in: groups).getDocuments() { (querySnapshot, err) in
//                guard let documents = querySnapshot?.documents else { return }
//                self.groups = documents.compactMap { (queryDocumentSnapshot) -> Group? in
//                    return try? queryDocumentSnapshot.data(as: Group.self)
//                }
//            }
//        }
//    }
    
    
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
