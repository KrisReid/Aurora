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
    
    @Published var user = User.init(name: "", mobileNumber: "", imageUrl: "")
    
//    @Published var mobileNumber = ""
//    @Published var name = ""
//    @Published var imageUrl = ""
    
    @Published var code = ""
    @Published var CODE = ""
    
    @Published var errorMsg = ""
    @Published var error = false
    @Published var loading = false
    @Published var gotoVerify = false
    @Published var accountCreation = false
    
    @Published var showingImagePicker: Bool = false
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var imagedata : Data = .init(count: 0)
    
    // User Logged Status
    @AppStorage("log_Status") var status = false
    
    
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
        
//        let number = "+\(getCountryCode())\(mobileNumber)"
        let number = "+\(getCountryCode())\(user.mobileNumber)"
        
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
            
            self.checkUser { [self] (exists, name, mobileNumber, imageUrl) in
                 if exists {
                    
                    self.user = .init(name: name, mobileNumber: mobileNumber, imageUrl: imageUrl)
                    
                    self.loading = false
                    withAnimation{self.status = true}
                    
                    
//                    self.name = name
//                    self.mobileNumber = mobileNumber
//                    self.imageUrl = imageUrl
                 }
                 else {
                    self.loading = false
                    self.accountCreation.toggle()
                 }
            }
        }
    }
    
    
    func checkUser(completion: @escaping (_ exists: Bool, _ name: String, _ mobileNumber: String, _ image: String) -> Void){
        
        Firestore.firestore().collection("users").getDocuments { (snap, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                if i.documentID == Auth.auth().currentUser?.uid {
                    
                    completion(true,i.get("name") as! String,i.get("mobileNumber") as! String,i.get("image") as! String)
                    return
                }
            }
            completion(false,"","","")
        }
    }
    
    
    
    func CreateUser() {
        
//        if self.name != "" {
        if user.name != "" {
            
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
                                
                                
                                let user: [String:Any] = [
                                    "name" : self.user.name,
                                    "mobileNumber" : "+\(self.getCountryCode())\(self.user.mobileNumber)",
                                    "image" : userProfileImage
                                ]
//                                let user: [String:Any] = [
//                                    "name": self.name,
//                                    "mobile": "+\(self.getCountryCode())\(self.mobileNumber)",
//                                    "image": userProfileImage
//                                ]

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
