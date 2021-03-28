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
    @Published var chats = [Chat]()
    @Published var currentUser = User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", groups: [])
    
    
    init() {
        fetchCurrentUser()
        fetchCurrentUsersGroupChats()
    }
    
    
    func fetchCurrentUser() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else { return }
            try? self.currentUser = document.data(as: User.self) ?? User(id: "", name: "", mobileNumber: "", imageUrl: "", fcmToken: "", groups: [])
            
            //Register for push notifications
            let pushManager = PushNotificationManager(userID: uid)
            pushManager.registerForPushNotifications()
            
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
                self.fetchRecieverInformationFromGroup(uid: uid, groupId: id)

                return Group(id: id, createdBy: createdBy, members: members, createdOn: createdOn)
            }
            
        }
    }
    
    //Fetch the other contact from within the group ID that is passed
    private func fetchRecieverInformationFromGroup(uid: String, groupId: String) {
        Firestore.firestore().collection("users").whereField("groups", isEqualTo: [groupId]).whereField("id", isNotEqualTo: uid).getDocuments { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else { return }
            
            self.chats.append(contentsOf: documents.map({ (queryDocumentSnapshot) -> Chat in
                let data = queryDocumentSnapshot.data()
                
                let recieverId = data["id"] as? String ?? ""
                let recieverName = data["name"] as? String ?? ""
                let recieverMobileNumber = data["mobileNumber"] as? String ?? ""
                let recieverFcmToken = data["fcmToken"] as? String ?? ""
                let recieverImageUrl = data["imageUrl"] as? String ?? ""
                let recieverGroups = data["groups"] as? [String] ?? [""]
                
                return Chat(reciever: User(id: recieverId, name: recieverName, mobileNumber: recieverMobileNumber, imageUrl: recieverImageUrl, fcmToken: recieverFcmToken, groups: recieverGroups), groupId: groupId)
                
            }))
        }
    }
    
}

