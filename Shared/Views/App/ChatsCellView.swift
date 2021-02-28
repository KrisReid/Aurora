//
//  ChatsCellView.swift
//  Aurora (iOS)
//
//  Created by Kris Reid on 25/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatsCellView: View {
    
    let chat: Chat
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: chat.userImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                VStack (alignment: .leading) {
                    Text(chat.userName)
                        .font(.system(size: 16, weight: .regular))
                    Text(chat.userMobileNumber)
                        .font(.system(size: 14, weight: .light))
                }
                Spacer()
            }
            .padding()
            .background(Color("Chat_Cell_Background"))
            .cornerRadius(20)
            .frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}


struct ChatsCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatsCellView(chat: Chat(userId: "134562", userName: "Kris Reid", userMobileNumber: "07432426798", userImageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fg0rRsxswllemj0nrp3lCBNYVGrj1.jpeg?alt=media&token=cf2d8fc9-74df-4591-bc20-0be03cc69f53", UserisCurrentUser: true, groupId: "12345"))
            ChatsCellView(chat: Chat(userId: "442567", userName: "Ali Bell", userMobileNumber: "07399572455", userImageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FLA9ce4GbdfU863eEhchqSTlpdz92.jpeg?alt=media&token=1038a5b8-d8a2-4e60-8521-f7969ebb4e8e", UserisCurrentUser: true, groupId: "12345"))
        }
    }
}
