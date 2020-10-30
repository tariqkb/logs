import SwiftUI

struct VoiceView: View {
    @EnvironmentObject var store: VoiceStore
    
    var body: some View {
        ZStack {
            if store.state.needsPermission {
                MissingPermissionView()
            } else if let recordings = store.state.recordings {
                RecordingsListView(recordings: recordings)
            }
        }
        .navigationBarTitle("voice")
        .foregroundColor(.white)
        .onAppear(perform: {
            store.dispatch(.configureAudioSession(result: nil))
            store.dispatch(.loadRecordings)
        })
        .popover(isPresented: !store.state.errors.isEmpty ? Binding.constant(true) : Binding.constant(false)) {
            ErrorView(error: store.state.errors[0])
        }
    }
}

struct VoiceView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceView()
            .environmentObject(VoiceStore(VoiceState()))
            .environment(\.colorScheme, .dark)
    }
}
