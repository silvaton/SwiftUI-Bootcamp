//
//  SwiftFulFirebaseBootcampApp.swift
//  SwiftFulFirebaseBootcamp
//
//  Created by Ton Silva on 20/2/24.
//

import SwiftUI
import Firebase

@main
struct SwiftFulFirebaseBootcampApp: App {
    
    /// the code below is not being used because we are going to use the AppDelegate
//    init() {
//        FirebaseApp.configure()
//        print("Configured Firebase!")
//    }
    
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}


// Below you can see how to setup the firebase using the AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configured Firebase!")

    return true
  }
}
