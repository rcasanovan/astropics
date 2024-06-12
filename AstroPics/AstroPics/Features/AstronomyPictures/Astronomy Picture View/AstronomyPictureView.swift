import SwiftUI

struct AstronomyPictureView: View {
  private let pictureGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.4)])

  let astronomyPicture: AstronomyPicture

  var body: some View {
    ZStack {
      if astronomyPicture.hasVideoContent {
        Color.red
          .frame(maxHeight: 140)
      } else {
        if let url = astronomyPicture.url {
          AsyncImage(url: astronomyPicture.url) { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .clipped()
            case .failure:
              Text("Failed to load image")
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .background(Color.white)
            case .empty:
              Color.white
                .frame(height: 140)
            @unknown default:
              // Handle unknown state
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
                .font(.headline)
            }
          }

          Spacer()

          Text(astronomyPicture.title)
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.bold)

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

#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPicture(
      id: "_id_0_",
      date: "2024-01-01",
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      hasVideoContent: false
    )
  )
}

#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPicture(
      id: "_id_0_",
      date: nil,
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      hasVideoContent: false
    )
  )
}

#Preview {
  AstronomyPictureView(
    astronomyPicture: AstronomyPicture(
      id: "_id_0_",
      date: "2024-01-06",
      title: "The Snows of Churyumov-Gerasimenko",
      url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
      hasVideoContent: true
    )
  )
}
