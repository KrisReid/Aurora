//
//  HomeViewModel.swift
//  Aurora
//
//  Created by Kris Reid on 07/02/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class HomeViewModel: ObservableObject {
    
    @Published var user: User?
    
    init() {
        
        LoginViewModel().checkUser { [self] (exists, name, mobileNumber, imageUrl, isCurrentUser, groups) in
             if exists {
                self.user = User(name: name, mobileNumber: mobileNumber, imageUrl: imageUrl, isCurrentUser: isCurrentUser, groups: groups)
             }
        }
    }
    
}
