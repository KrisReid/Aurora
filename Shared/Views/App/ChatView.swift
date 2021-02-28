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
    
//    let user: User
    let user: Chat

    
    @State var typingMessage: String = ""
    @ObservedObject private var keyboard = KeyboardResponder()
    
    @ObservedObject var vm = ChatViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    ForEach(vm.messages, id: \.self) { message in
                        MessageView(currentMessage: message)
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
            .navigationBarTitle(Text("Change"), displayMode: .inline)
            .padding(.bottom, keyboard.currentHeight)
            .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }
    
    
    
    func sendMessage() {
        let user = User(id: "987662", name: "Kris", mobileNumber: "0743256643", imageUrl: "2222", isCurrentUser: true, groups: [])
        let message = Message(id: "123", content: typingMessage, user: user, timeDate: Timestamp(date: Date()))
        
        vm.postMessage(message: message)
        typingMessage = ""
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(user: Chat(userId: "12345", userName: "Kris Reid", userMobileNumber: "09876266733", userImageUrl: "Sandra", UserisCurrentUser: true, groupId: "13552"))
        
//        ChatView(user: User(id: "12345", name: "Sandra Belle", mobileNumber: "07432426798", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"]))
    }
}
