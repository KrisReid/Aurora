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

    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2579757571, green: 0.6276962161, blue: 0.4713696837, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                VStack{
                    
                    HStack{
                        
                        Button(action: {present.wrappedValue.dismiss()}) {
                            
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Verify Phone")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if loginData.loading{ProgressView()}
                    }
                    .padding()
                    
                    Text("Code sent to \(loginData.mobileNumber)")
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .padding(.bottom)
                    
                    Spacer()
                    
                    HStack(spacing: 25){
                        
                        ForEach(0..<6,id: \.self) {index in
                            
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: loginData.verifyCode, label: {
                        Text("Send the code again")
//                                .fontWeight(.bold)
                            .foregroundColor(.black)
                    })
                    .padding()
                    
                    
                    Button(action: loginData.verifyCode, label: {
                        Text("Verify and Create Account")
                            .frame(width: UIScreen.main.bounds.width - 30,height: 50)
                    })
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)

                NumberPadView(value: $loginData.code, isVerify: true)
            }
            
            if loginData.error{
                
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // getting Code At Each Index....
    
    func getCodeAtIndex(index: Int)->String{
        
        if loginData.code.count > index{
            
            let start = loginData.code.startIndex
            
            let current = loginData.code.index(start, offsetBy: index)
            
            return String(loginData.code[current])
        }
        
        return ""
    }
        
}


struct CodeView: View {
    
    var code: String
    
    var body: some View{
        
        VStack(spacing: 10){
            
            Text(code)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title2)
                .frame(height: 45)
            
            Capsule()
                .fill(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .frame(width: 30, height: 4)
        }
    }
}



struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification(loginData: .init())
    }
}
