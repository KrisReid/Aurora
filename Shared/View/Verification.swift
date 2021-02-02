//
//  Verification.swift
//  Aurora
//
//  Created by Kris Reid on 27/01/2021.
//

import SwiftUI

struct Verification: View {
    
    @ObservedObject var loginData : LoginViewModel
    @Environment(\.presentationMode) var present
    
    @State private var isMoving: Bool = false
    
    
    var body: some View {
        
        ZStack (alignment: .topLeading) {
            
            LinearGradient(gradient: Gradient(colors: [Color("Background_Color"), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            HStack {
                Button(action: {present.wrappedValue.dismiss()}) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                }
                if loginData.loading{ProgressView()}
            }
            .padding()
            
            VStack {
                
                ZStack {
                    Image("iPhone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding()
                    
                    Image("aurora_sms")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .onAppear() {
                            self.isMoving.toggle()
                        }
                        .offset(x: 0, y: self.isMoving ? 0 - 80 : -UIScreen.main.bounds.height - 120)
//                        .offset(x: self.isMoving ? 0 : UIScreen.main.bounds.width - 120, y: -40)
                        .animation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 10, initialVelocity: 0))
                }

                Text("Code sent to + \(loginData.getCountryCode()) \(loginData.mobileNumber)")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .padding(.bottom)
                
                TextField("Code", text: $loginData.code)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color("TextField_Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                Button(action: loginData.verifyCode, label: {
                    Text("Verify")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                })
                .foregroundColor(.white)
                .background(Color("Button_Background_Color"))
                .cornerRadius(10)
                .padding()
            }
            
            if loginData.error{
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
            
            if loginData.loading {
                IndicatorView()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $loginData.accountCreation) {
            AccountCreation(loginData: loginData)
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
    }
    
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification(loginData: .init())
        Verification(loginData: .init())
            .colorScheme(.dark)
    }
}
