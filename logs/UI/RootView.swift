//
//  AppList.swift
//  logs
//
//  Created by Tariq Bugrara on 10/17/20.
//  Copyright © 2020 tkb. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    NavigationLink(destination: VoiceView()) {
                        AppIcon(name: "voice", color: .black)
                    }
                    NavigationLink(destination: TrackView()) {
                        AppIcon(name: "track", color: .black)
                    }
                }
            }
            .navigationBarTitle("apps")
            .navigationBarColor(.spacegray)
            .background(Color.spacegray)
        }
    }
}

struct AppIcon: View {
    var name: String
    var color: Color
    
    var body: some View {
        VStack {
            Color.spacegray
                .frame(width: 120, height: 120)
                .cornerRadius(155)
                .overlay(
                    RoundedRectangle(cornerRadius: 155)
                        .stroke(Color.yellow, lineWidth: 10)
                )
                .padding()
            
            Text(name)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
