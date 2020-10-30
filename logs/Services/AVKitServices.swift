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

        return ((), nil)
    } catch let error {
        print("[error] configureAudioSession - \(error)")
        return ((), error)
    }
}

struct Recording {
    var fileName: String
    var date: Date
    var duration: TimeInterval
    var path: URL?
}

class Recorder: NSObject, ObservableObject, AVAudioRecorderDelegate {
    
    @Published var fileName: String
    @Published var duration: TimeInterval = 0
    
    var recorder: AVAudioRecorder
//    var player: AVAudioPlayer
    
    private var durationDisplayLink: CADisplayLink? = nil
    
    init(fileName: String) throws {
        
        var settings: [String: Any]  = [String: String]()
        settings[AVFormatIDKey] = kAudioFormatLinearPCM
        settings[AVSampleRateKey] = 8000.0
        settings[AVNumberOfChannelsKey] = 1
        settings[AVLinearPCMBitDepthKey] = 16
        settings[AVLinearPCMIsBigEndianKey] = false
        settings[AVLinearPCMIsFloatKey] = false

        let directoryURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directoryURL.appendingPathComponent(fileName).appendingPathExtension("aif")
        
        print("[new Recorder] fileURL=\(fileURL)")
        
        self.fileName = fileName
        self.recorder = try AVAudioRecorder(url: fileURL, settings: settings)
//        self.player = try AVAudioPlayer(contentsOf: fileURL)
        
        super.init()
        
        self.durationDisplayLink = CADisplayLink(target: self, selector: #selector(syncDuration))
        durationDisplayLink?.add(to: .current, forMode: .common)

        recorder.delegate = self;
        
        recorder.isMeteringEnabled = true;
    }
    
    deinit {
        self.durationDisplayLink?.invalidate()
    }
    
    @objc private func syncDuration() {
        print("syncing duration=\(self.recorder.currentTime)")
        self.duration = self.recorder.currentTime
    }
}

func listRecordings() throws -> [Recording] {
    let directoryURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    let recordings = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
        .map { url in
            Recording(fileName: url.lastPathComponent, date: Date(), duration: 0, path: url)
        }
    
    return recordings
}

func newRecordingFileName() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E',' MMM d yyyy 'at' H:mm"
    
    return formatter.string(from: Date())
}
