import SwiftUI

struct RecordButton: View {
    
    @EnvironmentObject var store: VoiceStore
    var color: Color
    
    var state: State {
        get {
            if let recorder = store.state.recorder?.recorder {
                if recorder.isRecording {
                    return .recording
                } else {
                    return .paused
                }
            } else {
                return .start
            }
        }
    }
    
    var body: some View {
        Button("") {
            switch state {
            case .start:
                store.dispatch(.newRecorder(fileName: newRecordingFileName()))
                store.state.recorder?.recorder.record()
            case .paused:
                store.state.recorder?.recorder.record()
            case .recording:
                store.state.recorder?.recorder.pause()
            }
        }
        .buttonStyle(RecordButtonStyle(styleParams: styleParams))
    }
    
    enum State: Int {
        case start
        case recording
        case paused
    }
    
    struct RecordButtonStyle: ButtonStyle {
        var styleParams: StyleParams
        static let animationTime = 0.5
        
        func makeBody(configuration: ButtonStyle.Configuration) -> some View {
            Capsule()
                .stroke(lineWidth: 4)
                .foregroundColor(styleParams.borderColor)
                .frame(width: styleParams.width, height: 75)
                .animation(.easeOut(duration: Self.animationTime))
                .overlay(
                    Capsule()
                        .fill(!configuration.isPressed ? styleParams.fillColor : styleParams.fillColor.opacity(0.5))
                        .frame(width: styleParams.width - 10, height: 65)
                        .animation(.easeOut(duration: Self.animationTime))
                        .overlay(styleParams.overlay, alignment: .center),
                    alignment: .center
                )
        }
    }
    
    typealias StyleParams = (width: CGFloat, borderColor: Color, fillColor: Color, overlay: AnyView?)
    
    var styleParams: StyleParams {
        get {
            switch state {
            case .start:
                return (
                    width: 75,
                    borderColor: .white,
                    fillColor: .red,
                    overlay: nil
                )
            case .recording:
                return (
                    width: 175,
                    borderColor: .white,
                    fillColor: .clear,
                    overlay: AnyView(
                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.red)
                                .frame(width: 10, height: 30, alignment: .center)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.red)
                                .frame(width: 10, height: 30, alignment: .center)
                        }
                    )
                )
            case .paused:
                return (
                    width: 175,
                    borderColor: .mutedOrange,
                    fillColor: Color.mutedOrange.opacity(0.6),
                    overlay: AnyView(Text("RESUME").fontWeight(.bold))
                )
            }
        }
    }
}
