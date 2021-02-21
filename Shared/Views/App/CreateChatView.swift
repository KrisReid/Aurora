//
//  CreateChatView.swift
//  Aurora
//
//  Created by Kris Reid on 21/02/2021.
//

import SwiftUI

struct CreateChatView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var vm = CreateChatViewModel()
    
    var body: some View {
        
        VStack {
            
            ForEach(vm.users, id: \.self) { user in
                Text(user.name)
            }
        
        }
        .padding()
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView(isPresented: .constant(false))
    }
}
