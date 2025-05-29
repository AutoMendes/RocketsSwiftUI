// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var rockets: [Rocket] = []
    @State private var expandedRocketID: String?

    var body: some View {
        NavigationView {
            List(rockets) { rocket in
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { expandedRocketID == rocket.id },
                        set: { expandedRocketID = $0 ? rocket.id : nil }
                    ),
                    content: {
                        Text(rocket.description)
                            .font(.subheadline)
                            .padding(.vertical, 4)
                    },
                    label: {
                        VStack(alignment: .center) {
                            if let imageUrl = rocket.flickr_images.first, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Text(rocket.name)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.top, 8)
                        }
                        .frame(maxWidth: .infinity)
                    }
                )
                .padding(.vertical, 8)
            }
            .onAppear {
                APIService().fetchRockets { result in
                    if let result = result {
                        self.rockets = result
                    }
                }
            }
            .navigationTitle("SpaceX Rockets")
        }
    }
}

#Preview {
    ContentView()
}
