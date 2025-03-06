//
//  QuokkaApp.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/24/25.
//

//quokka-bc53d

import SwiftUI
import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct QuokkaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var user: User = User()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
