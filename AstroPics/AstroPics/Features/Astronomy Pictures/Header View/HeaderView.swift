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

struct HeaderView_Previews: PreviewProvider {
  struct Preview: View {
    var body: some View {
      HeaderView()
    }
  }

  static var previews: some View {
    Preview()
  }
}

#endif
