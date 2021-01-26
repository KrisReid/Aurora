//
//  SecondPage.swift
//  Aurora
//
//  Created by Kris Reid on 26/01/2021.
//


import SwiftUI
import Firebase

struct SecondPage : View {
    
    @State var code = ""
    @Binding var show : Bool
    @Binding var ID : String
    @State var message = ""
    @State var alert = false
//    @State var creation = false
//    @State var loading = false
    
    var body : some View{
        
        ZStack(alignment: .topLeading) {
            
            GeometryReader{_ in
                
                VStack(spacing: 20){
                    
                    Image("OTP_Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(x:20)
                        .padding()
                    
                    Text("Verification Code").font(.largeTitle).fontWeight(.heavy)
                    
                    Text("Please Enter The Verification Code")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 12)

                    TextField("Code", text: self.$code)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color("Color"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 15)

                    
//                    if self.loading{
//
//                        HStack{
//
//                            Spacer()
//
////                            Indicator()
//
//                            Spacer()
//                        }
//                    }
//
//                    else {
                        
                        Button(action: {
                             
//                            self.loading.toggle()
                        
                            let credential =  PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                             
                             Auth.auth().signIn(with: credential) { (res, err) in
                                 
                                 if err != nil{
                                     
                                     self.message = (err?.localizedDescription)!
                                     self.alert.toggle()
//                                     self.loading.toggle()
                                     return
                                 }
                     
//                                 checkUser { (exists, user,uid,pic) in
//
//                                     if exists {
                                         
                                         UserDefaults.standard.set(true, forKey: "status")
                                         
//                                         UserDefaults.standard.set(user, forKey: "UserName")
//
//                                         UserDefaults.standard.set(uid, forKey: "UID")
//
//                                         UserDefaults.standard.set(pic, forKey: "pic")
                                         
                                         NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                                     }
//
//                                     else{
//
//                                         self.loading.toggle()
//                                         self.creation.toggle()
//                                     }
//                                 }
//                                 
                                 
                             }
                             
                         }) {
                             
                             Text("Verify").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                             
                         }.foregroundColor(.white)
                         .background(Color.orange)
                         .cornerRadius(10)
                    
//
//                    }
//
                    
                }
                
            }
            
            Button(action: {
                
                self.show.toggle()
                
            }) {
                
                Image(systemName: "chevron.left").font(.title)
                
            }.foregroundColor(.orange)
            
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
        }
//        .sheet(isPresented: self.$creation) {
//
//            AccountCreation(show: self.$creation)
//        }
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage(show: .constant(true), ID: .constant("123"))
    }
}
