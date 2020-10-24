import SwiftUI

struct TrackView: View {

    var body: some View {
        NavigationView {
            ScrollView {
                Text("Hello track")
            }
            .navigationTitle("track")
            .navigationBarColor(.spacegray)
            .background(Color.spacegray)
            .foregroundColor(.white)
        }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
