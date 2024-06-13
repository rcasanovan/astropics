import SwiftUI

struct HeaderView: View {
  var body: some View {
    HStack {
      Spacer()
      Image("NASAIcon")
        .resizable()
        .scaledToFit()
        .foregroundColor(.white)
        .frame(height: 30)
        .padding()
        .clipped()
      Spacer()
    }
    .padding([.horizontal, .bottom])
    .background(.black)
  }
}

#if DEBUG

// MARK: Previews

#Preview {
  HeaderView()
}

#endif
