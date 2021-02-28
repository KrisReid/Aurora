//
//  ChatViewModel.swift
//  Aurora
//
//  Created by Kris Reid on 27/02/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class ChatViewModel: ObservableObject {
        
    @Published var messages = [Message]()
    
    init() {
//        fetchData()
    }

    
    
    func fetchDataTwo(groupId: String) {
        Firestore.firestore().collection("groups").document(groupId).collection("messages").order(by: "timeDate").addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else { return }
            self.messages = documents.compactMap { (queryDocumentSnapshot) -> Message? in
                return try? queryDocumentSnapshot.data(as: Message.self)
            }
        }
    }
    
    
    func fetchData() {
        Firestore.firestore().collection("groups").document("eUMO0EvYTXwqSon9Ppze").collection("messages").order(by: "timeDate").addSnapshotListener { documentSnapshot, error in
//        Firestore.firestore().collection("messages").order(by: "timeDate").addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else { return }
            self.messages = documents.compactMap { (queryDocumentSnapshot) -> Message? in
                return try? queryDocumentSnapshot.data(as: Message.self)
            }
        }
    }
    
    
    func postMessage(content: String, userId: String) {
        
        
        
        do {
            print(content)
//            let _ = try Firestore.firestore().collection("messages").addDocument(from: message)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
//    func postMessage(message: Message) {
//        do {
//            let _ = try Firestore.firestore().collection("messages").addDocument(from: message)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
    
    
}
