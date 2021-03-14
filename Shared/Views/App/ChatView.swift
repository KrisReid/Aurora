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
    @ObservedObject var vm: ChatViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { value in
                    
                    Text("Keyboard Height: \(keyboard.currentHeight)")
                    
                    //Why does this line of code actually make things work? Is it just aa timing thing????
                    Button("") {
                        value.scrollTo(vm.messages.last?.id, anchor: .bottom)
                    }
                    
                    ForEach(vm.messages, id: \.self) { message in
                        
                        MessageView(currentMessage: message, imageUrl: chat.userImageUrl, isCurrentUser: message.userId == user.id ? true : false)
                            .id(message.id)
                    }
                    .onAppear(perform: {
                        value.scrollTo(vm.messages.last?.id, anchor: .bottom)
                    })
                }
            }
            .padding(.horizontal)
            .padding(.bottom, keyboard.currentHeight == 0.0 ? 0 : 40)
            
            Spacer()

            HStack {
                TextEditor(text: $typingMessage)
                    .frame(width: .infinity, height: 55)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(#colorLiteral(red: 0.8078074455, green: 0.8181154728, blue: 0.8177809715, alpha: 1)), lineWidth: 1)
                    )
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.leading)
                        .foregroundColor(typingMessage == "" ? Color.gray : Color.blue)
                }
                .disabled(typingMessage == "" ? true : false)
            }
            .padding(.bottom, keyboard.currentHeight == 0.0 ? 0 : keyboard.currentHeight)
            .frame(minHeight: CGFloat(50)).padding()
        }
        .navigationBarTitle(Text(chat.userName), displayMode: .inline)
        .padding(.bottom, keyboard.currentHeight == 0.0 ? 0 : 40)
        .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading : .bottom)
        .onTapGesture {
            self.endEditing(true)
        }
    }

    func sendMessage() {
        vm.postMessage(content: typingMessage, userId: user.id, groupId: chat.groupId)
        typingMessage = ""
        hideKeyboard()
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chat: Chat(userId: "1GZDkkomqobMPhpaqUirtClFHLq1", userName: "Alison MB", userMobileNumber: "+447515509832", userImageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2F1GZDkkomqobMPhpaqUirtClFHLq1.jpeg?alt=media&token=41fd4a78-61e2-44b7-96c0-c22a40da18f2", groupId: "eUMO0EvYTXwqSon9Ppze"), user: User(id: "RtJMCaH57QMBXMxb0q5CLUohgzW2", name: "Kris", mobileNumber: "+447432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FRtJMCaH57QMBXMxb0q5CLUohgzW2.jpeg?alt=media&token=06455850-2c7f-4cce-ad82-55e1c395b906", groups: ["eUMO0EvYTXwqSon9Ppze"]), vm: .init(groupId: "eUMO0EvYTXwqSon9Ppze"))
    }
}
