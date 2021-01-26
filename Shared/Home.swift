//
//  Home.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    var body: some View {
        
        VStack {
            Text("Home")
            
            Button(action: {
                
                try! Auth.auth().signOut()
                
                UserDefaults.standard.set(false, forKey: "status")
                
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }, label: {
                
                Text("Sign Out")
            })
        }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
