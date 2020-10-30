import SwiftUI
import Foundation

struct RecordingsListView: View {
    var recordings: [Recording]
    
    var body: some View {
        VStack(spacing: 0) {
            List(recordings, id: \.fileName) { recording in
                RecordingRowView(recording: recording).padding()
            }
            .overlay(
                recordings.isEmpty ?
                    VStack {
                        Image(systemName: "tray")
                            .font(.largeTitle)
                            .foregroundColor(.offestWhite)
                        Text("no recordings")
                            .font(.headline)
                            .foregroundColor(.offWhite)
                            .padding(5)
                        Text("start a recording by tapping the red button below")
                            .font(.caption)
                            .foregroundColor(.offWhite)
                    }
                :
                    nil,
                alignment: .center)
            .overlay(RecordingView(), alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct RecordingRowView: View {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }()
    static let timeIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        return formatter
    }()
    
    var recording: Recording
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(recording.fileName).font(.headline)
               
            HStack {
                Text("\(recording.date, formatter: Self.dateFormatter)")
                    .font(.footnote)
                    .foregroundColor(Color.offestWhite)
                Spacer()
                Text("\(Self.timeIntervalFormatter.string(from: recording.duration) ?? "-")")
                    .font(.footnote)
                    .foregroundColor(Color.offestWhite)
            }
        }
    }
}

struct RecordingsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsListView(
            recordings: [
//                Recording(fileName: "New Recording 2", date: Date(), duration: 808),
//                Recording(fileName: "New Recording 1", date: Date(), duration: 1808)
            ]
        ).environment(\.colorScheme, .dark)
    }
}
