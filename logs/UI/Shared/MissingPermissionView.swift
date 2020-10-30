import SwiftUI

struct MissingPermissionView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                Text("missing permission to record")
                    .foregroundColor(.offWhite)
                    .font(.headline)
                    .padding(5)
                Text("settings > privacy > microphone")
                    .foregroundColor(.offWhite)
                    .font(.caption)
                Spacer()
            }
            Spacer()
        }
        .background(Color.spacegray)
    }
}

struct MissingPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissingPermissionView()
    }
}
