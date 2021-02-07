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
    
    @Published var name = ""
    @Published var mobileNumber = ""
    @Published var imageUrl = ""
    
    init() {
        LoginViewModel().checkUser { [self] (exists, name, mobileNumber, imageUrl) in
//        self.checkUser { [self] (exists, name, mobileNumber, imageUrl) in
             if exists {
                self.name = name
                self.mobileNumber = mobileNumber
                self.imageUrl = imageUrl
             }
        }
    }
    
}
