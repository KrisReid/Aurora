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

    }

    func fetchData(groupId: String) {
        Firestore.firestore().collection("groups").document(groupId).collection("messages").order(by: "timeDate").addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else { return }
            self.messages = documents.compactMap { (queryDocumentSnapshot) -> Message? in
                return try? queryDocumentSnapshot.data(as: Message.self)
            }
        }
    }

    
    
    
    func postMessage(content: String, userId: String, groupId: String) {
        do {
            let newMessageRef = Firestore.firestore().collection("groups").document(groupId).collection("messages").document()
            let message = Message(id: newMessageRef.documentID, content: content, userId: userId, timeDate: Timestamp(date: Date()))
            try newMessageRef.setData(from: message)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
