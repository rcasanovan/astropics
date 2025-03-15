import SwiftUI

public struct HeaderView: View {
  public init() {}

  public var body: some View {
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

struct HeaderView_Preview {
  struct Preview: View {
    var body: some View {
      HeaderView()
    }
  }
}

#Preview {
  HeaderView()
}

#endif
