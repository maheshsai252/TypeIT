import SwiftUI

struct HeadingView: View {
    var title: String
    var colors: [Color] = [.brown,.cyan]
    var imageName: String
    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).mask {
            HStack{
                Image(systemName: imageName)
                Text(title)
                    .padding()
                    .font(.custom("AmericanTypeWriter", size: 25))
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
            }
            
        }.frame(height: 50)
    }
}

