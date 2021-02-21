//
//  Home.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct Home: View {
    
    @AppStorage("log_Status") var status = false
    @ObservedObject var homeVM = HomeViewModel()
    
    @Binding var isPresented: Bool
    
    
    var body: some View {
        
        VStack(spacing: 15){
            
            WebImage(url: URL(string: homeVM.user?.imageUrl ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding(.horizontal)
                .padding(.top)
            
            // Home View....
            Text(homeVM.user?.name ?? "")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Text(homeVM.user?.mobileNumber ?? "")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.lightGray))
            
            Spacer()
            
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
        Home(isPresented: .constant(false))
    }
}
