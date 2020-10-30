import SwiftUI

@main struct LogsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if let voiceStore = appDelegate.voiceStore {
                Color.black
                    .overlay (
                        RootView()
                            .environmentObject(voiceStore)
                    )
                    .edgesIgnoringSafeArea(.vertical)
            }
        }
    }
}
