import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var store: VoiceStore
    
    var error: Error
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("an error has occurred")
                .font(.headline)
                .foregroundColor(.offWhite)
                .padding(10)
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundColor(.offWhite)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                store.dispatch(.clearError)
            }) {
                Text("ack")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(20)
            }
                
        }.padding(20)

    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: GenericError.error)
            .environment(\.colorScheme, .light)
    }
}

enum GenericError: Error {
    case error
}
