//
//  FavoritesView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 13.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        NavigationView {
            if viewModel.favoriteItems.isEmpty {
                Text("No favorites yet.")
                    .font(.favoritStdRegular(size: 18))
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.favoriteItems) { item in
                    NavigationLink(destination: destinationView(for: item)) {
                        HStack(alignment: .top, spacing: 10) {
                            if let imageUrl = URL(string: item.imageURL) {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                } placeholder: {
                                    Color.gray
                                        .frame(width: 100, height: 100)
                                }
                            } else {
                                Color.gray
                                    .frame(width: 100, height: 100)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.title)
                                    .font(.globerBlack(size: 20))
                                    .foregroundColor(.black)
                                if let movie = item.movie {
                                    Text(movie.description.stripHTML())
                                        .font(.favoritStdRegular(size: 14))
                                        .foregroundColor(.black)
                                        .lineLimit(3)
                                } else if let event = item.event {
                                    Text(event.description.stripHTML())
                                        .font(.favoritStdRegular(size: 14))
                                        .foregroundColor(.black)
                                        .lineLimit(3)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color("pastelGreen"))
            }
        }
        .navigationTitle("Favorites")
        .background(Color("pastelGreen"))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func destinationView(for item: ProgramItem) -> some View {
        if let movie = item.movie {
            return AnyView(MovieDetailView(movie: movie, viewModel: viewModel))
        } else if let event = item.event {
            return AnyView(EventDetailView(event: event, viewModel: viewModel))
        } else {
            return AnyView(EmptyView())
        }
    }
}
