//
//  ChatView.swift
//  Aurora
//
//  Created by Kris Reid on 22/02/2021.
//

import SwiftUI

struct ChatView: View {
    
    let user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User(id: "12345", name: "Sandra Belle", mobileNumber: "07432426798", imageUrl: "Sandra", isCurrentUser: true, groups: ["34566","22345"]))
    }
}
