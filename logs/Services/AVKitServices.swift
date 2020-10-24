import AVKit

func requestAudioPermission(_ grantedClosure: @escaping (Bool) -> Void) {
    AVAudioSession.sharedInstance().requestRecordPermission { granted in
        DispatchQueue.main.async {
            grantedClosure(granted)
        }
    }
}

func configureAudioSession() -> (Void, Error?) {
    let audioSession = AVAudioSession.sharedInstance()
        
    do {
        try audioSession.setCategory(.playAndRecord, mode: .default, options: [.duckOthers])
        try audioSession.setActive(true, options: [.notifyOthersOnDeactivation])
        audioSession.
        return ((), nil)
    } catch let error {
        print("[error] configureAudioSession - \(error)")
        return ((), error)
    }
}
