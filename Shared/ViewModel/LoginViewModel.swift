//
//  LoginViewModel.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class LoginViewModel: ObservableObject {
    
    @Published var user: User?
    
    @Published var mobileNumber = ""
    @Published var name = ""
    @Published var code = ""
    @Published var errorMsg = ""
    @Published var error = false
    @Published var CODE = ""
    @Published var gotoVerify = false
    @Published var accountCreation = false
    @Published var image: Image?
    @Published var showingImagePicker: Bool = false
    @Published var inputImage: UIImage?
    @Published var imagedata : Data = .init(count: 0)
    
    // User Logged Status
    @AppStorage("log_Status") var status = false
    
    // Loading View....
    @Published var loading = false
    
    
    func getCountryCode() -> String {
        let countryCode = Locale.current.regionCode ?? ""
        return countries[countryCode] ?? ""
    }
    
    func sendCode(){
        self.loading = true
        
        //false = Real Device Testing
        //true = Mock Testing
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        //Set for testing on simulator 
//        let number = "+44\(mobileNumber)"
        let number = "+\(getCountryCode())\(mobileNumber)"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            
            if let error = err {
                self.loading = false
                print(error.localizedDescription)
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle()}
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
            self.loading = false
        }
    }
    
    func verifyCode(){
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        self.loading = true
        
        Auth.auth().signIn(with: credential) { (result, err) in
            
            if let error = err{
                self.loading = false
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle()}
                return
            }
            self.loading = false
            self.accountCreation.toggle()
        }
    }
    
    
    func CreateUser() {
        
        if self.name != "" {
            
            self.loading = true
            
            let db = Firestore.firestore().collection("users")
            let storage = Storage.storage().reference().child("users")
            let uid = Auth.auth().currentUser?.uid
            
            if let uploadData = self.inputImage!.jpegData(compressionQuality: 0.75) {
                
                storage.child("\(uid ?? "").jpeg").putData(uploadData, metadata: nil) { (meta, error) in
                    if let error = error {
                        self.errorMsg = error.localizedDescription
                        withAnimation{ self.error.toggle()}
                        self.loading = false
                    } else {
                        storage.child("\(uid ?? "").jpeg").downloadURL { (url, error) in
                            if let url = url, error == nil {
                                let userProfileImage = url.absoluteString
                                
//                                let user = User.init(name: self.name, mobile: "+\(self.getCountryCode())\(self.mobileNumber)", image: userProfileImage)
                                let user: [String:Any] = [
                                    "name": self.name,
                                    "mobile": "+\(self.getCountryCode())\(self.mobileNumber)",
                                    "image": userProfileImage
                                ]

                                db.document(uid!).setData(user) { err in
                                    self.loading = false
                                    if err != nil {
                                        self.errorMsg = err?.localizedDescription ?? "Error"
                                        withAnimation{ self.error.toggle()}
                                    } else {
                                        self.accountCreation.toggle()
                                        withAnimation{self.status = true}
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            self.errorMsg = "Name field can not be empty"
            withAnimation{ self.error.toggle()}
        }
    }
    
    
}
