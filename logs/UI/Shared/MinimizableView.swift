import SwiftUI

// Two states
// 1. minimized view (variable height container) gesture up to open full screen
// 2. fullscreen view gesture down to minimize
struct MinimizableView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MinimizableView_Previews: PreviewProvider {
    static var previews: some View {
        MinimizableView()
    }
}
