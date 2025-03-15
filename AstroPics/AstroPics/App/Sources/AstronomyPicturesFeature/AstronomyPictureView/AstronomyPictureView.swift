import SwiftUI

public struct AstronomyPictureView: View {
  private let pictureGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.4)])

  let astronomyPicture: AstronomyPictureModel
  let isLoadingImagesEnabled: Bool

  public var body: some View {
    ZStack {
      if astronomyPicture.contentType == .video {
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
              if astronomyPicture.contentType == .video {
                Image.playIcon
                  .resizable()
                  .frame(width: 15, height: 15)
                  .foregroundColor(.white)
              }
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
    astronomyPicture: AstronomyPictureModel(
      id: "_id_0_",
      date: "2024-01-01",
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      contentType: .image,
      explanation:
        "Can a rocket make the Moon ripple?."
    ),
    isLoadingImagesEnabled: true
  )
}

/// Preview for AstronomyPicture item without date
#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPictureModel(
      id: "_id_0_",
      date: nil,
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      contentType: .image,
      explanation:
        "Can a rocket make the Moon ripple?."
    ),
    isLoadingImagesEnabled: true
  )
}

/// Preview for AstronomyPicture item with video
#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPictureModel(
      id: "_id_0_",
      date: "2024-01-06",
      title: "The Snows of Churyumov-Gerasimenko",
      url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
      contentType: .video,
      explanation:
        "Can a rocket make the Moon ripple?."
    ),
    isLoadingImagesEnabled: true
  )
}

#endif
