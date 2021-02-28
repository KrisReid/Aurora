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
            
                Color.white
                    .offset(y: 400)
                
                VStack {
                    
                    UserView(user: vm.currentUser)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    ScrollView {
                        VStack {
                            
                            ForEach(vm.groupUsers, id: \.self) { chat in
                                NavigationLink (
                                    destination: ChatView(chat: chat),
                                    label: {
                                        ChatsCellView(chat: chat)
                                            .foregroundColor(Color(.label))
                                    }
                                )
                            }
                            .padding(.top, 15)
                        }
                        .frame(minWidth: UIScreen.main.bounds.width, idealWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity, alignment: .top)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
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



