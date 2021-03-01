//
//  ChatsView.swift
//  Aurora
//
//  Created by Kris Reid on 15/02/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ChatsView: View {
    
    @ObservedObject var vm = ChatsViewModel()
    @State private var showModal: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Background_Color"), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            
                Color("Chat_Background")
                    .offset(y: 400)
                
                VStack {
                    
                    UserView(user: vm.currentUser)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    ScrollView {
                        VStack {
                            
                            ForEach(vm.chats, id: \.self) { chat in
                                NavigationLink (
                                    destination: ChatView(chat: chat, user: vm.currentUser),
                                    label: {
                                        ChatsCellView(chat: chat)
                                            .foregroundColor(Color(.label))
                                    }
                                )
                            }
                            .padding(.top, 15)
                        }
                        .frame(minWidth: UIScreen.main.bounds.width, idealWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity, alignment: .top)
                        .background(Color("Chat_Background"))
                        .cornerRadius(16)
                        .padding(.top, 30)
                    }
                    .navigationTitle("Chats")
                    .navigationBarItems(trailing: Button(action: showCreateChatView) {
                    Image(systemName: "plus")
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .frame(width: 20, height: 20)
                        .padding()
                    })
                }
            }
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



