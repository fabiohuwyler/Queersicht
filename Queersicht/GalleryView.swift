//
//  GalleryView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import SwiftUI

struct GalleryView: View {
    var items: [GalleryItem]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { item in
                    NavigationLink(destination: item.destinationView) {
                        VStack {
                            ZStack {
                                if let imageUrl = URL(string: item.imageURL) {
                                    AsyncImage(url: imageUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 150)
                                            .cornerRadius(10)
                                    } placeholder: {
                                        Color.gray
                                            .frame(height: 150)
                                            .cornerRadius(10)
                                    }
                                } else {
                                    Color.gray
                                        .frame(height: 150)
                                        .cornerRadius(10)
                                }
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(5)
                                    .padding(5)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
            }
            .padding()
        }
    }
}

struct GalleryItem: Identifiable {
    var id = UUID()
    var title: String
    var imageURL: String
    var destinationView: AnyView
}
