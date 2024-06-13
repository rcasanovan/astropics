import SwiftUI

struct AstronomyPictureView: View {
  private let pictureGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.4)])

  let astronomyPicture: AstronomyPicture
  let isLoadingImagesEnabled: Bool

  var body: some View {
    ZStack {
      if astronomyPicture.hasVideoContent {
        Color.black
          .frame(maxHeight: 140)
      } else {
        if let url = astronomyPicture.url, isLoadingImagesEnabled {
          AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .clipped()
            case .failure:
              Color.black
                .frame(height: 140)
            case .empty:
              Color.white
                .frame(height: 140)
            @unknown default:
              EmptyView()
            }
          }
        } else {
          Color.gray
            .frame(maxHeight: 140)
        }
      }

      if astronomyPicture.url != nil {
        LinearGradient(
          gradient: pictureGradient,
          startPoint: .top,
          endPoint: .bottom
        )
        .frame(maxWidth: .infinity)
        .frame(height: 140)
      }

      HStack {
        VStack(alignment: .leading) {
          if let date = astronomyPicture.date {
            HStack {
              Spacer()

              Text(date)
                .foregroundColor(.white)
                .font(.subheadline)
            }
          }

          Spacer()

          Text(astronomyPicture.title)
            .foregroundColor(.white)
            .font(.subheadline)
        }
        .padding(16)

        Spacer()
      }
    }
    .frame(maxWidth: .infinity)
    .frame(height: 140)
    .background(.yellow)
  }
}

#if DEBUG

// MARK: Previews

/// Preview for AstronomyPicture item with date
#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPicture(
      id: "_id_0_",
      date: "2024-01-01",
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      hasVideoContent: false,
      explanation:
        "Can a rocket make the Moon ripple?."
    ),
    isLoadingImagesEnabled: true
  )
}

/// Preview for AstronomyPicture item without date
#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPicture(
      id: "_id_0_",
      date: nil,
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      hasVideoContent: false,
      explanation:
        "Can a rocket make the Moon ripple?."
    ),
    isLoadingImagesEnabled: true
  )
}

/// Preview for AstronomyPicture item with video
#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPicture(
      id: "_id_0_",
      date: "2024-01-06",
      title: "The Snows of Churyumov-Gerasimenko",
      url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
      hasVideoContent: true,
      explanation:
        "Can a rocket make the Moon ripple?."
    ),
    isLoadingImagesEnabled: true
  )
}

#endif
