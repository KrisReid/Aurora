//
//  MessageView.swift
//  Aurora
//
//  Created by Kris Reid on 27/02/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MessageView : View {
    
    var currentMessage: Message
    var user: User
    var isCurrentUser: Bool
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 15) {
            
            if !isCurrentUser {
                Image("Sandra")
//                Image(currentMessage.userImageUrl)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            } else {
                Spacer()
            }
            
            ContentMessageView(contentMessage: currentMessage.content, isCurrentUser: isCurrentUser)
            
            if !isCurrentUser {
                Spacer()
            }
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        
        MessageView(currentMessage: Message(id: "999999", content: "Hello 😍", userId: "12345", timeDate: Timestamp(date: Date())), user: User(id: "54321", name: "Alison Bell", mobileNumber: "07515576273", imageUrl: "Sandra", isCurrentUser: false, groups: ["99999"]), isCurrentUser: false)
        
    }
    
}
