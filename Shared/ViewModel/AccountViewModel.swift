//
//  AccountCreationViewModel.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import Foundation

class AccountCreationViewModel: ObservableObject {
    
    @Published var accounts = [AccountViewModel]()    
    
    init() {
        getAccount()
        
    }
    
    func getAccount() {
        print("Hellp")
    }
    
}



class AccountViewModel {
    
    let id = UUID()
    
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var name: String { return self.account.name }
    var mobileNumber: String { return self.account.phoneNumber}
    var imageName: String { return self.account.imageName}
    
}
