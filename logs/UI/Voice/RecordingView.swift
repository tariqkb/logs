import SwiftUI
import Foundation

struct RecordingView: View {
    @SwiftUI.State var state: State = .minimized
    @EnvironmentObject var store: VoiceStore
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                RecordingTitleView()
                
                RecordButton(color: Color.red)
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0))
            }
            Spacer()
        }
        .animation(.linear)
        .background(Color.spacegray)
        .cornerRadius(20.0)
    }
    
    enum State {
        case minimized
        case fullScreen
    }
}

struct RecordingTitleView: View {
    static let timeIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    @EnvironmentObject var store: VoiceStore
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Capsule()
                .fill(Color.offestWhite)
                .frame(width: 20, height: 5)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Text(store.state.recorder?.fileName ?? "unknown")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(5)
            Text(Self.timeIntervalFormatter.string(from: store.state.recorder?.duration ?? 0) ?? "0:00")
                .font(.footnote)
                .foregroundColor(Color.offestWhite)
            Text("\(store.state.recorder?.duration ?? 0)")
                .font(.footnote)
                .foregroundColor(Color.offestWhite)
        }
    }
}

struct FullScreenRecordingView: View {
    var body: some View {
        Text("fullscreen")
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .fill(Color.black)
            .overlay(RecordingView(), alignment: .bottom)
            .edgesIgnoringSafeArea(.all)
            .environmentObject(VoiceStore())
    }
}
