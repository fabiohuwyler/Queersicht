//
//  LocationView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 13.07.2024.
//

import SwiftUI

struct LocationView: View {
    var location: Location

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let imageUrl = URL(string: location.imageURL ?? "") {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                }
            } else {
                Color.gray
                    .frame(height: 200)
            }

            Text(location.name)
                .font(.globerBlack(size: 24))
                .bold()

            Text(location.address)
                .font(.favoritStdRegular(size: 16))

            if !location.description.isEmpty {
                Text(location.description)
                    .font(.favoritStdRegular(size: 16))
            }

            if !location.accessibilityInfo.isEmpty {
                Text("Accessibility Information")
                    .font(.globerBlack(size: 20))
                    .bold()
                Text(location.accessibilityInfo)
                    .font(.favoritStdRegular(size: 16))
            }
        }
        .padding()
    }
}
