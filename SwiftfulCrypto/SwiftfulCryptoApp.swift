//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Amir Lajevardi on 25/03/2025.
//
import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
