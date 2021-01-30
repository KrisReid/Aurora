//
//  AccountCreation.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import SwiftUI

struct AccountCreation: View {
    
    @ObservedObject var loginData : LoginViewModel
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = Image(systemName: "camera.circle")
    
    var body: some View {
        
        ZStack (alignment: .topLeading) {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    self.showImagePicker = true
                }) {
                    image?
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding()
                        .font(.system(size: 1, weight: .ultraLight))
                    
                }
                
                TextField("Name", text: $loginData.name)
                    .keyboardType(.default)
                    .padding()
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                Button(action: loginData.createAccount, label: {
                    Text("Create Account")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                })
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(10)
                .padding()
                
            }.sheet(isPresented: self.$showImagePicker) {
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
            }
            
        }
        
    }
}

struct AccountCreation_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreation(loginData: .init())
    }
}
