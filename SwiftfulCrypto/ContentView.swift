//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Amir Lajevardi on 25/03/2025.
//

// shows four labels in different theme-defined colors
// uses a full screen background
// uses a VStack for vertical layout and a ZStack to layer the background

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 40){
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondary Text Color")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Red Color")
                    .foregroundColor(Color.theme.red)
                
                Text("Green Color")
                    .foregroundColor(Color.theme.green)
                
                
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
