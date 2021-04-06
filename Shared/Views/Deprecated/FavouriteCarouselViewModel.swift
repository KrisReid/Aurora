////
////  FavouriteCarouselViewModel.swift
////  Aurora
////
////  Created by Kris Reid on 06/04/2021.
////
//
//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//
//class FavouriteCarouselViewModel: ObservableObject {
//    
//    @Published var favourites = [User]()
//    
//    init(users: [String]) {
//        fetchFavouriteUsers(users: users)
//    }
//    
//    func fetchFavouriteUsers(users: [String]) {
//        
//        print("11111111111111")
//        print(users)
//
//        Firestore.firestore().collection("users").whereField("id", in: users).addSnapshotListener { (querySnapshot, error) in
//
//            guard let documents = querySnapshot?.documents else { return }
//            self.favourites = documents.compactMap { (queryDocumentSnapshot) -> User? in
//                return try? queryDocumentSnapshot.data(as: User.self)
//            }
//        }
//    }
//    
//}
//
