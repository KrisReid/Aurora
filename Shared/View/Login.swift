//
//  Login.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth

struct Login: View {
    
    
    @StateObject var loginData = LoginViewModel()
    @State var mobileNumber = ""
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Image("aurora_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("Welcome to Aurora")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(#colorLiteral(red: 0.9063871503, green: 0.9065392613, blue: 0.9063671231, alpha: 1)))
                    .padding(.top, 50)
                
                Text("Please enter your mobile number")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(Color(#colorLiteral(red: 0.9063871503, green: 0.9065392613, blue: 0.9063671231, alpha: 1)))
                    .padding(.top, 6)
                
                
                HStack{
                    
                    Text("+ \(loginData.getCountryCode())")
                        .frame(width: 45)
                        .padding()
                        .background(Color("TextField_Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    TextField("Number", text: $mobileNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("TextField_Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                } .padding(.top, 15)
                
                
                
                
                NavigationLink(destination: Verification(loginData: loginData),isActive: $loginData.gotoVerify) {
                    
                    Text("")
                        .hidden()
                }
                
                Button(action: loginData.sendCode, label: {
                    Text("Continue")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                })
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(10)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .padding()
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
        if loginData.error{
            AlertView(msg: loginData.errorMsg, show: $loginData.error)
        }
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
