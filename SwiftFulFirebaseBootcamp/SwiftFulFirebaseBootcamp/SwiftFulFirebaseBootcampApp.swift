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
    
    /// the code below is not being used because we are going to use the default implementation for swiftUI
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// Below you can see how to setup the firebase using the AppDelegate (we won't use it becase we already did it on the code above)
/*
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configured Firebase!")

    return true
  }
}

*/
