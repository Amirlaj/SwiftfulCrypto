//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Amir Lajevardi on 25/03/2025.
//
import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        
        
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
