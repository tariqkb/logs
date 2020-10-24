import AVKit

struct VoiceState {
    var needsPermission: Bool = false
    var error: Error? = nil
}

enum VoiceAction {
    case configureAudioSession(result: (needsPermission: Bool, error: Error?)?)
}

class VoiceStore: ObservableObject {
    
    @Published var state: VoiceState = VoiceState()
    
    func dispatch(_ action: VoiceAction) {
        print("[VoiceStore] dispatching action=\(action)")
        
        switch action {
        case .configureAudioSession(let result):
            if let result = result {
                self.state.needsPermission = result.needsPermission
                self.state.error = result.error
            } else {
                requestAudioPermission { granted in
                    if (granted) {
                        let (_, error) = configureAudioSession()
                        self.dispatch(.configureAudioSession(result: (needsPermission: false, error: error)))
                    } else {
                        self.dispatch(.configureAudioSession(result: (needsPermission: true, error: nil)))
                    }
                }
            }
        }
    }
}
