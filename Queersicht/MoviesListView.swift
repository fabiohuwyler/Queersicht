//
//  MoviesListView.swift
//  Queersicht
//
//  Created by Fabio Huwyler on 10.07.2024.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: ProgramListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                    HStack(alignment: .top, spacing: 10) {
                        if let imageUrl = URL(string: movie.imageURL) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } placeholder: {
                                Color.pastelPink
                                    .frame(width: 100, height: 100)
                            }
                        } else {
                            Color.pastelPink
                                .frame(width: 100, height: 100)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(movie.title)
                                .font(.globerBlack(size: 20))
                                .foregroundColor(.black)
                            Text(movie.description.stripHTML())
                                .font(.favoritStdRegular(size: 14))
                                .foregroundColor(.black)
                                .lineLimit(3)
                        }
                    }
                    .padding(.vertical, 10)
                }
                .listRowBackground(Color.pastelPink)
            }
            .listStyle(PlainListStyle())
            .background(Color.pastelPink)
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

