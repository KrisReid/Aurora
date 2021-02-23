//
//  ChatsView.swift
//  Aurora
//
//  Created by Kris Reid on 15/02/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ChatsView: View {
    
    @ObservedObject var chatVM = ChatsViewModel()
    @State private var showModal: Bool = false
    
    
    let users: [User] = [
        .init(id: "12345", name: "Sandra Bellwwrewewewe", mobileNumber: "07432426798", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"]),
        .init(id: "22344", name: "Sandra Froome", mobileNumber: "0712345677", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"]),
        .init(id: "456789", name: "Sandra Dell", mobileNumber: "039884828877", imageUrl: "Sandra", isCurrentUser: true, groups: ["33333","45672"]),
        .init(id: "789942", name: "Sandra Sellsby", mobileNumber: "03777662442", imageUrl: "Sandra", isCurrentUser: true, groups: ["2222","4467"]),
        .init(id: "34567", name: "Sandra Ollay", mobileNumber: "07432426556", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"])
    ]
    
    
    var body: some View {
        
        NavigationView {
            GeometryReader { proxy in
                LinearGradient(gradient: Gradient(colors: [Color("Background_Color"), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                ScrollView {
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: proxy.size.width / 2 - 20, maximum: 600), spacing: 5),
                    ], spacing: 5) {
                        
//                        ForEach(chatVM.groupUsers, id: \.self) { user in
                        ForEach(users, id: \.self) { user in
                            
                            VStack {
                                Image(user.imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: proxy.size.width / 2 - 40, height: 100)
                                
                                
                                Text(user.name)
                            }
                            .frame(height: 100)
                            .padding()
                            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: showCreateChatView) {
                Image(systemName: "plus")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .frame(width: 20, height: 20)
                    .padding()
            })

        }
        .sheet(isPresented: $showModal) {
            CreateChatView(isPresented: self.$showModal)
        }
    }

    private func showCreateChatView() {
        self.showModal = true
    }
    
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
