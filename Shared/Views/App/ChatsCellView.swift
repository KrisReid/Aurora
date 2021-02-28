//
//  ChatsCellView.swift
//  Aurora (iOS)
//
//  Created by Kris Reid on 25/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatsCellView: View {
    
    let user: User
    let backgroundColour: Color
    
    var body: some View {
        
        VStack {
            HStack {
                WebImage(url: URL(string: user.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                VStack (alignment: .leading) {
                    Text(user.name)
                        .font(.system(size: 16, weight: .regular))
                    Text(user.mobileNumber)
                        .font(.system(size: 14, weight: .light))
                }
                Spacer()
            }
            .padding()
            .background(backgroundColour)
            .cornerRadius(20)
            .frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}

struct ChatsCellView_Previews: PreviewProvider {
    static var previews: some View {

        VStack {
            ChatsCellView(user: User.init(id: "1253322234", name: "Kris Reid", mobileNumber: "07432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fg0rRsxswllemj0nrp3lCBNYVGrj1.jpeg?alt=media&token=cf2d8fc9-74df-4591-bc20-0be03cc69f53", isCurrentUser: true, groups: ["34566","22345"]), backgroundColour: Color(#colorLiteral(red: 0.7222563624, green: 0.8590399623, blue: 0.8006685376, alpha: 1)))
            
            ChatsCellView(user: User.init(id: "67654433", name: "Ali Bell", mobileNumber: "07515538824", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2FLA9ce4GbdfU863eEhchqSTlpdz92.jpeg?alt=media&token=1038a5b8-d8a2-4e60-8521-f7969ebb4e8e", isCurrentUser: true, groups: ["34566","22345"]), backgroundColour: Color(#colorLiteral(red: 0.7222563624, green: 0.8590399623, blue: 0.8006685376, alpha: 1)))
        }
    
    }
}
