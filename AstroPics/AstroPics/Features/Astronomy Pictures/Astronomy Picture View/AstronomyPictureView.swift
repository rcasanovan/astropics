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
      hasVideoContent: false,
      explanation:
        "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
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
      hasVideoContent: false,
      explanation:
        "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
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
      hasVideoContent: true,
      explanation:
        "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
    )
  )
}
