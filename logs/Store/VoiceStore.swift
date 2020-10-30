import AVKit

struct VoiceState {
    var errors: [Error] = []
    var loading: Bool = false
    
    var needsPermission: Bool = false
    var recordings: [Recording]? = nil
    
    var recorder: Recorder? = nil
}

enum VoiceAction {
    case clearError
    case configureAudioSession(result: (needsPermission: Bool, error: Error?)?)
    case loadRecordings
    case newRecorder(fileName: String)
    case endRecording
}

class VoiceStore: ObservableObject {
    
    @Published var state: VoiceState;
    
    init(_ state: VoiceState = VoiceState()) {
        self.state = state
    }
    
    func dispatch(_ action: VoiceAction) {
        print("[VoiceStore] dispatching action=\(action)")
        
        switch action {
        case .clearError:
            self.state.errors.removeFirst()
        case .configureAudioSession(let result):
            if let result = result {
                self.state.needsPermission = result.needsPermission
                if let error = result.error {
                    self.state.errors.append(error)
                }
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
        case .loadRecordings:
//            self.state.recordings = [Recording(fileName: "New Recording 2", date: Date(), duration: 808),Recording(fileName: "New Recording 1", date: Date(), duration: 1808)]
            do {
                self.state.recordings = try listRecordings()
            } catch let error {
                print("[VoiceStore] error while loading recordings error=\(error.localizedDescription)")
                self.state.recordings = nil;
                self.state.errors.append(error)
            }
        case .newRecorder(let fileName):
            do {
                self.state.recorder = try Recorder(fileName: fileName)
            } catch let error {
                print("[VoiceStore] error creating recorder for fileName=\(fileName) error=\(error.localizedDescription)")
                self.state.errors.append(error)
            }
        case .endRecording:
            self.state.recorder = nil
        }
    }
}
