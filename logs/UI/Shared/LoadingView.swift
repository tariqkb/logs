import SwiftUI

struct LoadingView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var color: Color {
        get {
            return colorScheme == .light ? Color.spacegray : Color.offWhite
        }
    }
    
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color, color.opacity(0.7)]), center: .center),
                    style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                .frame(width: 50, height: 50, alignment: .center)
        }.onAppear {
            animate.toggle()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .environment(\.colorScheme, .light)
    }
}
