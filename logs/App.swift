//
//  ContentView.swift
//  logs
//
//  Created by Tariq Bugrara on 10/15/20.
//  Copyright © 2020 tkb. All rights reserved.
//

import SwiftUI

@main struct LogsApp: App {
    @StateObject var store: VoiceStore = VoiceStore()
    
    var body: some Scene {
        WindowGroup {
            Color.black
                .overlay (
                    RootView().environmentObject(store)
                )
                .edgesIgnoringSafeArea(.vertical)
        }
    }
}
