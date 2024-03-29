//
//  Login.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import FirebaseAuth

struct Login: View {
    
    @ObservedObject var loginVM = LoginViewModel()

    var body: some View {
                
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("Background_Color"), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Image("aurora_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("Welcome to Aurora")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("Text_Color"))
                    .padding(.top, 50)
                
                Text("Please enter your mobile number")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(Color("Text_Color"))
                    .padding(.top, 6)
                
                
                HStack{
                    
                    Text("+ \(loginVM.getCountryCode())")
                        .frame(width: 45)
                        .padding()
                        .foregroundColor(Color("TextField_Text_Color"))
                        .background(Color("TextField_Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    TextField("Number", text: $loginVM.mobileNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .foregroundColor(Color("TextField_Text_Color"))
                        .background(Color("TextField_Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                } .padding(.top, 15)
                
                
                NavigationLink(destination: Verification(loginVM: loginVM),isActive: $loginVM.gotoVerify) {
                    
                    Button(action: loginVM.sendCode, label: {
                        Text("Continue")
                            .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                    })
                    .foregroundColor(Color("Button_Text_Color"))
                    .background(Color("Button_Background_Color"))
                    .cornerRadius(10)
                    .padding(.top, 20)
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .padding()
            
            if loginVM.loading {
                IndicatorView()
            }
            
            if loginVM.error{
                AlertView(msg: loginVM.errorMsg, show: $loginVM.error)
            }
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
        Login()
            .colorScheme(.dark)
    }
}
