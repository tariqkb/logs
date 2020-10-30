import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var voiceStore: VoiceStore?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.voiceStore = VoiceStore()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if let voiceStore = self.voiceStore {
            
            if let recorder = voiceStore.state.recorder {
                if recorder.recorder.isRecording {
                    print("[AppDelegate] stopping recording due to applicationWillResignActive")
                    recorder.recorder.stop()
                }
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if let voiceStore = self.voiceStore {
            
            if let recorder = voiceStore.state.recorder {
                if recorder.recorder.isRecording {
                    print("[AppDelegate] stopping recording due to applicationWillTerminate")
                    recorder.recorder.stop()
                }
            }
        }
    }
}

