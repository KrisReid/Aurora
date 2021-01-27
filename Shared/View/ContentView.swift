//
//  ContentView.swift
//  Shared
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI

struct ContentView: View {
    
//    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//
//    var body: some View {
//
//        VStack{
//
//            if status{
//                NavigationView {
//                    Home()
//                }
//            }
//            else{
//                NavigationView{
//                    Login()
//                }
//            }
//        }.onAppear {
//
//            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
//
//                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//
//                self.status = status
//            }
//        }
//
//
//    }
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        
        ZStack{
            
            if status{
                
                Home()
            }
            else{
                
                NavigationView{
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

