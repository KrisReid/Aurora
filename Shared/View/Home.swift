//
//  Home.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    
    @AppStorage("log_Status") var status = false
    @ObservedObject var homeVM = HomeViewModel()
    
    
    var body: some View {
        
        VStack(spacing: 15){
            
            
            
            // Home View....
            Text("Logged In Successfully")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Button(action: {
                try? Auth.auth().signOut()
                withAnimation{status = false}
            }, label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
