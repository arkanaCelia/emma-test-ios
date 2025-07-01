//
//  emma_test_iosApp.swift
//  emma-test-ios
//
//  Created by Celia Pérez Vargas on 26/6/25.
//

import SwiftUI

@main
struct emma_test_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
