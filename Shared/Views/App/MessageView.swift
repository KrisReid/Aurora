//
//  MessageView.swift
//  Aurora
//
//  Created by Kris Reid on 27/02/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

struct MessageView : View {
    
    var currentMessage: Message
    var user: User
    var imageUrl: String
    var isCurrentUser: Bool
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 15) {
            
            if !isCurrentUser {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
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
        
        MessageView(currentMessage: Message(id: "999999", content: "Hello 😍", userId: "12345", timeDate: Timestamp(date: Date())), user: User(id: "54321", name: "Alison Bell", mobileNumber: "07515576273", imageUrl: "Sandra", isCurrentUser: false, groups: ["99999"]), imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fg0rRsxswllemj0nrp3lCBNYVGrj1.jpeg?alt=media&token=cf2d8fc9-74df-4591-bc20-0be03cc69f53", isCurrentUser: false)
        
    }
    
}
