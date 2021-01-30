//
//  LoginViewModel.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var mobileNumber = ""
    @Published var name = ""
    @Published var image = ""
    @Published var code = ""
    @Published var errorMsg = ""
    @Published var error = false
    @Published var CODE = ""
    @Published var gotoVerify = false
    @Published var accountCreation = false

    // User Logged Status
    @AppStorage("log_Status") var status = false
    
    // Loading View....
    @Published var loading = false
    
    
    func getCountryCode() -> String {
        let countryCode = Locale.current.regionCode ?? ""
        return countries[countryCode] ?? ""
    }
    
    func sendCode(){
        print("Toggle0: \(self.loading)")
        self.loading = true
        print("Toggle00: \(self.loading)")
        
        // enabling testing code...
        // disable when you need to test with real device...
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        let number = "+\(getCountryCode())\(mobileNumber)"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            
            if let error = err {
                print("Toggle1: \(self.loading)")
                self.loading = false
                print(error.localizedDescription)
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle()}
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
            print("Toggle2: \(self.loading)")
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
    
    func createAccount() {
        
        if self.name != "" {
            accountCreation.toggle()
            withAnimation{self.status = true}
        }
        
    }
    
}
