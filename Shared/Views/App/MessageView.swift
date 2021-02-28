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
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 15) {
            if !currentMessage.user.isCurrentUser {
                Image(currentMessage.user.imageUrl)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            } else {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.content, isCurrentUser: currentMessage.user.isCurrentUser)
            
            if !currentMessage.user.isCurrentUser {
                Spacer()
            }
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        
        MessageView(currentMessage: Message(id: "1234", content: " SwiftUI 😍", user: User(id: "Hey", name: "Kris", mobileNumber: "07432426798", imageUrl: "aaa", isCurrentUser: true, groups: []), timeDate: Timestamp(date: Date())))
    }
    
}
