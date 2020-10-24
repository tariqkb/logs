import SwiftUI

struct MissingPermissionView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Image("IconError")
                Text("i need permission to record")
                    .foregroundColor(.offWhite)
                    .font(.headline)
                Text("settings > privacy > microphone")
                    .foregroundColor(.offWhite)
                    .font(.caption)
                    .padding(5)
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
