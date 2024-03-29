//
//  Verification.swift
//  Aurora
//
//  Created by Kris Reid on 27/01/2021.
//

import SwiftUI

struct Verification: View {
    
    @ObservedObject var loginVM : LoginViewModel
    
    @Environment(\.presentationMode) var present
    @Environment(\.colorScheme) var colorScheme
    
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
                if loginVM.loading{ProgressView()}
            }
            .padding()
            
            VStack {
                
                ZStack {
                    Image("iPhone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding()
                    
                    Image(colorScheme == .dark ? "aurora_sms_dark" : "aurora_sms")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .onAppear() {
                            self.isMoving.toggle()
                        }
                        .offset(x: 0, y: self.isMoving ? 0 - 80 : -UIScreen.main.bounds.height - 120)
                        .animation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 10, initialVelocity: 0))
                }

                Text("Code sent to + \(loginVM.getCountryCode()) \(loginVM.mobileNumber)")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .padding(.bottom)
                
                TextField("Code", text: $loginVM.code)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(Color("TextField_Text_Color"))
                    .background(Color("TextField_Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                Button(action: loginVM.verifyCode, label: {
                    Text("Verify")
                        .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                })
                .foregroundColor(Color("Button_Text_Color"))
                .background(Color("Button_Background_Color"))
                .cornerRadius(10)
                .padding()
            }
            
            if loginVM.error{
                AlertView(msg: loginVM.errorMsg, show: $loginVM.error)
            }
            
            if loginVM.loading {
                IndicatorView()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $loginVM.accountCreation) {
            AccountCreation(loginVM: loginVM)
        }
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
    }
    
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification(loginVM: .init())
        Verification(loginVM: .init())
            .colorScheme(.dark)
    }
}
