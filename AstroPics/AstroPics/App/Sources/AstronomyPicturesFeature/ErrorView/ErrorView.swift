import SwiftUI

public struct ErrorView: View {
  let error: String
  let didTapOnReload: (() -> Void)

  public init(error: String, didTapOnReload: @escaping () -> Void) {
    self.error = error
    self.didTapOnReload = didTapOnReload
  }

  public var body: some View {
    VStack(alignment: /*@START_MENU_TOKEN@*/ .center /*@END_MENU_TOKEN@*/) {
      Image.errorIcon
        .resizable()
        .frame(width: 80, height: 80)

      Text("Something went wrong. Please try again")
        .foregroundColor(.black)
        .font(.title2)
        .padding(.horizontal, 40)
        .multilineTextAlignment(.center)

      VStack {
        Text(error)
          .foregroundColor(.white)
          .font(.title3)
          .padding(.horizontal, 10)
          .multilineTextAlignment(.center)
          .padding()
      }
      .background(.gray)
      .cornerRadius(12)
      .padding(.horizontal, 40)
      .padding(.top, 10)

      Button(
        action: {
          didTapOnReload()
        },
        label: {
          Text("reload")
            .foregroundColor(.white)
            .padding(10)
            .background(Color.blue)
            .cornerRadius(10)
        }
      )
      .padding(.top, 20)
    }
  }
}

#if DEBUG

// MARK: Previews

#Preview {
  ErrorView(
    error: "Localized description for the error",
    didTapOnReload: {}
  )
}

#endif
