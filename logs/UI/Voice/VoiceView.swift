import SwiftUI

struct VoiceView: View {
    @EnvironmentObject var store: VoiceStore
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    if store.state.needsPermission {
                        MissingPermissionView()
                    } else {
                        Text("Hello world")
                    }
                    Spacer()
                }
                Spacer()
            }
            .navigationBarTitle("voice")
            .navigationBarColor(Color.spacegray)
            .background(Color.spacegray)
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                store.dispatch(.configureAudioSession(result: nil))
            })
        }
    }
}

struct VoiceView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceView()
    }
}
