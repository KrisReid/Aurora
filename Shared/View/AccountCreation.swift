//
//  AccountCreation.swift
//  Aurora
//
//  Created by Kris Reid on 30/01/2021.
//

import SwiftUI

struct AccountCreation: View {
    
    @ObservedObject var loginData : LoginViewModel
    
//    @State private var image: Image?
//    @State private var showingImagePicker = false
//    @State private var inputImage: UIImage?
    
    var body: some View {
        
        ZStack (alignment: .topLeading) {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    if loginData.image != nil {
                        loginData.image?
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding()
                    } else {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding()
                            .font(.system(size: 1, weight: .ultraLight))
                    }
                }
                .onTapGesture {
                    loginData.showingImagePicker = true
                }

                
                TextField("Name", text: $loginData.name)
                    .keyboardType(.default)
                    .padding()
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                
                Button(action: {

                    if loginData.name != "" {
                        
                        loginData.CreateUser(image: loginData.inputImage!) { (status) in
                            if status {

                            }
                        }
                    }
                    
                }) {
                    Text("Create an account")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(10)
                .padding()
                
            }
            
            .sheet(isPresented: $loginData.showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $loginData.inputImage)
            }
            
        }
        
    }
    
    func loadImage() {
        guard let inputImage = loginData.inputImage else { return }
        loginData.image = Image(uiImage: inputImage)
    }
    
}

struct AccountCreation_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreation(loginData: .init())
    }
}
