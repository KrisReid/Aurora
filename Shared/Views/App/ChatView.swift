//
//  ChatView.swift
//  Aurora
//
//  Created by Kris Reid on 22/02/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ChatView: View {
    
    let chat: Chat
    let user: User
    
    @State var typingMessage: String = ""

    @ObservedObject private var keyboard = KeyboardResponder()
    @ObservedObject var vm = ChatViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(vm.messages, id: \.self) { message in

                        if message.userId == user.id {
                            MessageView(currentMessage: message, user: user, imageUrl: chat.userImageUrl, isCurrentUser: true)
                        } else {
                            MessageView(currentMessage: message, user: user, imageUrl: chat.userImageUrl, isCurrentUser: false)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                HStack {
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                    .disabled(typingMessage == "" ? true : false)
                }
                .frame(minHeight: CGFloat(50)).padding()
            }
            .navigationBarTitle(Text(chat.userName), displayMode: .inline)
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        }
        .onAppear(perform: {
            vm.fetchGroupMessages(groupId: chat.groupId)
        })
        .onTapGesture {
            self.endEditing(true)
        }
    }

    func sendMessage() {
        vm.postMessage(content: typingMessage, userId: user.id, groupId: chat.groupId)
        typingMessage = ""
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: Chat(userId: "54321", userName: "Belly Buttton", userMobileNumber: "0751557728", userImageUrl: "Sandra", groupId: "99999"), user: User(id: "12346", name: "Kris Reid", mobileNumber: "07432426798", imageUrl: "Sandra", groups: ["99999"]), typingMessage: "Hello there 😍", vm: .init())
    }
}
