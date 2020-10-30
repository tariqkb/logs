import SwiftUI

extension Color {
    public static let spacegray = Color(hue: 0, saturation: 0.0, brightness: 0.10)
    public static let offWhite = Color(hue: 0, saturation: 0.0, brightness: 0.88)
    public static let evenMoreOffWhite = Color(hue: 0, saturation: 0.0, brightness: 0.78)
    public static let offestWhite = Color(hue: 0, saturation: 0.0, brightness: 0.58)
    
    public static let mutedOrange = Color(hue: 9.0/365, saturation: 0.58, brightness: 0.93)
}

struct Palette_Preview: PreviewProvider {
    static var previews: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            Rectangle().fill(Color.spacegray).frame(height: 50).overlay(Text("spacegray"))
            Rectangle().fill(Color.offWhite).frame(height: 50).overlay(Text("offWhite"))
            Rectangle().fill(Color.evenMoreOffWhite).frame(height: 50).overlay(Text("evenMoreOffWhite"))
            Rectangle().fill(Color.offestWhite).frame(height: 50).overlay(Text("offestWhite"))
            Rectangle().fill(Color.mutedOrange).frame(height: 50).overlay(Text("mutedOrange"))
        }.environment(\.colorScheme, .dark)
        
    }
}
