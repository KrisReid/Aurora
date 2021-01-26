//
//  AuroraApp.swift
//  Shared
//
//  Created by Kris Reid on 26/01/2021.
//

import SwiftUI
import Firebase

@main
struct AuroraApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}


class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        return
    }

    
}
