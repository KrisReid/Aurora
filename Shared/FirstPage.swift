//
//  FirstPage.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//


//FirstPage

import SwiftUI
import Firebase

struct FirstPage : View {
    
    @State var countryCode = ""
    @State var mobileNumber = ""
    @State var show = false
    @State var message = ""
    @State var alert = false
    @State var ID = ""
    
    var body : some View{
        
        VStack(spacing: 20){
            
            Image("OTP_Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(x:20)
                .padding()
            
            Text("Verify Your Number").font(.largeTitle).fontWeight(.heavy)
            
            Text("Please Enter Your Number To Verify Your Account")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)
            
            HStack{
                
                TextField("+1", text: $countryCode)
                    .keyboardType(.numberPad)
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

            
//            NavigationLink(destination: SecondPage(show: $show), isActive: $show) {
            NavigationLink(destination: SecondPage(show: $show, ID: $ID), isActive: $show) {
                
                Button(action: {
                    
                    // remove this when testing with real Phone Number
                                        
                    Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                    PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.countryCode+self.mobileNumber, uiDelegate: nil) { (ID, err) in
                        
                        if err != nil{
                            
                            self.message = (err?.localizedDescription)!
                            self.alert.toggle()
                            return
                        }
                        
                        self.ID = ID!
                        self.show.toggle()
                    }
                }) {
                    Text("Send").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(10)
            }

            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }.padding()
        .alert(isPresented: $alert) {

            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
        }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
//            .colorScheme(.dark)
    }
}
