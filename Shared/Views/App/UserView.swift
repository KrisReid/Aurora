//
//  UserView.swift
//  Aurora
//
//  Created by Kris Reid on 28/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserView: View {
    
    let user: User
    
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
            .background(Color("Background_Color"))
            .cornerRadius(20)
            .frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User.init(id: "1253322234", name: "Kris Reid", mobileNumber: "07432426798", imageUrl: "https://firebasestorage.googleapis.com/v0/b/aurora-2086f.appspot.com/o/users%2Fg0rRsxswllemj0nrp3lCBNYVGrj1.jpeg?alt=media&token=cf2d8fc9-74df-4591-bc20-0be03cc69f53", isCurrentUser: true, groups: ["34566","22345"]))
            .colorScheme(.dark)
        
    }
}
