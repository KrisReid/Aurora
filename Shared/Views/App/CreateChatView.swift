//
//  CreateChatView.swift
//  Aurora
//
//  Created by Kris Reid on 21/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateChatView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var vm = CreateChatViewModel()
    
//    let users: [User] = [
//        .init(id: "12345", name: "Sandra Belle", mobileNumber: "07432426798", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"]),
//        .init(id: "22344", name: "Sandra Froome", mobileNumber: "0712345677", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"]),
//        .init(id: "34567", name: "Sandra Ollay", mobileNumber: "07432426556", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"])
//    ]
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Background_Color"), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Text("New Chat")
                    .font(.system(size: 20, weight: .bold))
                    .offset(y: 20)
                
                NavigationView {
                    List(vm.users) { user in
                        Button(action: {
                            self.isPresented.toggle()
                        }, label: {
                            UserCellView(user: user)
                        })
                    }
                    .navigationBarHidden(true)
                }
                .offset(y: 30)
            }
        }
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView(isPresented: .constant(false))
    }
}


struct UserCellView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: user.imageUrl))
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(height: 50)
            
            VStack (alignment: .leading) {
                Text(user.name)
                    .font(.system(size: 16, weight: .regular))
                
                Text(user.mobileNumber)
                    .font(.system(size: 14, weight: .light))
            }
        }
    }
}
