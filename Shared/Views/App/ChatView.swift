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
                    ScrollViewReader { value in
                        
//                        Button("Jump to last") {
//                            value.scrollTo(vm.messages.last?.id, anchor: .bottom)
//                        }
                        
                        ForEach(vm.messages, id: \.self) { message in
                            MessageView(currentMessage: message, imageUrl: chat.userImageUrl, isCurrentUser: message.userId == user.id ? true : false)
                                .id(message.id)
                        }
                        .onAppear(perform: {
//                            value.scrollTo("KhkuZDCZLRj5fWVJzR9l", anchor: .bottom)
                            value.scrollTo(vm.messages.last?.id, anchor: .bottom)
                        })
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
        ChatView(chat: Chat(userId: "1GZDkkomqobMPhpaqUirtClFHLq1", userName: "Alison MB", userMobileNumber: "+447515509832", userImageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", groupId: "eUMO0EvYTXwqSon9Ppze"), user: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", groups: ["eUMO0EvYTXwqSon9Ppze"]))
    }
}
