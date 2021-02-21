//
//  Chats.swift
//  Aurora
//
//  Created by Kris Reid on 15/02/2021.
//

import SwiftUI

struct Chats: View {
    
    @ObservedObject var chatVM = ChatsViewModel()
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                LinearGradient(gradient: Gradient(colors: [Color("Background_Color"), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: proxy.size.width / 2 - 20, maximum: 600), spacing: 10),
                    ], spacing: 10) {
                        
//                        ForEach(0..<10, id: \.self) {urlString in
//                        ForEach(chatVM.user, id: \.self) { a in
                        ForEach(chatVM.groups, id: \.self) { group in
                            
                            Text(group.id)
                            Text(group.createdBy)
//                            Text(group.createdOn)

                            
                            Spacer()
                                .frame(height: 180)
                                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .opacity(0.5)

                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: showAddUserView) {
                Image(systemName: "plus")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .frame(width: 20, height: 20)
                    .padding()
            })
            
        }
        .sheet(isPresented: $showModal) {
            Home(isPresented: self.$showModal)
        }
    }
    
    private func showAddUserView() {
        self.showModal = true
    }
    
}

struct Chats_Previews: PreviewProvider {
    static var previews: some View {
        Chats()
    }
}
