// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var rockets: [Rocket] = []

    var body: some View {
        List(rockets) { rocket in
            VStack(alignment: .leading) {
                if let imageUrl = rocket.flickr_images.first, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text(rocket.name).font(.headline)
                Text(rocket.description).font(.subheadline)
            }
            .padding(.vertical, 8)
        }
        .onAppear {
            APIService().fetchRockets { result in
                if let result = result {
                    self.rockets = result
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
